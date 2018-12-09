Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62040C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:27:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5F620645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c1bIlN7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5F620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3QGfTLQpMyADK64MkJND5lIbSWnvj8z0xqoK++e1mo8=; b=c1bIlN7N/Ia0I4
	YjbUOe5PbdTIWEF5fyagyrzWsdKOmmPsof7j0L5sWyZsLKgndEzFGgepA8n5NhuOaooBgiLB3YCAW
	1ROjO/L6jyWff6dsEHGiTmop5rJdRushWicSKkZ2acDaSeOSVcq0D8ze6ncyaHM9naEGy7fmqREKA
	4Qnjg2Zvm87bQeLe2bQAt5mLPNiCWTLoTxDi6j1YIKl6pZRAUOYBU+2/MTVgQU6CPEuy9p5CYXATo
	OhgyvWGKL0OqOCRz2F8988BQDM0z7+HbZeljoO72VJDdERcJXCwyOjw2DwzSOjDukUfh5OUDw4DuA
	Vwvc3MD6RMv9cwSaKpew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW4jP-0005wx-QN; Sun, 09 Dec 2018 19:27:11 +0000
Received: from mail-out.m-online.net ([212.18.0.9])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW4jK-0005vE-Ui
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 19:27:09 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 43Cbmg5N2Mz1qxQ3;
 Sun,  9 Dec 2018 20:26:43 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 43Cbmg0Xdrz1qqlD;
 Sun,  9 Dec 2018 20:26:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id DjQLjNZUqY5r; Sun,  9 Dec 2018 20:26:41 +0100 (CET)
X-Auth-Info: T6YN9DrHuuQFQW/vowv1WxvtZzEtMlXeVytu7eFMubI=
Received: from [192.168.178.26] (unknown [62.91.37.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sun,  9 Dec 2018 20:26:41 +0100 (CET)
Subject: Re: [PATCH v3 1/4] dt-bindings: interrupt-controller: Actions
 external interrupt controller
To: Rob Herring <robh@kernel.org>
References: <20181126100356.2840578-1-pn@denx.de>
 <20181126100356.2840578-2-pn@denx.de> <20181207232934.GA28201@bogus>
From: Parthiban Nallathambi <pn@denx.de>
Organization: DENX Software Engineering GmbH
Message-ID: <49bb60b8-a51b-a4e8-da29-52f0a951c37b@denx.de>
Date: Sun, 9 Dec 2018 20:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181207232934.GA28201@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_112707_292287_957212AF 
X-CRM114-Status: GOOD (  23.43  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@cubietech.com,
 jason@lakedaemon.net, marc.zyngier@arm.com, catalin.marinas@arm.com,
 pn@denx.de, laisa.costa@lsitec.org.br, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
 edgar.righi@lsitec.org.br, guilherme.simoes@lsitec.org.br,
 mp-cs@actions-semi.com, manivannan.sadhasivam@linaro.org, tglx@linutronix.de,
 mkzuffo@lsi.usp.br, afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
 Saravanan Sekar <sravanhome@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Rob,

On 12/8/18 12:29 AM, Rob Herring wrote:
> On Mon, Nov 26, 2018 at 11:03:53AM +0100, Parthiban Nallathambi wrote:
>> Actions Semi OWL family SoC's provides support for external interrupt
>> controller to be connected and controlled using SIRQ pins. S500, S700
>> and S900 provides 3 SIRQ lines and works independently for 3 external
>> interrupt controllers.
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>  .../interrupt-controller/actions,owl-sirq.txt | 57 +++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>> new file mode 100644
>> index 000000000000..b3adc4bddf40
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>> @@ -0,0 +1,57 @@
>> +Actions Semi Owl SoCs SIRQ interrupt controller
>> +
>> +S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,
> 
> Listing SoCs here means you have to update this line for every new SoC.

Ok, I will mark it as OWL SoC's here.

> 
>> +in which external interrupt controller can be connected. 3 SPI's
>> +45, 46, 47 from GIC are directly exposed as SIRQ. It has
>> +the following properties:
>> +
>> +- inputs three interrupt signal from external interrupt controller
>> +
>> +Required properties:
>> +
>> +- compatible: should be "actions,owl-sirq"
> 
> SoC specific compatibles needed.

Ok, I will change this into "actions,s700-sirq"

> 
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +- interrupt-controller: identifies the node as an interrupt controller
>> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
>> +  source, should be 2.
>> +- actions,sirq-shared-reg: Applicable for S500 and S700 where SIRQ register
>> +  details are maintained at same offset/register.
>> +- actions,sirq-reg-offset: register offset for SIRQ interrupts. When registers are
>> +  shared, all the three offsets will be same (S500 and S700).
> 
> These properties should be implied by the compatible string.

Agreed for sirq-shared-reg.

But for s900 sirq-reg-offset, the register offset will have different values.
So this shall not be removed.

> 
>> +- actions,ext-irq-range: Identifies external irq number range in different SoCs.
> 
> Why is this needed? It appears to always be the same.

Yes, I agree for all the existing Owl SoC's this remains same.

In the previous version we defined this as constant in the code. But based on Marc's
feedback I understood that this value should come from Device Tree instead on hard
coding in the code.

> 
>> +
>> +Example for S900:
>> +
>> +sirq: interrupt-controller@e01b0000 {
>> +	compatible = "actions,owl-sirq";
>> +	reg = <0x0 0xe01b0000 0x0 0x1000>;
>> +	interrupt-controller;
>> +	#interrupt-cells = <3>;
>> +	actions,sirq-offset = <0x200 0x528 0x52c>;
>> +	actions,ext-irq-range = <13 15>;
>> +};
>> +
>> +Example for S700:
> 
> Examples are examples, not an enumeration of all possible dts entries. 
> So 1 should be sufficient.

Sure, I will maintain only s700 here.

> 
>> +
>> +sirq: interrupt-controller@e01b0000 {
>> +	compatible = "actions,owl-sirq";
>> +	reg = <0x0 0xe01b0000 0x0 0x1000>;
>> +	interrupt-controller;
>> +	#interrupt-cells = <3>;
>> +	actions,sirq-shared-reg;
>> +	actions,sirq-reg-offset = <0x200 0x200 0x200>;
>> +	actions,ext-irq-range = <13 15>;
>> +};
>> +
>> +Example for S500:
>> +
>> +sirq: interrupt-controller@b01b0000 {
>> +	compatible = "actions,owl-sirq";
>> +	reg = <0x0 0xb01b0000 0x0 0x1000>;
>> +	interrupt-controller;
>> +	#interrupt-cells = <3>;
>> +	actions,sirq-shared-reg;
>> +	actions,sirq-offset = <0x200 0x200 0x200>;
>> +	actions,ext-irq-range = <13 15>;
>> +};
>> -- 
>> 2.17.2
>>
> 

-- 
Thanks,
Parthiban N

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-22 Fax: (+49)-8142-66989-80 Email: pn@denx.de

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

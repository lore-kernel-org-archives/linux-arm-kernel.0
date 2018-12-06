Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9562C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:42:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872AF20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Euo4stD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872AF20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=70PSa3v1GjH7MPXylZKHAouqWlQA2FACyMwt4UKvgd0=; b=Euo4stD6aA1jiR4daDzIjieTe
	LQqadnm5HooeJlYPWzGRzjdPdMhzoCqzQzX/sEHPdtToJwli8EoM39bbXJFwFgtyNt6JWJVZTq977
	QSLUAJx2CUjDClC6k27ulFQIQtM5yF+5t/xSLKTyzx/jX/5mpc+Ld3q0Gn9I6z9W80eGLHZazOwED
	BN0097YRxZ7ItHhDi8ZpEjgOFCu/aPmcdlMWcPrdUv0Zo9fBvvhuH9MvbYMfu/BXOLG29B2nnBLDR
	6YKJLX3hiTbWLfUzDGXc9DlZkiIRsMHMwsO66fEfg3LP/hfI+E3SwqHv7h33L9MtKPKt5HV8qDrnO
	AN6YvBdng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUoIi-0003nL-12; Thu, 06 Dec 2018 07:42:24 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUoIb-0003hs-GA
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:42:21 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 06 Dec 2018 16:42:05 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 9231760062;
 Thu,  6 Dec 2018 16:42:05 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Thu, 6 Dec 2018 16:42:05 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id 5D715403E6;
 Thu,  6 Dec 2018 16:42:05 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 40696120304;
 Thu,  6 Dec 2018 16:42:05 +0900 (JST)
Subject: Re: [PATCH 04/14] dt-bindings: timer: Add Milbeaut M10V timer
 description
To: Rob Herring <robh@kernel.org>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-5-git-send-email-sugaya.taichi@socionext.com>
 <20181204230354.GA26204@bogus>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <230f9c6d-afc1-7e24-eb26-0bc7d1fee333@socionext.com>
Date: Thu, 6 Dec 2018 16:42:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204230354.GA26204@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_234217_657781_F9C0DC37 
X-CRM114-Status: GOOD (  21.11  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Thank you for your comments.

On 2018/12/05 8:03, Rob Herring wrote:
> On Mon, Nov 19, 2018 at 10:01:09AM +0900, Sugaya Taichi wrote:
>> Add DT bindings document for Milbeaut M10V timer.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
>> new file mode 100644
>> index 0000000..ddb1b31
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
>> @@ -0,0 +1,17 @@
>> +Milbeaut SoCs Timer Controller
>> +
>> +Required properties:
>> +
>> +- compatible : should be "socionext,milbeaut-m10v-timer"
>> +- reg : Specifies base physical address and size of the registers.
> 
> How many register ranges? Looks like 2.

Yes, has two ranges.
So add the description about it.

> 
>> +- interrupts : The interrupt of the first timer
>> +- clocks: should be "rclk"
>> +
>> +Example:
>> +
>> +timer {
> 
> timer@1e000050

Okay.

Thanks
Sugaya Taichi

> 
>> +	compatible = "socionext,milbeaut-m10v-timer";
>> +	reg = <0x1e000050 0x10>, <0x1e000060 0x10>;
>> +	interrupts = <0 91 4>;
>> +	clocks = <&rclk>;
>> +};
>> -- 
>> 1.9.1
>>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

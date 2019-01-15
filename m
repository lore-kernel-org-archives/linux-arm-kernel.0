Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD64AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4D22087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q4NNh83z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4D22087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yHinIklBUTpnHdp07p31CBlAeezgRv7UqCbM9rjiITc=; b=Q4NNh83zL7CWfe
	7edqxOEvFjhwWzRGzhFpQx5KKCDZ3b1IpF20kozOSL0Xuz3VHD6e1DlhJWAst9Lekw4SqPR9Z9VBE
	iM4QOnNAPSgcXdE7EzcbcD/mGBVJoIUQlt5iReJfAcBjgrSELkcobXBhvw/w7r5rbGkvoQZgSToy8
	92ZRl2JsDRxZDvx/yOM1u8f01QUrof+m9TUKNxoRppgzns1oSztzfCjlNa7QqDHt1oJ/sPk3RxrLL
	gFlnsphsyzLwouUl5EOCR32eYoLczpqBoTBs3VoyLhFMOjfnv67dLLyOspcx04/kzrEXcz75n5RbP
	cYkLK7iJ05y74uxC/KIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjRir-0006Of-Em; Tue, 15 Jan 2019 16:37:53 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjRio-0006Nh-0i
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 16:37:51 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 46A4F207A3; Tue, 15 Jan 2019 17:37:46 +0100 (CET)
Received: from localhost (alyon-652-1-22-18.w109-213.abo.wanadoo.fr
 [109.213.145.18])
 by mail.bootlin.com (Postfix) with ESMTPSA id 09CCD20729;
 Tue, 15 Jan 2019 17:37:36 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3] arm64: dts: marvell: Add device tree for uDPU board
References: <20190111172055.30451-1-vladimir.vid@sartura.hr>
 <20190115144421.29968-1-vladimir.vid@sartura.hr>
 <20190115161608.GA25888@lunn.ch>
Date: Tue, 15 Jan 2019 17:37:36 +0100
In-Reply-To: <20190115161608.GA25888@lunn.ch> (Andrew Lunn's message of "Tue, 
 15 Jan 2019 17:16:08 +0100")
Message-ID: <8736ptri5r.fsf@FE-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_083750_196243_473960BB 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: devicetree@vger.kernel.org, Luis Torres <luis.torres@methode.com>,
 Paul Arola <paul.arola@telus.com>, Luka Perkov <luka.perkov@sartura.hr>,
 Vladimir Vid <vladimir.vid@sartura.hr>,
 Scott Roberts <scott.roberts@telus.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew,
 
 On mar., janv. 15 2019, Andrew Lunn <andrew@lunn.ch> wrote:

> Hi Vladimir
>
> Ah, i did not notice early. You need to Cc: the Marvell mvebu
> maintainers. They are the ones who will accept this patch.
>
>
>> +	leds {
>> +		pinctrl-names = "default";
>> +		compatible = "gpio-leds";
>> +
>> +		power@487 {
>> +			label = "power:green:led1";
>> +			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
>> +			default-state = "off";
>> +		};
>
> I'm a bit out of date with dtc warnings. I think the @487 will
> generate a warning because there is no reg property?
>
> Gregory, do you know?

I confirm that if there is no reg then there should not have a @XXX.

Gregory


>
> Thanks
> 	Andrew
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

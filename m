Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F60C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:35:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB212177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R8/nlppq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SPJOlELh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB212177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lzNYjIfyO/XjrWdutDNSfUCr89yeNeNb+P1X+4wqk8o=; b=R8/nlppqWY4V4x
	A5IVP+QUU1W8tCkywSclHze6xtCyff2YuOtx2jyH+btSdqIVvVuhwa813hHj9/C4iiLEeEUP5Rmff
	FWQRXLPfqBAczUeblSUfpYOfVrj34D9LSmRNGTkrhFfG2fq7mhHEK9Kw2/IO2UngIpIyIpN9AABcl
	zhCRnTr68ohkr49NX7lSFrSb+EYOSGIuouf+BaizIoaOr27uiEbCowSA5u+hQ+Z3P5j77jB8gY/bl
	YFgXtsbTEW9Hc6zmqYCiF55/3X6/7MdHT8foJYpm5OQW7g8+faLYR3tccJyzHlqq7O3s9dZXv7Dlu
	zrV/9QkMR35OarN0jWCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5N2-0005Ke-G2; Fri, 08 Feb 2019 12:35:04 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5Mz-00057G-EN
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:35:03 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18CYm1e013731;
 Fri, 8 Feb 2019 06:34:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549629288;
 bh=8bS8zls/dE8hfPZP4eU0IjuclttOYbruvQkIboObp7c=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=SPJOlELht4ONyKX390yrEZKdFO1SHaoBdlO0IrFg8To0MyZeSlDRkfBPFCXlzJkyU
 chcM7wSATw4GWbVN91CHIOw7gYwJol3vfedJyl5YjFoGbazVd865p/TWXqdwcgJQYj
 wzVUVuzkax1A6A0sj8wzLAXYd9PKpn9VCO+dp4Dg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18CYmjh050960
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Feb 2019 06:34:48 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 06:34:47 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 06:34:47 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18CYiiS016929;
 Fri, 8 Feb 2019 06:34:44 -0600
Subject: Re: [PATCH v2 08/12] ARM: davinci: dm355: switch to using the
 clocksource driver
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-9-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <bb0bc61a-8c2b-affa-c58a-1e7c14f9390d@ti.com>
Date: Fri, 8 Feb 2019 18:04:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204171757.32073-9-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_043501_569749_25E0102E 
X-CRM114-Status: GOOD (  14.20  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 04/02/19 10:47 PM, Bartosz Golaszewski wrote:
> -/*
> - * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
> - * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
> - * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
> - * T1_TOP: Timer 1, top   :  <unused>

Documenting this timer division is important because DSP usage and
unused timers are not immediately clear from kernel code alone. Can you
retain these comments in all patches of this series (I guess T0_BOT etc.
terminology is changed, so feel free to adjust the comment text).

> - */
> -static struct davinci_timer_info dm355_timer_info = {
> -	.timers		= davinci_timer_instance,
> -	.clockevent_id	= T0_BOT,
> -	.clocksource_id	= T0_TOP,
> +static const struct davinci_timer_cfg dm355_timer_cfg = {
> +	.reg = {
> +		.start		= DAVINCI_TIMER0_BASE,
> +		.end		= DAVINCI_TIMER0_BASE + SZ_4K,

Here and other places too, SZ_4K - 1

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

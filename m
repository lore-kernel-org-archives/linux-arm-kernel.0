Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB867C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:31:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CD0218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y13JD5PB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="H1eMYeKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CD0218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hPjBbTbDBfN9aEjqi38A5X6AxIqwfTn3gafk1N4tj/s=; b=Y13JD5PBuYi0MR
	hdXWTgMxlmSzqekLoGYYkCZmC8BNCdt9TLYiKieP5rRpxhoXARiAYbMTYD2oTMuQKa0j3pgZ4O9rg
	WWK4k8v5OSf+2leakTqKSnpfpJVIiJHeW0HNU2ClCOtrBYIh/Jco4dSRPk7uOebhk18nwe5clKqH6
	Dtep399qEofeRzlwgzmoTRGBvqILqZdDIxS7WLkebPvQ3wYD9Cfmok/s95Sk/JSG9VvM63m5itlaG
	OmhAd70zsDGxEjJaNfsV6AFbtpU57CsQytbKnuDl1lAcLLKDE3bN/T75RVGThUqFM1XLGarypHk7+
	A92bsPKFHUHywjjgCnZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnTfm-0006GE-2u; Sat, 26 Jan 2019 19:31:22 +0000
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnTfh-0006Et-VX
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 19:31:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548531064;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=puyNQkvhKVOeQZcXPzWY0Yqb517W/lLbBh7R3tRhBUI=;
 b=H1eMYeKtKw2G2uQfTZQvab0retT2sOEvvlXkLciW718wkBoTFqachmoCAUu+Ufnbtn
 KgQrZKudspj5otlu5OMnPmIno3D8INOhhBVCmvff17FenrIg9lEJds6u5l2LDfPw42xP
 5bjdEXd7CJ2zhlJqKdDKpKFxMNv/78NzjkSFN1gsrw39tjSHmknXcTgfGid3971WDUXo
 jxTNxTf6peyGBti3uI9v4pCY54axcvyI/O/sijosewTD5M1B8bfo+b95g/7rmFo/ErGm
 ZcaRa0pEVNZzWZP64FLAsDOjhz1aHdlDU5+azoxbKaNXoZBKiv0fVxnZDf6KEnYhTZoM
 MLNw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/zswDuotw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
 with ESMTPSA id 608499v0QJUmsoz
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH
 bits, eq. 15360 bits RSA)) (Client did not present a certificate);
 Sat, 26 Jan 2019 20:30:48 +0100 (CET)
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/3] clocksource: timer-ti-dm: Fix pwm dmtimer usage of
 fck reparenting
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190126194044.2fad4427@aktux>
Date: Sat, 26 Jan 2019 20:30:47 +0100
Message-Id: <99532D7E-DCF3-4ECF-B65D-62C3C60E188F@goldelico.com>
References: <20190122175717.13428-1-tony@atomide.com>
 <20190122175717.13428-2-tony@atomide.com> <20190126194044.2fad4427@aktux>
To: Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_113118_612735_B312B078 
X-CRM114-Status: UNSURE (   8.48  )
X-CRM114-Notice: Please train this message.
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
Cc: Ladislav Michl <ladis@linux-mips.org>, Keerthy <j-keerthy@ti.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Andreas Kemnade <andreas@kemnade.info>, Thomas Gleixner <tglx@linutronix.de>,
 linux-omap <linux-omap@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


> Am 26.01.2019 um 19:40 schrieb Andreas Kemnade <andreas@kemnade.info>:
> 
> On Tue, 22 Jan 2019 09:57:15 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
>> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
>> them with ti-sysc") moved some omap4 timers to probe with ti-sysc
>> interconnect target module. Turns out this broke pwm-omap-dmtimer
>> where we now try to reparent the clock to itself with the following:
>> 
>> omap_dm_timer_of_set_source: failed to set parent
>> 
>> With ti-sysc, we can now configure the clock sources in the dts
>> with assigned-clocks and assigned-clock-parents. So we should be able
>> to remove omap_dm_timer_of_set_source with clean-up patches later on.
>> But for now, let's just fix it first by checking if parent and fck
>> are the same and bail out of so.
>> 
> together with 2/3 it fixes things on pyra
> 
> Tested-By: Andreas Kemnade <andreas@kemnade.info>

Tested-By: H. Nikolaus Schaller <hns@goldelico.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

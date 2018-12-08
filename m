Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB24C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 23:16:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14ED20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 23:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yd0lvLLr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Beh13sou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14ED20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XiHfUY+Lt/yH5rPyCteJe1anRA3lCZMqomr9zKMkZoc=; b=Yd0lvLLro51pvb
	rgduva5uhkdnNmTFEB7ZeukvG5VgU1xZFKZAEtVZ8wIFWsK4tixYfYq+nDh9vAABLRR6syhDdVpux
	A1VZ4gzbZQWvmRxt5wRvXEHF/P965CgJdxwGN1WwaOwT0Wo1tGMHctLjvgFeR2ePrFphVUmI0RURd
	jN37lJEvh6HdY4BKFZIq5EJ54JLRTECvpKavQxNFV9saHStaOHFJujQQ39HWxQ0ZFQczAHpsH2hcd
	OVRDbhZ1Z7XB20xlvNY4m8+QLBk0JWYzn6/LbFVLu8Nvcw6bu18damDnHQBHXq5FmuX2Isfm3qtNC
	iKGimcEOK7OET9UfUSpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVlpQ-0007Az-5G; Sat, 08 Dec 2018 23:16:08 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVlpL-0007AN-Hy
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 23:16:05 +0000
Received: by mail-lj1-x241.google.com with SMTP id u6-v6so6540897ljd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 08 Dec 2018 15:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6kGvtiHMf1J5Wb63nJUZ6Aafy+jRbm3Lu1vk3UQIIlM=;
 b=Beh13souYVsvRqWvzBUvnuEA3NxCzfeI5zbWp0ylKGnABnUWHO/DdF4xs4LqN22zFl
 tDVqFlIfEyY7C8w0FTi9OsRbSTPzzTirmTzHVDR/EncKIp19aQGTWmvx7nycwsqC5eFV
 mOtOkNKFSFJ590KwDqZhxqHVGIAqP3oO279JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6kGvtiHMf1J5Wb63nJUZ6Aafy+jRbm3Lu1vk3UQIIlM=;
 b=lBPBO3uzfC30EWm5COoZDU+ZiweLwM13jT6MgAiMrD4fnNx1Esf4qAz3yQSWDyEMfA
 0C9CH34alP43ZRn7U4e5VlE0zTQQrw1QNkmB2prUsagfzWicUh6JyMwMPLpH/Ytgtnen
 9eFLuzD9uYTlGzak9Ec0NY9nDQtnWDPooXJvZEBwrKjkTeD6riPBocYT9PZS7sNNGH49
 5vyjINjbNAqlJPpBoOR4GXuOUvuyyls1+ajpSFQRRJlsTKJgXF6KWaKD1Hv6EkrTKwpj
 sYC7kKSXv7hL+KZq7w83kjumiW/PspW1mtZePe4Txh34byJa9ETeyRfvzmHrcrO4OY+P
 sU2Q==
X-Gm-Message-State: AA+aEWY5wSD6TfXG5/womcDXLRiO5lFyGlot2CEoA0iqf708RLBQ5VQM
 IQ9BNUe7PgBijIMIFbA1WkoTQhSSWliSq4hEeVMIdg==
X-Google-Smtp-Source: AFSGD/WG95DfI3oAr93wSlz5HfDGejInvjsOB3JUV3cdfuqsFwr3GQ1Hor5tHrYUi6AhutvwNEGTOuolY4QtjNZg8Yo=
X-Received: by 2002:a2e:994:: with SMTP id
 142-v6mr3611808ljj.120.1544310947324; 
 Sat, 08 Dec 2018 15:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
In-Reply-To: <20181207130012.GX6920@n2100.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 9 Dec 2018 00:15:35 +0100
Message-ID: <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
To: Russell King <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_151603_604025_A3CF6DE4 
X-CRM114-Status: GOOD (  15.63  )
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
Cc: ext Tony Lindgren <tony@atomide.com>,
 viresh kumar <viresh.kumar@linaro.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 David Brown <david.brown@linaro.org>, Xu Wei <xuwei5@hisilicon.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>,
 Patrice CHOTARD <patrice.chotard@st.com>,
 shiraz hashim <shiraz.linux.kernel@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 7, 2018 at 2:00 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> I think the bigger question is why are all these platforms using this.
> For the ARM development platforms, it's fair as they have no way to
> power down the CPUs or reset the other CPUs, and the "boot lock" was
> there originally to prevent the delay calibration going awry.  (I've
> been saying this for years but obviously people like to stuff their
> fingers in their ears.)
>
> It annoys me when people cargo-cult copy code and don't bother trying
> to understand it, which is shown clearly in your diffstat.

It's a very good point.

I did away with "my" culprit at one point in
commit c00def71efd9
"ARM: ux500: simplify secondary CPU boot"
so people could look at that for an example to see how pointless
this "pen holding" (what does it even mean, I never figured it
out?) and boot_lock is.

I thought it was just a few platforms around the time the first
SMP systems were arriving that were doing this but as you point
out, recent newcomers are doing this, such as sti, actions,
qcom, hisi, sunxi.

I would encourage other platforms that have this "write some
magic stuff in some register to boot cpu n" to look at
arch/arm/mach-ux500/platsmp.c, something like that should be
all you need, no special assembly, no "pen", no "boot lock".

Look up resources etc in .smp_prepare_cpus(), make sure to
call set_cpu_possible() for each available CPU, then  just
kick in the CPU n in .smp_boot_secondary() by doing your platform
magic. Optionally cpu_die()
if you need special code or just put in a wfi() for that. That's all.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

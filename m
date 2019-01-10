Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF70FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:56:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1EF2173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hn7AcZ9H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q21SU3o1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1EF2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:References:To:From:
	Message-ID:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kzDEeahww1E9Xc3ialcLvh/EQAEFmT1fNK7xt+MMFaA=; b=Hn7AcZ9HMW4Sc9
	PVrWaaeecoEk7lcpsdhqU3z/8ZxBG7T/ZgKXFIvAXy0PRap/HXhG8mi5k7HflogYpT+G2iAZXF/3f
	bbWoRwxIR1/Mql6k4qaFDkKCgLDNiSXHi8YBSKQl9qMHVFqx7Pjb08nNLKEO93BkbcmBuCO9LZ9GM
	rhVp1tIcxFoBgeox/tGF56abO9g8N0J4mX2FhDTbuyQTGbvy5g7hb3CDp3PuEfMCPoPs9ktQ3R6pl
	erj87a7wgJd1vo++mhYGeOAEUzES9FtvcbPscOiu+sDG6AyJnDpkYxM1Ut2hEdyF+7KGQtE8RikIK
	1R92vcRnBX5sNBSomINg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghhNF-0004sD-Cn; Thu, 10 Jan 2019 20:56:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghhNB-0004rq-QL
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:56:19 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D464020685;
 Thu, 10 Jan 2019 20:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547153776;
 bh=BZ9pNTo2nlZOpfDEebMsqbdLRiv1TsUD3BVKJX6pDlc=;
 h=In-Reply-To:From:To:References:Subject:Cc:Date:From;
 b=q21SU3o1ihcJmY/cpHmPE49isExPV5DCMLllnPo2sJb9+jY08+eHvdi18EdAlJgoS
 zJfXIFMT4GAfcOYDRzfq1VxoP2GanYHqriVP50iXFzGsnhOzX5vPEv+8dJBHRVCdwr
 cD+Ezohe8A4lR5c8mI29tAmC4W2s1BJBo9FPsOvA=
MIME-Version: 1.0
In-Reply-To: <CACRpkdY_LxF82CbUUnf3B3BVucGvGnnXH-DWcWDmKcU9UgLvpA@mail.gmail.com>
Message-ID: <154715377593.19284.1463901972122807524@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
To: Andy Gross <andy.gross@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Russell King <rmk+kernel@armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
 <CACRpkdY_LxF82CbUUnf3B3BVucGvGnnXH-DWcWDmKcU9UgLvpA@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
User-Agent: alot/0.8
Date: Thu, 10 Jan 2019 12:56:15 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_125617_867920_9B4C695B 
X-CRM114-Status: GOOD (  15.09  )
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
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 David Brown <david.brown@linaro.org>, linux-oxnas@groups.io,
 "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Linus Walleij (2019-01-10 04:50:56)
> On Thu, Dec 13, 2018 at 7:00 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> 
> > The boot_lock is something that was required for ARM development
> > platforms to ensure that the delay calibration worked properly.  This
> > is not necessary for modern platforms that have better bus bandwidth
> > and do not need to calibrate the delay loop for secondary cores.
> > Remove the boot_lock entirely.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Andy have you had a chance to test/apply this patch?
> 
> I think the majority of Qcom systems use CLKSRC_QCOM
> which registers an arch delay timer and swiftly bypasses the
> calibration anyways so this code is pretty much pointless.
> 
> There is a question about MSM8974 though. This appears
> to not use CLKSRC_QCOM but rather HAVE_ARM_ARCH_TIMER.
> drivers/clocksource/arm_arch_timer.c seems to
> not register a delay timer, which is probably something that
> should be fixed?
> 
> Mark/Marc: is there any specific reason to why the ARM arch
> timer does not register an arch delay timer?
> 

Doesn't the ARM arch timer get registered in
arch/arm/kernel/arch_timer.c via arch_timer_delay_timer_register()?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

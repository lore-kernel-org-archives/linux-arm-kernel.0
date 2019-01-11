Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAC1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:09:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04BB20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WNNb3z7v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kyIxLNtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04BB20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C0UJVY+N4V1EChVVXo7k+g6kJtw/glDk7oTsNs1CcIE=; b=WNNb3z7v9/I0YG
	W9UnSXdTBK8RSdp4ekj0Wkb4Yk/qaof3jwmkN2alxgOF9lGhoFQm9S10TdHKQ4YDWg2twIn68g8A9
	n8zsuewA1xkkcWu6xqfDUHJSAZsgPSea2Sy1KwadkvQqQKc41h8dF4dWttmtLPlzgybR8o5J26qeA
	rZDB0Iz3jlpDR8rw0vxuHNLANtMZYl2R0ReAFrGKliChfwFme/p0Eb316Cj5Mr4OQNU7URx3M7pN1
	vAJJjsjFaVsyd3Pyow7WeV9kADg4Q8JbsWCcVjY/ymxr2H3PQtiFHMzp4Rt1uKTr6ZowXQKWsIfnH
	HbR4o0JqFlISZmraRa/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyRV-0001ct-NR; Fri, 11 Jan 2019 15:09:53 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyRS-0001bP-5b
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 15:09:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2KOgFTAdL+5OBjxO+GVsXq8NbLH+CmWRoJ566I1E2lA=; b=kyIxLNtqCFfUCWtxVwAlsXaHg
 E/vLnSMwphWhq/+3ima1aE68HLLKCG6BrRtfdQG1Li10ouvN02ZkXtE5lu1NUs8ROMcPE4QGyQwZa
 KH0134jE+jltSrnCfWtQFR4ZgZeAAxPQtaHEa5ndZF/Hk79GwpFQ+ixeulUlI0EfT6AxM=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:51183)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1ghyRH-0005j0-IK; Fri, 11 Jan 2019 15:09:39 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1ghyRE-0003Cf-Iq; Fri, 11 Jan 2019 15:09:36 +0000
Date: Fri, 11 Jan 2019 15:09:35 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
Message-ID: <20190111150935.GA4617@n2100.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
 <CACRpkdY_LxF82CbUUnf3B3BVucGvGnnXH-DWcWDmKcU9UgLvpA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdY_LxF82CbUUnf3B3BVucGvGnnXH-DWcWDmKcU9UgLvpA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_070950_368224_10DA0993 
X-CRM114-Status: GOOD (  15.20  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-oxnas@groups.io,
 Marc Zyngier <Marc.Zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 David Brown <david.brown@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 01:50:56PM +0100, Linus Walleij wrote:
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

I would rather folk do not _apply_ these patches - the final patch
is dependent on all the preceeding patches, and if they're applied
to individual trees, it will mean that the final patch has to be
delayed by a complete kernel development cycle to avoid bisect
breakage.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

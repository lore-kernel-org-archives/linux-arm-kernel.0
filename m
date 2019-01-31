Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4091AC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:24:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13AB52086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ISZz7N9s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="manm5sRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AB52086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oVMlbDhI8qfy9wKTacdYfxwionKxwQU5uHXR13zhqLA=; b=ISZz7N9sG/5/As
	nrs9sfSCXk4Cjv5wwqA4JnmEniux+xjVmjKNnkui/LwoP98GPFeu8CkPZB2PWXzJHhfvxSLBRezt/
	0C+4nTlC+EDIyX/5sRTe8WMCNpz4wSopBuAf/kxq70wPy6saFjhnHlvLd0Qk8HheXNAUSViglCjvK
	Tk1gvoFEGewxAVcSPnT/Wx0njsn/v3U5pmLX9d91msKKpKKAvtvHtuhBaSFrsWYltJAn9ktQHpybT
	JCTvom3eksUAokTjOER7bNNnyhH/pAY9Yg8a/9I0o6Rtldkqxe2wzSTgHokPVWODYdOUSzdL2BSJz
	FKMoQnoVGqQzbtzx0kDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpECl-0006Um-0c; Thu, 31 Jan 2019 15:24:39 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpECh-0005zN-0r
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 15:24:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zaBpfNpCVdbDPQFRwA5YLYdox6i8UN3HO+0zKBeusJw=; b=manm5sRdTUmqmYzLO4KE4wbfs
 UIWUUs6BSBGgCPQQ8T6A93Spc3DLq2D7FmddwkW9ooykd9ez0PMI8uoRFcd8yCcxGgGLrDo0wM7lH
 s1rdaodAo8alVMCnC5pMfHhuTN3igsx50mW9CcptFzEBM0svk9WroELEA8cDFWOalj3fs=;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36850)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gpEAD-00081T-Fg; Thu, 31 Jan 2019 15:22:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gpE9z-0000xP-LS; Thu, 31 Jan 2019 15:21:47 +0000
Date: Thu, 31 Jan 2019 15:21:47 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v7 0/3] clk: clkdev add managed lookup registrations
Message-ID: <20190131152147.tzxabhyhlyy2rwhy@e5254000004ec.dyn.armlinux.org.uk>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
 <20190131132452.GD23791@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131132452.GD23791@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_072435_220198_B337C88A 
X-CRM114-Status: GOOD (  19.79  )
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
Cc: linux-arm-kernel@lists.infradead.org, djkurtz@chromium.org,
 rafael.j.wysocki@intel.com, linux-clk@vger.kernel.org,
 b.zolnierkie@samsung.com, sboyd@kernel.org, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 sre@kernel.org, krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 vkoul@kernel.org, linux@roeck-us.net, pavel@ucw.cz, pombredanne@nexb.com,
 andrew.smirnov@gmail.com, sjhuang@iluvatar.ai, mazziesaccount@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 03:24:52PM +0200, Matti Vaittinen wrote:
> Hello All,
> 
> On Fri, Dec 07, 2018 at 01:09:00PM +0200, Matti Vaittinen wrote:
> > Series adds managed clkdev lookup interfaces and cleans few drivers
> > 
> > Few clk drivers appear to be leaking clkdev lookup registrations at
> > driver remove. The patch series adds devm versions of lookup
> > registrations and cleans up few drivers. Driver clean-up patches have
> > not been tested as I lack the HW. All testing and comments if
> > driver/device removal is even possible for changed drivers is highly
> > appreciated. If removal is not possible I will gladly drop the patches
> > from series - although leaking lookups may serve as bad example for new
> > developers =)
> > 
> > Changed drivers are:
> > clk-max77686 and clk-st
> > 
> > Please note that the patch #2 requires this change to work correctly:
> > https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
> 
> I guess the dependency mentioned abowe is already in (most) of the
> trees. (I can't say for sure as I don't know what is the correct tree
> for clkdev - is it linux-arm.git as Russel is maintaining clkdev?

Yes, I'm supposed to be maintaining clkdev, but I'm busy with other
stuff (such as reorganising my network, helping people with SFP issues,
I'm supposed to be replying to Arend over a brcmfmac issue that has been
on-going since Christmas which I haven't yet been able to doing the next
test...)

> If yes, then the commit 05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
> "clk: of-provider: look at parent if registered device has no
> provider info" seems to be sitting in maser branch).

It's there because it's part of the mainline kernel and has been
since v5.0-rc1.  So, if you depend on that commit, basing off
v5.0-rc1 is probably sane, unless there's something else that
conflicts.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

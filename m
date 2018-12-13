Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D231C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:51:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624162086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rtZ4zI17";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z2TvJ0M7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624162086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zRmZbCArwyh2o9NP4DeHXsoWhR/xeFY6Wij50i7gFTg=; b=rtZ4zI17CALbM+
	B80qYLq/pS4AOvPHywrlmdHN3p2oH/ORhaZ+yhtOstdmV5v6J1h/UuCLqJ62Q0yGXQk/fwieFMwiK
	KgMTM2JGUdHxQ/09pQJ/WmDC4ewMuF6kTdVnlIsnQAQuwhFz4RZ9E7lePXdKcJIULrqqFUsjmCkz6
	Vt6s8oVqXkWmQgEl5yQYYVSUhvxuh+W+vizougHQGHNJhip66zqO2bqsQajfkcEueWkTFA9pRsqyL
	C7Lf3cJcZS4bg8AQTCjwaZn5WoC3Nos8qc/DkjwyuNFSYbIsVq8AWmskKJMfjRXmQFrqMPa3xHQM3
	hHVOZNwZYeGm8eo54m5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPWh-0006XI-Au; Thu, 13 Dec 2018 11:51:35 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPWd-00059D-Np
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:51:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HZ6+/zqBr4R9fVVVo8PqY6Pg7pC9iTf1U6qoR5GO7aE=; b=Z2TvJ0M7YfvEQ675IPcNAPABo
 2mr+uFdt2cFMvZFJdWIKjzU6ieQsrkdAEWNgslVdHQ6taqctjaATuSODzDb7zxHjIE+clhqhJ8U9z
 brkSK/QPTai3E6wKN0xMtXNJtrc3heUnYFfHIjmgpuW8xmtae/UYFgrHul5tdWu3KlVz8=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:43197)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gXPU0-0002Cn-7p; Thu, 13 Dec 2018 11:48:48 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gXPTx-0004PO-JQ; Thu, 13 Dec 2018 11:48:45 +0000
Date: Thu, 13 Dec 2018 11:48:42 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Message-ID: <20181213114842.GJ9507@n2100.armlinux.org.uk>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
 <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
 <20181209004138.GC9507@n2100.armlinux.org.uk>
 <20181210143718.plwd36vdxxd7q2el@linutronix.de>
 <CACRpkdby=Xreh0VPpHBPLhvupgQyEqDiae+e0u=-n3o2SWVMTw@mail.gmail.com>
 <20181211212930.kcap5kx6bff6bpuu@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211212930.kcap5kx6bff6bpuu@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_035131_778540_ACE599AA 
X-CRM114-Status: GOOD (  17.26  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 viresh kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, David Brown <david.brown@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, Xu Wei <xuwei5@hisilicon.com>,
 ext Tony Lindgren <tony@atomide.com>, Chen-Yu Tsai <wens@csie.org>,
 Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>,
 Patrice CHOTARD <patrice.chotard@st.com>,
 shiraz hashim <shiraz.linux.kernel@gmail.com>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 10:29:30PM +0100, Sebastian Andrzej Siewior wrote:
> On 2018-12-11 19:19:32 [+0100], Linus Walleij wrote:
> > Can you please send one patch per mach-* plat-*?
> > 
> > I can apply the plat-versatile patch and send upstream.
> 
> I just resent the versatile hunk. Should I really split up and resend
> the other platforms? Russell was not very amused about it.

Just the Versatile bit, and no I don't see any point in fixing the
other SoCs - it's an incentive for them to fix up their code.

However, given that hardly any have responded, pointing out this
problem in email clearly hasn't worked by the resounding silence
from SoC maintainers.

Removing boot_lock from those platforms who just cargo-culted the
boot_lock including comments without the pen_release stuff is easy,
all the lock is doing there is providing a bit of unnecessary
synchronisation between the requesting CPU and the booting CPU.
Only a couple of SoCs fall into this case - OMAP4 and qcom.

The rest aren't something that could just be ripped out without
the involvement of the SoC maintainer to test the changes - so
I'm of the opinion that we should just send SoC maintainers
patches that remove the pen_release and boot_lock crap.  If they
blindly accept the patches, so be it.

I'm preparing a series to attack some of this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

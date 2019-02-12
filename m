Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBACC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:46:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC9120821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mK3w1GZP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="Y66Oa5RF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC9120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wzxo4zAclQfmHWYgL9JuuzvdY4QFPaV7yruBe/b1qOI=; b=mK3w1GZPn35C1W
	7xR/iBYsM3qdXgzCT10WdBzTwiygRrjgqjJi30GeVYSqEjyrl5HOdtN2LDxibFy0Ah4l5mE8Bn6GM
	INqUvaXLp2dCt+s4673TiUR1DVAtjde73c5g1nz95tLn6s/ct7udN0Ke4VcdFPWYdyu1XsCi5PY0D
	DtOe40LHGJElHTpRAvseYoxMF4g23bKpt/SbfqxLsOfkOM9mgMiQkCSVfuqZqfhrA5Aa5m6UQIglx
	CZu6tzLGjWJMYbbRuELib6wPe1TsNc1tQk7ii+NhrtsnCn2BHOFCO5CuLJo8D2JH0TZtZ1yZ59x20
	2/tuBrOM5LVdjsdZulng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtUdV-00043W-JM; Tue, 12 Feb 2019 09:45:53 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtUdR-00042t-G2
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 09:45:51 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 663D64022E;
 Tue, 12 Feb 2019 09:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1549964747; bh=W25nCZmEIHwGCTrzOhdBgd7ZEShM1fhel195A9NUUJ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y66Oa5RFVOQQLEpwHktWNOQofRWVwvVlE4yIXl0jLqHj+CrSy6KH+C36goAXDu3+H
 3hDCzZbdv1x+SzKdULFgOOcO+7j8Kd3O+NB1369dHVx4E5Nhd5af1ON2g9hTKCmi0N
 5Cxc5sWq5pxAoEWdtFIINuXTzTYSH1fWVaFevRV9IgGCPyPoCXnWaDV1XzsrgUn8K3
 ngBcxdfJnvh0CKSh7P2rSlnae0PYccxX/C9h5KDfbuV3GqYi283omzQECukJLIyGpf
 oeQ+0pnI5n8pS39PuSNUsDvh0Xxhlqax4PFnR1Inl0ldeOaFfiAOtRUq4+CXfS4xK2
 qgSmS4YawBs3g==
Date: Tue, 12 Feb 2019 09:45:46 +0000
From: Priit Laes <plaes@plaes.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
Message-ID: <20190212094546.n2w7pffytzdgpx3e@plaes.org>
References: <20190202155209.31617-1-plaes@plaes.org>
 <20190205094529.t7je4ozzu2b4ornc@flea>
 <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
 <20190206092000.f46nsn4fw2n4crub@flea>
 <20190206100309.dhkm2l73qzkwgjzg@plaes.org>
 <20190206155227.wbkzvsdgykir4wn5@flea>
 <20190211143552.2uqx6yy53dyv5lbl@plaes.org>
 <20190211153402.s5qij5idvhbtsw2y@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211153402.s5qij5idvhbtsw2y@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_014549_893161_457FF9B5 
X-CRM114-Status: GOOD (  22.01  )
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
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 04:34:02PM +0100, Maxime Ripard wrote:
> On Mon, Feb 11, 2019 at 02:35:52PM +0000, Priit Laes wrote:
> > On Wed, Feb 06, 2019 at 04:52:27PM +0100, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > On Wed, Feb 06, 2019 at 10:03:09AM +0000, Priit Laes wrote:
> > > > > > I'm concerned for other users of the PLL-PERIPH clock. AFAIK
> > > > > > all of them, except the HRTIMER, expect the clock rate to stay
> > > > > > the same and not change underneath them. And SATA expects it to
> > > > > > be at 600 MHz, as the datasheet says. And while it may not directly
> > > > > > apply to the LIME2, eMMC on newer SoCs / boards run at the slightly
> > > > > > reduced rate of 50 MHz just fine.
> > > > > > 
> > > > > > In the commit in question, clocks without CLK_SET_RATE_PARENT
> > > > > > should be using the old code (now in the if conditional block),
> > > > > > i.e. the behavior should not have changed.
> > > > > > 
> > > > > > I don't think this actually "fixes" whatever bug was introduced,
> > > > > > but only papers over the issue, and possible introduces further
> > > > > > issues for other users.
> > > > > 
> > > > > You're right, I've overlooked that it was pll-periph being
> > > > > affected. I've dropped it for now.
> > > > 
> > > > Any ideas what could be done. I currently have no time to debug it,
> > > > but it affects existing systems.
> > > 
> > > I can't find what would change with that commit either if the flag
> > > isn't set, so looking at the register state before and after that
> > > commit would help I guess?
> > 
> > Register dump without the patch:
> > 
> > $ busybox devmem 0x01c20090
> > 0x0250030E
> > 
> > pll-ddr-base     2 2 0   768000000          0     0  50000
> >    pll-ddr-other 1 1 0   768000000          0     0  50000
> >       mmc2       3 3 0    51200000          0     0  50000
> > 
> > Register dump with patch applied, booted from mmc0 and after mounting emmc:
> > 
> > $ busybox devmem 0x01c20090
> > 0x8140020B
> > 
> > pll-periph-base  3 3 0  1200000000          0     0  50000
> >    pll-periph    6 6 0   600000000          0     0  50000
> >       mmc2       3 3 0    50000000          0     0  50000
> 
> I meant the whole Clock controller, ideally a diff between the two
> states would be great.

I have uploaded the raw files here:
https://gist.github.com/plaes/3465386d8aa55fa70fd3997310719828

The test scenario is following:

1) Boot via FEL (u-boot + zImage + boot.scr) and load root fs from
sd-card / mmc0

2) ssh into machine and dump register space

- no-patch-before-mount.dump
- no-patch-post-mount.dump

3) Attempt to mount emmc / mmc2 and dump ccu register space
- with-patch-before-mount.dump
- with-patch-post-mount.dump


Firstly, I noticed that first 0x200 bits are mirrored:
0x1c20000 = 0x1c20200
0x1c20004 = 0x1c20204
...
01xc201fc = 0x1c203fc

And here come the diffs:

a) Diff before mount vs patch / reverted patch:

mmc2:
  -0x1c20090: 0x0250030E
  +0x1c20090: 0x0140020B
unk1: (mirrored ahb?, this one's flaky due to mmc runtime suspend)
  -0x1c20260: 0x1200C17F
  +0x1c20260: 0x1200C07F
unk2: (mirrored mmc2?)
  -0x1c20290: 0x0250030E
  +0x1c20290: 0x0140020B

b) Diff post-mount vs patch / reverted patch:

ahb (this one's flaky, possibly due to runtime suspend for mmc):
  -0x1c20060: 0x1200C07F or 0x1200C17F
  +0x1c20060: 0x1200C47F
mmc2:
  -0x1c20090: 0x0250030E
  +0x1c20090: 0x8140020B
unk1:
  -0x1c20260: 0x1200C07F
  +0x1c20260: 0x1200C47F
unk3:
  -0x1c20288: 0x8140030B
  +0x1c20288: 0x0140030B
unk2: (mirrored mmc2?)
  -0x1c20290: 0x0250030E
  +0x1c20290: 0x8140020B



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

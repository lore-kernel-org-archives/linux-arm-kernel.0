Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80710C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:43:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E34F2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hh2oivjk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="SSYNMskN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E34F2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MsLMJAhOdh/aAaK8pGYf8JK8M2bajZ7rhZbIlG9o4w4=; b=hh2oivjkqNvFXi
	/tv5IPzagvNDw8CrwnftdxCn7Qi1TcZWdjUjUPggZHXyXqs7TiE7ogFYfHRJi+Zz0Ac4sw0EJv7c1
	odXjjJDRVnz2F/bQ7qEbe28x/qCmJ8RWf7lgKWqjy9q2jDAYOk3cVPo1ydQQClWdtu0/XSIb1YCDy
	qma1aFD0zhrhNCPzbt3djLZmEybI1CcY6S0wJ2KsdjgzvTqoIrFsAQ5Fn4M49fU225C8GJM02itCp
	lX+RCtWeEal0Y1FZQ2hT+2OydKx3dy6BJ8slcfksS+zL/BM4kzbJ0PBd9Y9Y3WBxPfq4ECMAMUxVZ
	3rf6w8d2ZDOQPn9/CjIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr1ww-0005R4-NF; Tue, 05 Feb 2019 14:43:46 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr1ws-0005Qi-Hl
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 14:43:44 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 38E8F25B7E9;
 Wed,  6 Feb 2019 01:43:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549377821; bh=2u8SIRvTU9KWituJleBN2anp8zYzDFQNvvh/gKo/+04=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SSYNMskNvSXIYgDrbQ/6ymp0xvMDSkkf3QgKtZ00Ma2QqhTZm44c3U6kbdaZ4EIrA
 V04hU+REcOJvCO192UiwvfiaH5EysDwOxBk33/2t8lqB5GINvejHOs9H5FUQHTcsxi
 dlCwdjB0SvQci6SlNHKKu+uzcgIakJ0GcVW0XcXs=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 5D92A940486; Tue,  5 Feb 2019 15:43:39 +0100 (CET)
Date: Tue, 5 Feb 2019 15:43:39 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add OPPs table for
 cpu devices
Message-ID: <20190205144339.jw7twglsqgd5md2y@verge.net.au>
References: <1547553762-4467-1-git-send-email-ykaneko0929@gmail.com>
 <20190128140519.wfbnpgznbkx3msft@verge.net.au>
 <CAMuHMdW2j4e4yc2ZkeJ71uqGz7FS2Kb2141tyZp9y3zTrJ21_g@mail.gmail.com>
 <20190128163639.kv77wczde7d7lntv@verge.net.au>
 <20190130094607.z7sqc2vqt4c7kzd4@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130094607.z7sqc2vqt4c7kzd4@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_064342_736518_E721C295 
X-CRM114-Status: GOOD (  18.82  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Yoshihiro Kaneko <ykaneko0929@gmail.com>, Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 10:46:12AM +0100, Simon Horman wrote:
> On Mon, Jan 28, 2019 at 05:36:39PM +0100, Simon Horman wrote:
> > On Mon, Jan 28, 2019 at 04:15:30PM +0100, Geert Uytterhoeven wrote:
> > > Hi Simon,
> > > 
> > > On Mon, Jan 28, 2019 at 3:05 PM Simon Horman <horms@verge.net.au> wrote:
> > > > On Tue, Jan 15, 2019 at 09:02:42PM +0900, Yoshihiro Kaneko wrote:
> > > > > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > > >
> > > > > This patch define OOP tables for all CPUs.
> > > > > This allows CPUFreq to function.
> > > > >
> > > > > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > > > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > > > > ---
> > > >
> > > > Thanks, I have tested CPUFreq with this tested that with this patch and
> > > > "[PATCH] clk: renesas: r8a77990: Add Z2 clock"
> > > > (https://patchwork.kernel.org/patch/10783723/) applied on top of
> > > > renesas-devel-20190128-v5.0-rc4.
> > > >
> > > > Geert, or others, is it expected that z2 does not scale
> > > > in this test?
> > > 
> > > Given your patch adds the Z2 clock as a fixed clock, this is expected ;-)
> > > 
> > > Note that the BSP adds this clock as a programmable clock of type
> > > CLK_TYPE_GEN3_Z2.
> > 
> > Thanks, understood.
> 
> I have now tested this patch in conjunction with
> "[PATCH v2 0/6] clk: renesas: r8a77990: Add Z2 clock" [1],
> which implements Z2 as a variable clock, and the results
> seem substantially better.

With the above in mind I have applied this patch for v5.1.

> 
> # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> performance
> # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> 800000 1000000 1200000 
> # grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1200000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1200000
> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:1200000
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1200000
> /sys/kernel/debug/clk/z2/clk_rate:1200000000
> 
> # echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> # grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:975000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1000000
> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:975000
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1000000
> /sys/kernel/debug/clk/z2/clk_rate:975000000
> 
> # echo 800000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> # grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq /sys/kernel/debug/clk/z2/clk_rate
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:787500
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:800000
> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:787500
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:800000
> /sys/kernel/debug/clk/z2/clk_rate:787500000
> 
> # echo 1200000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq grep . /sys/devices/system/cpu/cpu*/cpufreq/*_cur_freq
> # /sys/kernel/debug/clk/z2/clk_rate
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:1200000
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:1200000
> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:1200000
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:1200000
> /sys/kernel/debug/clk/z2/clk_rate:1200000000
> 
> Tested-by: Simon Horman <horms+renesas@verge.net.au>
> 
> [1] https://lore.kernel.org/linux-renesas-soc/20190130094029.9604-1-horms+renesas@verge.net.au/T/#mec59a349508e0be00d3a1d6ef89f838c0e193591
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

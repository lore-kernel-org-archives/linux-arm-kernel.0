Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:33:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DDF20660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K+S08jcx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Fu/39nkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DDF20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HHv9A4VO1SuTX0jNJaREoht5bQSfahl/QxAD+Dyl8gQ=; b=K+S08jcxm/notr
	/d687Fs4k7iakrH1PAnYTjMkvBYd3m06gYXAJCZfQgwwdKKcFLSMIH8mzmflsN9OawYaSEQ4Cwu+g
	WD2jLt7SZMTJWJYiDbT3+jS4JnBH1zuTonEw0swlykNDU8fCDjNwOHItHMWB63sYbLUFDl78JKJ+2
	348kTlROJxnHC2fSqvHMUcX3Jyke6xyuS/N1HdiD0wRKYXidMmq3NN/veFTlbh440a23+k4CADPb+
	bv9aZJ3HtaoYxTOBmPn+0XY6HgWS/ZbEGD735BfTwVmAULNQRLw9y/zgQPVFOkSDQgdHwdcyilnW3
	i0JAsIy2AsRvHD5jlBWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghD2f-0005Hl-Hd; Wed, 09 Jan 2019 12:33:05 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghD2d-0005HN-3G
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 12:33:04 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 934A225B80E;
 Wed,  9 Jan 2019 23:33:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547037181; bh=c0kudzL6mJdqc9pijvmi75mvURmSmwTS0RjBJOL/YYc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fu/39nkJJISbYItVPnHrA4X86gLh4fHczQx4sZ1rG+jNK3eq+2eTVe7O6xReYbdM6
 +NAitHu4h79YZ0EP8aukKbCNNmc+BtOfSZSXmSd7QtFkCwX6YBC7wSjjS+RL5oB0pz
 wZhAWrvumAhR1+HMpN5u+eUN181E90ep+Ffv64zQ=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 0BDD7940420; Wed,  9 Jan 2019 13:32:59 +0100 (CET)
Date: Wed, 9 Jan 2019 13:32:59 +0100
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
Message-ID: <20190109123259.cpql62omcvypafdu@verge.net.au>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
 <20190109104922.z6g772vgncdqqbqt@verge.net.au>
 <20190109105754.vvqx6uvsktvxeq7a@ninjato>
 <34cd1769-f0c9-0c2b-8947-4fceca9a9fb2@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34cd1769-f0c9-0c2b-8947-4fceca9a9fb2@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_043303_284943_237AEC45 
X-CRM114-Status: GOOD (  10.88  )
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
Cc: devicetree@vger.kernel.org, Takeshi Kihara <takeshi.kihara.df@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 09, 2019 at 01:02:00PM +0100, Marek Vasut wrote:
> On 1/9/19 11:57 AM, Wolfram Sang wrote:
> >> [    3.373714] renesas_sdhi_internal_dmac ee100000.sd: mmc0 base at 0xee100000 max clock rate 200 MHz
> >> [    3.456829] renesas_sdhi_internal_dmac ee120000.sd: mmc1 base at 0xee120000 max clock rate 200 MHz
> > 
> > No mmc2 initialized. That should work regardless of eMMC. Probably
> > something wrong in the DT somewhere.
> 
> Weird, it worked in next-20181102 with these patches, I just rechecked:
> 
> 7818a9f06df1 mmc: renesas_sdhi: Whitelist R8A77990 SDHI
> a05a906776f8 pinctrl: sh-pfc: r8a77990: Add voltage switch operations
> for SDHI
> 2cc9d3a293e9 pinctrl: sh-pfc: r8a77990: Add SDHI pins, groups and functions
> 6b8d151613b7 pinctrl: sh-pfc: r8a77990: Add Audio SSI pins, groups and
> functions
> 9167b22938f7 pinctrl: sh-pfc: r8a77990: Add Audio clock pins, groups and
> functions
> 000cc50fc942 arm64: dts: r8a77990-ebisu: Enable HS200 of SDHI3
> d3f59bbbf7ce arm64: dts: r8a77990-ebisu: Enable eMMC of SDHI3
> 5928c59bff8d arm64: dts: r8a77990-ebisu: Enable UHS-I of SDHI0 and SDHI1
> dae32a3172b8 arm64: dts: r8a77990-ebisu: Enable SD card of SDHI0 and SDHI1
> 8feef039c6c6 arm64: dts: r8a77990: Add SDHI device nodes
> 25e9471b6a27 (tag: next-20181102) Add linux-next specific files for 20181102
> 
> I'll let you know once I figure it out.

Could it be related to potentially old U-Boot etc.. on the board I am using?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

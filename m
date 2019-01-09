Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E947C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:49:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFC620883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G2CkzYDF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="LqktMtST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFC620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bOgwwqhkkBcjgqQczQeQy1uoMKtUZupUyg+Cr1/5dSQ=; b=G2CkzYDFdYYxyW
	r3ug85OQwtHvTMfVLbK6oFKUrNQJ4XmJq0A3Sk8COq23XEEmmPPFlxXLTzZZD2LLCEkSgUAVyNsTb
	EKumUASC/2Ftaf/SuImXlyLlBhVh9alnJ9jKm623/EXhHcpMWL9FZiXmZS2T9lIDr0DB362i4P3e4
	rO+8hQulcRlLrPFadiZE7QF3PrsTjrHzApYeYDj37EoeU/g4gui/Qlf5w01cDryN+yJQqekuUelTV
	wKafo+HrkgYUwztSGP4XJsc0uwwk4uN6hkUaOWJ7E01vDLKRmcDaIeOlfi6EzPdqd7u3dGnRvKfpN
	IOz81ddCehjR4u5Dxf0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghBQY-0005h0-PU; Wed, 09 Jan 2019 10:49:38 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghBQU-0005g1-Db
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:49:36 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 8094B25B80E;
 Wed,  9 Jan 2019 21:49:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547030969; bh=LKXO8zcXECK3Z+jgyKSjhVkgQgL5dGIf+8p3A1CZhoQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LqktMtSTgksgQL8urbGfpXwVrsBYA/T7IWzQWHQfFRVtG/IeELuyrllJNIm97DrMA
 3dm/wZV8m5ajOTjro3uZ+2dYIUO9TC3kfSZjX/WrGu6HPGTPKeO+voGFxOkJU2//ss
 +DFCnkY/Y7nf3t1/If0scKkQX4lRS0Zk8R/V3w4E=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id C4BB9940420; Wed,  9 Jan 2019 11:49:27 +0100 (CET)
Date: Wed, 9 Jan 2019 11:49:27 +0100
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
Message-ID: <20190109104922.z6g772vgncdqqbqt@verge.net.au>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_024934_831823_0A92F262 
X-CRM114-Status: GOOD (  12.28  )
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

On Tue, Nov 06, 2018 at 09:46:47PM +0100, Marek Vasut wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch adds SDHI{0,1,3} device nodes for the r8a77990 SoC
> and enables SD card slot connected to SDHI0, micro SD card slot
> connected to SDHI1 and eMMC connected to SDHI3 on the Ebisu board
> using the R8A77990 SoC.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
> V2: - Deduplicated regular and UHS pins
>     - Added sdhi3_ds pin pinmux
> V3: - Squash two patches, one adding SDHI nodes to R8A77990 E3 DTSI
>       and another enabling them on E3 Ebisu, together.

Hi,

I am wondering if something special is required in order to use eMMC
connected to SDHI3. Using renesas-drivers-2019-01-08-v5.0-rc1 I do not see
that device initialised to the point where a corresponding block device is
present.

[    0.000127] NOTICE:  BL2: R-Car Gen3 Initial Program Loader(CA53)
Rev.1.0.21
[    0.005703] NOTICE:  BL2: PRR is R-Car E3 Ver.1.0
[    0.010361] NOTICE:  BL2: PLL1 nonSSCG Clock select
[    0.015356] NOTICE:  BL2: Board is Ebisu-4D Rev.1.0
[    0.020041] NOTICE:  BL2: Boot device is HyperFlash(80MHz)
[    0.025479] NOTICE:  BL2: LCM state is CM
[    0.029445] NOTICE:  BL2: 0x400000000 - 0x480000000, 2 GiB
[    0.034877] NOTICE:  BL2: DDR1856(rev.0.07)NOTICE:  ..0
[    0.040425] NOTICE:  BL2: DRAM Split is OFF
[    0.044304] NOTICE:  BL2: QoS is default setting(rev.0.02)
[    0.049748] NOTICE:  BL2: DRAM refresh interval 3.9 usec
[    0.055089] NOTICE:  BL2: v1.4(release):15dba6b-dirty
[    0.060029] NOTICE:  BL2: Built : 04:48:01, Jun 26 2018
[    0.065217] NOTICE:  BL2: Normal boot
[    0.068872] NOTICE:  BL2: dst=0xe6311d00 src=0x8180000 len=512(0x200)
[    0.075247] NOTICE:  BL2: dst=0x43f00000 src=0x8180400 len=6144(0x1800)
[    0.081874] NOTICE:  BL2: dst=0x44000000 src=0x81c0000 len=65536(0x10000)
[    0.089118] NOTICE:  BL2: dst=0x44100000 src=0x8200000 len=1048576(0x100000)
[    0.103992] NOTICE:  BL2: dst=0x50000000 src=0x8640000 len=1048576(0x100000)

# dmesg | egrep "(sd|mmc)"
[    2.872441] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    2.878587] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    2.885806] renesas_sdhi_internal_dmac ee120000.sd: Got CD GPIO
[    2.893284] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.2
[    2.901602] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.1
[    2.909708] renesas_sdhi_internal_dmac ee160000.sd: Failed getting OCR mask: 0
[    2.917236] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.1
[    2.925214] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.2
[    3.295711] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    3.301808] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    3.308042] renesas_sdhi_internal_dmac ee100000.sd: Linked as a consumer to regulator.4
[    3.316268] renesas_sdhi_internal_dmac ee100000.sd: Linked as a consumer to regulator.6
[    3.373714] renesas_sdhi_internal_dmac ee100000.sd: mmc0 base at 0xee100000 max clock rate 200 MHz
[    3.384547] renesas_sdhi_internal_dmac ee120000.sd: Got CD GPIO
[    3.390915] renesas_sdhi_internal_dmac ee120000.sd: Linked as a consumer to regulator.5
[    3.399171] renesas_sdhi_internal_dmac ee120000.sd: Linked as a consumer to regulator.7
[    3.456829] renesas_sdhi_internal_dmac ee120000.sd: mmc1 base at 0xee120000 max clock rate 200 MHz
[    3.468133] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.2
[    3.476448] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.1
[    3.484635] renesas_sdhi_internal_dmac ee160000.sd: Failed getting OCR mask: 0
[    3.492147] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.1
[    3.500110] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.2
[    3.562322] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.2
[    3.570834] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.1
[    3.579021] renesas_sdhi_internal_dmac ee160000.sd: Failed getting OCR mask: 0
[    3.586657] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.1
[    3.594653] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.2
[    3.640782] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.2
[    3.649110] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.1
[    3.657213] renesas_sdhi_internal_dmac ee160000.sd: Failed getting OCR mask: 0
[    3.664677] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.1
[    3.672599] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.2
[    3.688811] mmc0: new ultra high speed SDR104 SDXC card at address 0007
[    3.698572] mmcblk0: mmc0:0007 SL64G 58.3 GiB 
[    3.726399]  mmcblk0: p1
[    3.763694] mmc1: new ultra high speed SDR104 SDHC card at address 0001
[    3.772525] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.2
[    3.781623] mmcblk1: mmc1:0001 00000 29.8 GiB 
[    3.786779] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.1
[    3.795548] renesas_sdhi_internal_dmac ee160000.sd: Failed getting OCR mask: 0
[    3.803099] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.1
[    3.811006]  mmcblk1: p1
[    3.815437] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.2
[    3.856991] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.2
[    3.865263] renesas_sdhi_internal_dmac ee160000.sd: Linked as a consumer to regulator.1
[    3.873371] renesas_sdhi_internal_dmac ee160000.sd: Failed getting OCR mask: 0
[    3.880864] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.1
[    3.888786] renesas_sdhi_internal_dmac ee160000.sd: Dropping the link to regulator.2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

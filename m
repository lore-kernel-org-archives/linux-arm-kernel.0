Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D07C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:44:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED4521849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XBUn+qx6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="D03xQT3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED4521849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yh01I/TJ2+wZghB8pENff90cAB2mOLhIqhJK23UdkxU=; b=XBUn+qx6T8uZTU
	luzySpbLIhWktFCZ8k3Mven10T5ZnkSEt7jYmfl8EcAEIPDXiKi46yE7yaupQKRNSdMRNRpw8XfUh
	EgTD3RVfANdC9PH3YqefTWEz3hd8G9q3BDmf0ryEnb71ZqwpZ9rOzAO6I8dDe+zB57h9m0504qRhl
	bKaDGPqcx6vOHfIJjS1i3Q0F79M3aWTvZCYIMUvZ/py8eftD3AUO8LG6cAnC72s8mBr8dPV7hgBA/
	Ts5voXMPvj62Ysf9Cs5NYgXGGJK5grqwlOE4tQF3uFp5LjzZ+ew9uXjSStpnQOqq6gJNVIYKQDPZq
	E2h0c8ELYFHMe7/lGy2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZBvW-0006QK-UX; Tue, 18 Dec 2018 09:44:34 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZBvU-0006Do-1k
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 09:44:33 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 9769425B75B;
 Tue, 18 Dec 2018 20:44:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1545126256; bh=h8+vdbtUvz4i8LtdAD3JOr+P3D9Xylmf/FyK1LfVORE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D03xQT3JOYMg/7cFXFtfn2ZYxYYBkEz1uKosDElZmToBlmhaw3IARXtb/MZraGQZ2
 RnohWZH6ZjhGtH4Hii+mMzjShA3ML6NKuOn1qKGUwggV3OV1lgGrRLKFY/kT/+pKh4
 1obLVkHFrGf2tU++U+V5bAMgQP6l4KRb8sthk55Q=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 3C725940274; Tue, 18 Dec 2018 10:44:13 +0100 (CET)
Date: Tue, 18 Dec 2018 10:44:13 +0100
From: Simon Horman <horms@verge.net.au>
To: arm@kernel.org
Subject: Re: [GIT PULL v2 0/3] Renesas ARM64 Based SoC Defconfig Updates for
 v4.21
Message-ID: <20181218094407.hfe7aei2hmnsih5u@verge.net.au>
References: <20181214115647.12391-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181214115647.12391-1-horms+renesas@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_014432_278821_706FDEF7 
X-CRM114-Status: GOOD (  19.71  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Again,

On Fri, Dec 14, 2018 at 12:56:47PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM64 based SoC defconfig updates for v4.21.
> 
> As requested I have revised the series to enablement of ASoC simple SCU
> sound card support to do so as a module rather than a built-in.
> 
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-v2-for-v4.21
> 
> for you to fetch changes up to 72c636469a3606f8aa69d9208d614f78d99f2d25:
> 
>   arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE (2018-12-13 12:24:58 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM64 Based SoC Defconfig Updates for v4.21 (v2)
> 
> * Enable in arm64 defconfig:
>   - Renesas R-Car Gen3 PCIe PHY driver
>   - Renesas R-Car thermal driver
>   - ASoC simple SCU sound card support

It seems that Morimoto-san has determined that the sound card patch is not
necessary. Rather than move to v3 for these not entirely critical changes I
would prefer to withdraw this pull request and revisit these changes for
v4.22 although if you do happen to pull this then I don't think any harm
would be done.

I apologise for any inconvenience this may cause.

> Changes in v2
> * Enable ASoC simple SCU sound card support as a module rather than a built-in
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE
> 
> Simon Horman (2):
>       arm64: defconfig: Enable R-Car thermal driver
>       arm64: defconfig: Enable scu-simple-card driver
> 
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

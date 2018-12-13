Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D82C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:57:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1725B2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aVkbUPhz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="PgpVOvVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1725B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OHeqaIaxkTT+J/M/J2U7+L+lePeLRYg1he95OOYx1KI=; b=aVkbUPhzo2EfAM
	zNqWQPhrp2H86I4RMkg9WuEFTY8sx9wTsR75Dwvb9kbYaTzwcm0Fl0TEVLEelHoNuPFXq2dV2OWT6
	0DGCYKAfOeat75wW/i8qE8zAegWdCkMrkko25dM+TCqcA+uND4QEjT1iIA2dG+GYZZRlbiVQnD88d
	HsmOKEqCoNwO4L7z4hOgq4OctK/rZG//hMVdWvyV+Afo6XnHhJk0sTszSENBEJ9OdlIH/1Uztvfbn
	duqy94/7LN8bjAEFfypNnxB9i6uZB0E+v/OUhcMw31yOCQCS6Ul4/NNkDaYh22K4KGmkeRtW3E3Zw
	xi51MIRuWi6RbkT4bYEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXQXy-0002rO-Ha; Thu, 13 Dec 2018 12:56:58 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXQXv-0002qI-BR
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 12:56:57 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 7F44925B781;
 Thu, 13 Dec 2018 23:56:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544705800; bh=vyJBOS2idZ5M5pAM7YllTZkwWNv17LFtOBEejuGDvjs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PgpVOvVXs5DWGG32WVr0x4hZQSakVbZXo2cpLK2ERGlym0Bg5BlCl5ktD1zFsxz4T
 epX82FkYEeFzFQxuTt/vPx6F5NGl5bz8d4X3j6iKrlullUGzxqCT6kXFi/Jh+oEUn9
 U0AxPG5hrjyh7P5vMj7BrJsSmInuJnNedlvOEgR4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 0E233940421; Thu, 13 Dec 2018 13:56:38 +0100 (CET)
Date: Thu, 13 Dec 2018 13:56:38 +0100
From: Simon Horman <horms@verge.net.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.21
Message-ID: <20181213125634.hx3uv5ymux2q6qxr@verge.net.au>
References: <cover.1544126077.git.horms+renesas@verge.net.au>
 <20181212214230.stbka7njol6qgvpj@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212214230.stbka7njol6qgvpj@localhost>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_045655_575979_688E8457 
X-CRM114-Status: GOOD (  18.76  )
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
 arm@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 01:42:30PM -0800, Olof Johansson wrote:
> Hi Simon,
> 
> On Thu, Dec 06, 2018 at 01:57:02PM -0800, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM64 based SoC defconfig updates for v4.21.
> > 
> > 
> > The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> > 
> >   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> > 
> > are available in the git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.21
> > 
> > for you to fetch changes up to fe16bcd6d44f1a2bccc4618119463d9d23a6ae92:
> > 
> >   arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE (2018-11-16 06:56:49 -0800)
> > 
> > ----------------------------------------------------------------
> > Renesas ARM64 Based SoC Defconfig Updates for v4.21
> > 
> > * Enable in arm64 defconfig:
> >   - Renesas R-Car Gen3 PCIe PHY driver
> >   - Renesas R-Car thermal driver
> >   - ASoC simple SCU sound card support
> > 
> > ----------------------------------------------------------------
> > Geert Uytterhoeven (1):
> >       arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE
> > 
> > Simon Horman (2):
> >       arm64: defconfig: Enable R-Car thermal driver
> >       arm64: defconfig: Enable scu-simple-card driver
> 
> This patch enables the sound driver as a built-in. We normally try to keep all
> non-critical drivers (i.e. drivers not needed to reach a rootfs) as modules to
> avoid the defconfig kernel from bloating up too much.
> 
> Would you mind respinning this with the sound driver as a module instead?

Sure, will do.

> For PCIe I can see the argument that you might have rootfs on nvme or otherwise
> attached to that bus, so static there is fine.
> 
> 
> Thanks!
> 
> 
> -Olof
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DB9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:52:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22F12081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kBNF0myi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yWrnYy4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22F12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eCsEx304aZjyszvS6BjbRrKEApCdXowBLuL21FoSz8Q=; b=kBNF0myinAzIlS
	uNpBvR2f20iIv+fGbjuq+hr30VFjXCMkZx0hhJufTpGEBQeBdcy1bNJtqoHi34acylY2ABwNyfbI3
	06mOeNL/fMj8EdSWacZWpt47WaJneGeKcH11A3zONB0L1o6zLi8y2mxEp/pCJs1gpOootT6OoK0cJ
	5ecjjTgoa8dCZuEjhoYvIoLOKFyGahlfYxWBh44N3E+p7qhOfZAFe5Lr3gJNnJkN4sKoOrmJsSYhh
	mLlLPQJOJvVSN31Cv5PH9nxJ4Zq4HQ6zgupaCMWPl6fye06n87YKFJrQuavQ7+7dVK1fvouuLiPv4
	4iVtdUQw+gvEURmNsM3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWY9r-0006bk-B8; Tue, 11 Dec 2018 02:52:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWY9o-0006bN-4n
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 02:52:25 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 855512081B;
 Tue, 11 Dec 2018 02:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544496733;
 bh=NsXMFggUvn6uXR25rnKUoNv8fzMakX4AAYqAlPCcgM4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yWrnYy4lpquqEFRudHzt9KGgD7Ih7wJg+4itV5Z6TzUT6GwcyxcC+Gq/Mhxw1Os98
 Ru4dqLx7LXt6k1YHG1xD6SLtnr5v+quF6SSek1BLler1r3dGiivMAOBem2HF1pNjOx
 Zu5fP5bDohZf9N/GVSbUid72Z2A1Omnv05zaEzjM=
Date: Tue, 11 Dec 2018 10:51:16 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: Re: [GIT PULL 2/7] i.MX SoC changes for 4.21
Message-ID: <20181211025115.GU3987@dragon>
References: <20181210074638.27873-1-shawnguo@kernel.org>
 <20181210074638.27873-2-shawnguo@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210074638.27873-2-shawnguo@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_185224_209885_65861211 
X-CRM114-Status: GOOD (  15.53  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 03:46:33PM +0800, Shawn Guo wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d=
2a:
> =

>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> =

> are available in the Git repository at:
> =

>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/i=
mx-soc-4.21

I just updated the tag to include Arnd's fix on SOC_IMX7ULP option
dependency.  Please pull this one, thanks.

Shawn


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx=
-soc-4.21

for you to fetch changes up to 167e63702d090b831c513d726b11a412b70aab09:

  ARM: imx: fix dependencies on imx7ulp (2018-12-11 10:41:20 +0800)

----------------------------------------------------------------
i.MX SoC changes for 4.21:
 - An improvement on i.MX debugging options that only defines
   DEBUG_IMX_UART_PORT if needed, so that the option will not be present
   in the kernel config when DEBUG_LL is disabled.
 - Adds the necessary platform support for i.MX7ULP SoC and configures
   power mode to Partial Stop mode 3 with system/bus clock enabled.
   Otherwise the default STOP mode will gate off system/bus clock when
   WFI gets executed on i.MX7ULP.
 - A fix from Arnd on SOC_IMX7ULP option dependency.

----------------------------------------------------------------
A.s. Dong (1):
      ARM: imx: add initial support for imx7ulp

Arnd Bergmann (1):
      ARM: imx: fix dependencies on imx7ulp

Uwe Kleine-K=F6nig (1):
      ARM: debug-imx: only define DEBUG_IMX_UART_PORT if needed

 arch/arm/Kconfig.debug           | 28 ++++++++++++++--------------
 arch/arm/mach-imx/Kconfig        |  9 +++++++++
 arch/arm/mach-imx/Makefile       |  1 +
 arch/arm/mach-imx/common.h       |  1 +
 arch/arm/mach-imx/cpu.c          |  3 +++
 arch/arm/mach-imx/mach-imx7ulp.c | 31 +++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mxc.h          |  1 +
 arch/arm/mach-imx/pm-imx7ulp.c   | 29 +++++++++++++++++++++++++++++
 8 files changed, 89 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/mach-imx/mach-imx7ulp.c
 create mode 100644 arch/arm/mach-imx/pm-imx7ulp.c

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

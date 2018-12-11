Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92939C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:49:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5515F20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XFRC8X0d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ0Bl0Gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5515F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SZ7wYKuMM496+2vKANCwt/TFy6Kh7M38dYNreWKl5rg=; b=XFRC8X0dL9sOxP
	O9MxmbnzchwC7vUr7sNX17zo9KLhz5GTIUGsJax8SHjA2J7uOditBWkU9Ks1GEyNoMTgqO9VoL9gu
	ekp8OJmVxB4k/a55CUezAGaZG/FCknJCToznIbeYDcN+1qWsjfjj3jaby92NsmZ9kB9A1LdXra/rA
	K8eR/0Pc2tFRiwDdcBWdkUQ2NMx6FPfZQmDELRjjz4hlgSJqVunDtc++fvN+nMuuFBLWPiN4zGtKf
	yhxzxLR/1HP4pTTib0FXQfgqoxETWyesk12Y6o4h76UVBPY5tl0ai2Uz97H/7O9/SNCyGI5Fbflvd
	0fujIqPLUlCl5cTrzN+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWY7J-0004Zu-4A; Tue, 11 Dec 2018 02:49:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWY7G-0004ZE-0h
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 02:49:47 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BBE3E20645;
 Tue, 11 Dec 2018 02:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544496574;
 bh=nmRn5PYV+FDErFccqUr/NhgLVTQjTK6NW6we9P51rFw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iJ0Bl0Gn09CzlA7CIJej7DpZzgEQY875mizQtDfTK/Wt4zpqFJFk5Aq1F6+PxzLYL
 Nb+rOt4uIsQrsoIN5+B5gcpL3aMo8VwZ+Yud7huaOgh4E1oW2YNPW0+JFpNSk6ijFp
 ViLhNBobiJnKV6UC8xukObEOyzgx1uszctBp/1+A=
Date: Tue, 11 Dec 2018 10:48:38 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: imx: fix dependencies on imx7ulp
Message-ID: <20181211024837.GT3987@dragon>
References: <20181210204816.2516007-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181210204816.2516007-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_184946_078018_A55908AF 
X-CRM114-Status: GOOD (  10.71  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>,
 arm@kernel.org, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 09:47:59PM +0100, Arnd Bergmann wrote:
> The i.MX7D configuration was reworked, but that change did
> not get propagated into the newly added i.MX7ULP, which now
> produces a Kconfig warning:
> 
> WARNING: unmet direct dependencies detected for HAVE_ARM_ARCH_TIMER
>   Depends on [n]: CPU_V7 [=n]
>   Selected by [y]:
>   - SOC_IMX7ULP [=y] && ARCH_MXC [=y] && (ARCH_MULTI_V7 [=n] || ARM_SINGLE_ARMV7M [=y])
> 
> Change it to work the same way as i.MX7D.
> 
> Fixes: 1a1f919eb52e ("ARM: imx: Provide support for NXP i.MX7D Cortex-M4")
> Fixes: acb83c0eb036 ("ARM: imx: add initial support for imx7ulp")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the fixup, Arnd.  Applied.

Shawn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

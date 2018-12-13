Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED77C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:58:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927B42080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XjvQ+svU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Nyil1uEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927B42080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5QLcvfYxQNRC5rVkoP8J/VwTKHzJ+/ihyQRx+i76qCw=; b=XjvQ+svU/5dCOZ
	smVPCnZgcvwEJj4rH33oUF/2vdIJ9gJ1RbiF8oDjABrEJgrR2piVYSSOFvfu4VBUkhqVObjGXJPjs
	Jf7WGM7InY1JR6lXCu1YJkMsRuUYM9B8qzKR9OKWamyeMLRh4kLXT1qeSpkjc/SzpDeB6sHtorPPR
	ebQgfqfKnBWXtPdUy0tc2V7BGRmK0Fqo4pIjfLNDVK0MLi31/XCO8Tpiz/mH4HudyNgGm+Fw2xY4o
	L0paczmvcXuwR9buVzmyDoUqm45RDMvThCrWeWr0tkO3/jyhUKtBvB3i/T1WRKbJaLmC35S9hAjTi
	fRiGJY3H0S0C0EAd8mEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXKxG-0007wR-6j; Thu, 13 Dec 2018 06:58:42 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXKqe-0004BH-Hr
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 06:51:59 +0000
Received: by mail-lj1-x244.google.com with SMTP id l15-v6so771481lja.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 22:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=L/ZYQFDf7WS7FvF88HIBsNhg7P6SRIY1tlsTQv7X9W4=;
 b=Nyil1uEG3eMkzXLT0KptVLJOR9WM7yXOKcsgPVvMxHQ62JcnnNd8mgVYhUhV/uDqhx
 oGwbq+s2EKL1VgYetZFHnsaVKzrpfRn3sEZeQ+GZmESDf+Q9jIKAGk/CzYyEGmhCrpxY
 nTjMbgkgkkW8gbHE7kjwdS0/+FTkLDd2gBgR66n9WNwdR2/oR9XuIvsdTEjTeUkYeeEd
 9Bh4nkrS2h34ptQ9NnhJIsRHzmI12oY6T3tu6V/iDsLgOfxzLa68mwCUG5gIcou5bTfv
 ORcxruL0pSy9ujoaIZPRdp8HuCEQSQFUDHF+3QJWr0aUQ8JIwHenwo139f57vrxBmBpB
 U+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=L/ZYQFDf7WS7FvF88HIBsNhg7P6SRIY1tlsTQv7X9W4=;
 b=tqY2CzsIWarQE61vTrpltOmGT6JHbvSuwnHO0nYYfvHdOmZ4sdbdmMUcem0WeaKQuf
 JMSsJ9cTbRyGDZRZZXYMB/e5g7zg6psazCxw/C385Jh8j+Hzt6vBdDTr0o81WMgvNuEN
 Rf6XMU2L2d7c8QEI4njR1WwNf5VHPWhhfcAG9ouO11cNRdkDVL6JPRJN+gXPrt3Vpqji
 5u4mO54OBou5UrQSXGEvRFWFyEBRDFYrmmHqlGHNs3EulZnjcS+o2bQ51bApDPjU9jNZ
 FJZzIlIgo56adVq10BaovUUxjTJmLrnNruKtNSgkjwnIgSqx2rSlNSuAT0w9OBuPYTJY
 2nQw==
X-Gm-Message-State: AA+aEWbh/wZLt/ufuNlepVeewyukhz/bKX5wbgxDVUR0EvGzlkuWVujG
 +WZvLzTizBlqWzj65SxrED28IQ==
X-Google-Smtp-Source: AFSGD/W8rX3AGDc1cqBWqJknnArBp1Ighz+bpHpu7y9DrfM7vD1oMv+wgZO9pmPhwZMwnUvc6qrv8g==
X-Received: by 2002:a2e:9b15:: with SMTP id
 u21-v6mr13555035lji.29.1544683907703; 
 Wed, 12 Dec 2018 22:51:47 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id f1sm177993lfm.22.2018.12.12.22.51.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 22:51:46 -0800 (PST)
Date: Wed, 12 Dec 2018 22:51:13 -0800
From: Olof Johansson <olof@lixom.net>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
Message-ID: <20181213065113.sz7ce7kpkenyu3dy@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
 <20181211154159.54yaytbp4pyjqjhg@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211154159.54yaytbp4pyjqjhg@localhost>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_225153_717700_70D9AF10 
X-CRM114-Status: GOOD (  19.41  )
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
Cc: arm-soc <arm@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 07:41:59AM -0800, Olof Johansson wrote:
> On Wed, Dec 05, 2018 at 04:33:37PM +0100, Marc Gonzalez wrote:
> > On 09/11/2018 01:54, Marc Gonzalez wrote:
> > 
> > > Hello ARM maintainers,
> > > 
> > > v3: Keep CRYPTO_DEV_FSL_DPAA2_CAAM in patch 7/9
> > > 
> > > v2: Improve commit message for a few patches
> > > 
> > > The set of Kconfig options slowly changes with every kernel version.
> > > This patch series regenerates the arm64 defconfig for v4.20
> > > No functional change intended, except adding PINCTRL_MTK_MOORE to
> > > keep PINCTRL_MT7622, and adding FSL_MC_BUS and FSL_MC_DPIO to
> > > keep CRYPTO_DEV_FSL_DPAA2_CAAM.
> > > 
> > > Marc Gonzalez (9):
> > >   arm64: defconfig: Regenerate for v4.20
> > >   arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
> > >   arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
> > >   arm64: defconfig: Drop USB_ULPI_BUS and USB_CHIPIDEA_ULPI
> > >   arm64: defconfig: Replace PINCTRL_MT7622 with PINCTRL_MTK_MOORE
> > >   arm64: defconfig: Drop redundant SND_SOC_ROCKCHIP_I2S
> > >   arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
> > >   arm64: defconfig: Change SCSI_UFS_HISI=m
> > >   arm64: defconfig: Drop redundant sound codec options
> > > 
> > >  arch/arm64/configs/defconfig | 108 ++++++++++++++++++++-----------------------
> > >  1 file changed, 49 insertions(+), 59 deletions(-)
> > 
> > Arnd, Olof,
> > 
> > Would you take this series for 4.21-rc1?
> 
> Hi,
> 
> Yeah, I'm happy to look at applying it but will do it towards the end of the
> staging of new contents so we don't get too much conflicts with pull requests
> that come in.

I've applied the patches from the series that were still needed. When
re-running savedefconfig as part of patch 1, several of them were no longer
applicable.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0753C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 21:35:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7935C2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 21:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uB6+zA3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7935C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=x+zZRTFEbEbG8ga2jefAVkPbh4bYFDyvaxDTVsdgwps=; b=uB6+zA3ZOKYUim
	HKFvUmcUm1oLXR7CU7lBiH4subSlYrT96598U0wuKUBqYIw/e1D0YCXaReDuJ1lKUXLHaEtA4AP5e
	mX8U5a7xhXRyUZD/meANa2ZhF5LeM3oXdfEYylE8GEodrCaDxCbFn1ILwtRFBu80HDTtNraiy/sr1
	mdbVU3JFTKjqE7u165RMejHVURGCC3NXb4hrmxrweXs94HfJ4fBdCLfDMPBVDxPTnHznMuaJXMU/n
	SEkFfvDkxeD4MQYkl4PekE6EDS1yRauqv1M4gmszGugS2tEEKMCfGCZf6cd+4JJ9PXW5GtFt4DoKd
	mB8bpj1RlT5GZgpHzh+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gq2wa-0008Ge-Ru; Sat, 02 Feb 2019 21:35:20 +0000
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gq2wW-0007og-7C
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 21:35:18 +0000
Received: from belgarion ([90.76.35.80]) by mwinf5d25 with ME
 id Xxb61z0081jkVcS03xb7Sc; Sat, 02 Feb 2019 22:35:08 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 02 Feb 2019 22:35:08 +0100
X-ME-IP: 90.76.35.80
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: arm@kernel.org
Subject: [GIT PULL] pxa for v5.1
X-URL: http://belgarath.falguerolles.org/
Date: Sat, 02 Feb 2019 22:35:06 +0100
Message-ID: <87womhub5h.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_133516_544917_57B5B734 
X-CRM114-Status: GOOD (  16.84  )
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
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 5.1, totally negative diff stat :)
Can you please consider pulling ?

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-5.1

for you to fetch changes up to d62998480baa6c0367561699dc332f48e0cf03f9:

  ARM: pxa: remove unused empty mach/pxa25x-udc.h file (2019-01-24 21:47:42 +0100)

----------------------------------------------------------------
This is the pxa changes for 5.1 cycle :
 - the last step of raumfeld board conversion to devicetree is here,
   ie. the platform_data file removal
   The previous cycle dealt with devicetree inclusion already.
 - an empty file removal

----------------------------------------------------------------
Daniel Mack (1):
      ARM: pxa: remove raumfeld board files and defconfig

Vladimir Zapolskiy (1):
      ARM: pxa: remove unused empty mach/pxa25x-udc.h file

 arch/arm/configs/pxa_defconfig              |    4 -
 arch/arm/configs/raumfeld_defconfig         |  197 -----
 arch/arm/mach-pxa/Kconfig                   |   18 -
 arch/arm/mach-pxa/Makefile                  |    3 -
 arch/arm/mach-pxa/include/mach/pxa25x-udc.h |    0
 arch/arm/mach-pxa/raumfeld.c                | 1187 ---------------------------
 6 files changed, 1409 deletions(-)
 delete mode 100644 arch/arm/configs/raumfeld_defconfig
 delete mode 100644 arch/arm/mach-pxa/include/mach/pxa25x-udc.h
 delete mode 100644 arch/arm/mach-pxa/raumfeld.c

-- 
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

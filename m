Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B50C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:04:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1443A2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cHIsqoVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1443A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=O0vkuViLXGlGBbdB2b/URhsP6C1wEhGGcBM2LEhaBYA=; b=cHI
	sqoVOtdwyHlUbQV6KC8r4eryv81d8Z0tzRdWqLnaW6/pFKNXWb32kGWFemXKDlyNE9fhzfhSK9FK1
	e2c0KeqBQbuGrhm5lxkrflLAcTallCZiSRzEGyJOuZlAHHzMG/ZKSlRWL6l6uxICtcnr37DcPzoJB
	RhPmXAbJVvccVXuCopynineD8pvvEiqFeO98Mpx0zrfV0/R8Wv6zGuum1qgtkSlQYj1KjFu44mVqO
	cxSyFdJD1QnAHkZzLQuHJLS6UDTIpg/R+WKuPILzI+Kn4SAHcclv5L2rSMyBw2HqmpxT8JN8/xRJ9
	VV3f/CvJY2zPHdKx2F1UgJsYDz9QZTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs9Zq-0000Zx-DB; Fri, 08 Feb 2019 17:04:34 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs9Zn-0000Yt-8w
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:04:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB09E80D;
 Fri,  8 Feb 2019 09:04:30 -0800 (PST)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
 [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 412223F719;
 Fri,  8 Feb 2019 09:04:29 -0800 (PST)
From: Julien Grall <julien.grall@arm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/3] Remove reference of TIF_USEDFPU on arch not using
 it
Date: Fri,  8 Feb 2019 17:04:22 +0000
Message-Id: <20190208170425.10891-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_090431_324164_953373C1 
X-CRM114-Status: UNSURE (   9.16  )
X-CRM114-Notice: Please train this message.
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Julien Grall <julien.grall@arm.com>, Greentime Hu <green.hu@gmail.com>,
 Vincent Chen <deanbo422@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

This small patch series remove reference of TIF_USEDFPU on nds32, arm and
arm64 as the flag is not inuse.

Cheers,

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org

Julien Grall (3):
  nds32: Removed unused thread flag TIF_USEDFPU
  arm: Remove documentation about TIF_USEDFPU
  arm64: Remove documentation about TIF_USEDFPU

 arch/arm/include/asm/thread_info.h   | 1 -
 arch/arm64/include/asm/thread_info.h | 1 -
 arch/nds32/include/asm/thread_info.h | 2 --
 3 files changed, 4 deletions(-)

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

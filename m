Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A07C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:11:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56C820863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="om1FoQdd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/HJZeo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56C820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dfTNSKDZIr1ociSEx8B7Pdl1WFQSUT37O8bx8YLXRTY=; b=om1FoQdd+PH8NQ
	zsOtgL2m4Rqam3voDe3hiDEIVV/bYWEj3aOEf2+iL8xLX7GJRhIJ5igaxdIGzQUDEVnDotpxrEu+z
	OwmxaC9qa0nLa9aDMZxQlzIcVQA2O+dorhBx/LGavT1BjfXCXYEn3uv8L81VklUdiZLaPc9eHDwKI
	PHqsLtN3eRPEQfzHqZ8mTacGgwjkD1O/gzN8IfN7zJ352Q8jYx2bo/DSY3pxRPptMajmG9fElkQNN
	lljpwYiItCbgE51JJo/B9JCjlqTKfgKoH9kA8GgnGzcX/g0epEKr/Wom5/421/7lx21wAuJT7Xjuo
	0Yq1laWZAEzt6mIL6zZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7oP-0003FH-Ix; Fri, 08 Feb 2019 15:11:29 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7mm-0000J6-8E
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:09:55 +0000
Received: by mail-wm1-x331.google.com with SMTP id g67so3693835wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 07:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lrfbFTBPl0NSLFfUCzfxVu2tDw7SlHN2hli9DaByWHo=;
 b=l/HJZeo+Ve0wEZ/USZK94LKvX2KRnScwH9ae3dJ9ImU8Xvm6b1cJSlT/tN/sRzkNwD
 EdrHqOaGKqob6UFtPwBuGnxQLMOiM9cRLZUReVtPGXwfNiWKchTHWAYDW7s7rS9REk8n
 DJPithj2qoTlzdlTFkRbweraLfvk8KaTpXhgWMu6tjCrQfb1IAsdURiFjuTd3jO94teM
 qLeOERQihjmBdCmZ2ISHF3h/Zawj+Ego+5g7sZTnm+O88XuFJ1cIkBq3Sb4H6CV1EAs1
 vH5Up9+E9V1994i43IYS22adnVABqrUkURG55eb+s3aKkNp6bu+fP4GXovNtP8vxIqAh
 93rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lrfbFTBPl0NSLFfUCzfxVu2tDw7SlHN2hli9DaByWHo=;
 b=d1g1yu7xrQ6FQtmN/9BkuG1HpDW4Axp1N6DvihIoE6a7WX8vOIfdYLCEdfQBjqZkm6
 PZ3EQsuAB1mKPHvAXA1uQnY1D6LGWBPHGBiHfaeMAfJyjR52k5q7YNYnbliXAl+75mbj
 NcZIQOR7xFpmcF8bOu0MHrEZPJAxvmLrWhLqCAnZeI/SEnQ0LILMMOt9kW3bZU6pgC5h
 Z42ZP7W2Hj6nKRfQpRbaL0qn4yOHX838PrGem4clZdO5CAhDZMzWtSqQMOrk3jKuSkjY
 v9lPmz+DyuI5TWnY+Vlfhyhaa8bMISnMPpOhfYZVGCsArID2v4HL6kQOwReMkUEtaOcz
 KADg==
X-Gm-Message-State: AHQUAub8YGDFIh065e97A6T3BcaJa3r46u3ANHYKObz58rdfb3sVABPl
 NRIQPKVhlDtnVZfhKXJV4XpR/G6l+JM=
X-Google-Smtp-Source: AHgI3IZl2uKMHzyLdnS2M/IALBcJV4YBUrllGJZ5u3NqB68vLVy7sg9jWGZzt8BkEWk2oXj01/qX+w==
X-Received: by 2002:a1c:834a:: with SMTP id f71mr10508556wmd.47.1549638586482; 
 Fri, 08 Feb 2019 07:09:46 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id v1sm3919349wrw.90.2019.02.08.07.09.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 07:09:45 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 6/9] ARM: tegra: Core changes for v5.1-rc1
Date: Fri,  8 Feb 2019 16:09:32 +0100
Message-Id: <20190208150935.32108-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190208150935.32108-1-thierry.reding@gmail.com>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_070948_675218_A9E9838C 
X-CRM114-Status: GOOD (  11.69  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.1-arm-core

for you to fetch changes up to 1c6279b49d3ffff38357e93d112512fecf3711a7:

  ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+ (2019-01-16 13:22:04 +0100)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Core changes for v5.1-rc1

This contains three fixes for resume from LP1 on Tegra30.

----------------------------------------------------------------
Dmitry Osipenko (3):
      ARM: tegra: Fix missed EMC registers latching on resume from LP1 on Tegra30+
      ARM: tegra: Fix DRAM refresh-interval clobbering on resume from LP1 on Tegra30
      ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+

 arch/arm/mach-tegra/iomap.h         |  9 +++++++++
 arch/arm/mach-tegra/sleep-tegra20.S |  2 --
 arch/arm/mach-tegra/sleep-tegra30.S | 25 +++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 4 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

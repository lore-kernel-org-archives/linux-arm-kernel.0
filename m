Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C6C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4672221473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DdPwgqcb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uRNUpmSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4672221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:List-Owner; bh=usvontyCXMq1NxfoMp7Hw3gQDIWNzaumKy2XzhvPt6s=; b=Dd
	PwgqcbYmctHLR+vE/lLK/gXz5KFSdbnTzkxS0EHIIQooDezoLOotsDW+RbuN9FG8yc1RL2fVSL6zW
	Dir+AmdnxDTcO9YjOjKDEsQwfP3gBxUJPZ9OuVTCaIlUt7B4ECyaWs82MXbBwQDyuIQx58DwejMGc
	w5xGd494p1U9olb3p20JSi/hIyONX/rGtYmURDYx1yWQd7KXkQrO+If6u6iQZuEwBEqBR4QK3EWPd
	IqXZwhtzBjnwfenxYcsMn5+gsSeGXyOZsQTPWArxD87LWjYNJhGumScwZ1R21lPCTXWSO7RuYwABv
	uMbmgUo5jA/BfvbBSsm4jzOrQJ1secrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXmJR-0008Uy-64; Fri, 14 Dec 2018 12:11:25 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXmIp-0007tE-Rh
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 12:10:51 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181214121032euoutp01649b6f4322c65dd95aea1b323439ed11~wMc3sKRmJ2527425274euoutp01S
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 12:10:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181214121032euoutp01649b6f4322c65dd95aea1b323439ed11~wMc3sKRmJ2527425274euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544789432;
 bh=0GPpm5/CWe5SYeN1z7t7bEn8XSZYzxBAUdybrppYMug=;
 h=From:To:Cc:Subject:Date:References:From;
 b=uRNUpmSpn+2ZqKnkHG+Vza8s9eSK92SwFopXsdYiIQtYfDD8iaFE3LJGzFOGGcffD
 b+09R05Yco/er2htM7uqiyIXdvf5S+05wuhhaFoKcAw2DJib04iogipwMAF0E8lDgH
 WLPaKs5mgeZXT0AHrB9uVFPcuDtBrXsCn81642OQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181214121031eucas1p1f209287f25ebd78a9d936ffa85b71852~wMc2s-fK_1064710647eucas1p1i;
 Fri, 14 Dec 2018 12:10:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 22.7D.04294.7BD931C5; Fri, 14
 Dec 2018 12:10:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181214121030eucas1p265a68ae4067344ea2da52c8291cbc8cf~wMc1yLjue2115021150eucas1p2m;
 Fri, 14 Dec 2018 12:10:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181214121030eusmtrp2c449893a42fca87365206485e20c2f90~wMc1iWhZ51165911659eusmtrp2m;
 Fri, 14 Dec 2018 12:10:30 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-11-5c139db7292b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id F6.CC.04284.6BD931C5; Fri, 14
 Dec 2018 12:10:30 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181214121029eusmtip28cff47c0d2bc3114e62bb12f4f067d16~wMc0pC1A00091800918eusmtip2g;
 Fri, 14 Dec 2018 12:10:29 +0000 (GMT)
From: Christoph Manszewski <c.manszewski@samsung.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 0/6] drm/exynos: mixer: Add color range property
Date: Fri, 14 Dec 2018 13:10:15 +0100
Message-Id: <1544789421-5265-1-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0yMcRzHfZ/fHWeP57L7ClnXZBmVxvbdmGVr82z8oT/0h7I89KioY3eK
 ytRUKOuHyxT6wYraoTjXD0e1TrpVdJqWpOuOxioXqy7GKjye4b/35/N5fd6f9777MjhnJn2Y
 BO0JUacVEjWUgmjs/G7f2FSuig5xzKvQUF0vifJ7uzD0oLSeRLbHtwDqn/1CIYOziEBjI30E
 Khz9hCO7/T6NXpx108g0OkCiV5YyCpXaWzF0r8NBo5tTDQRyjbcB5CjuAKi0eJwK4/iKu+m8
 yZhL8U1fXSRf0RXBOy/aMP5hdQZvswzRfIHZCPgZk+8er32KbbFiYkKKqAvefkAR76rqJI5b
 FKcMH9voTNDG5AEvBrKb4blnzWQeUDAcWwtgb6sblwsPgFUPPYREcewMgNUNK/MA82dj8vIy
 makBsHWhjPi34Bx5iUsLFLsFvnVMU5L2Zv3h/CUjkCCctZDw8+gPTBqo2DD45M08KbkS7FrY
 PauR2kp2Jxw/v4DJ8Xzhm97cP4kg20nD2jo3JacIh86GVTKjghM2My3rVfDno0pM5rMAHPIM
 kHJRBGD7nTxCprZC0+AEJhnhbCCstwTLnjtgfsFpWS6Fg5PLJBj/LQ2NJbjcVsIL5zjZIwB+
 Mpupv1fHZmaBrHl4NduFy8+2H7ZYnWQR8L32/9QNAIxALSbrk+JEfahWPBmkF5L0ydq4oEPH
 kkzg91/qWbB5moFl7qAVsAzQLFHGG7hojhRS9KlJVgAZXOOtjMxRRXPKWCE1TdQdi9ElJ4p6
 K1jJEBq1Mn2RK4pj44QT4lFRPC7q/k4xxssnExiuL73wbrF53B0VMmxU9/sHNVRW+Z057b1m
 ro0tzFmxmpjPiLVYw9f1RVv8una3OOgYnfZKsfp9YcGmbNWdbyWXa0713O4OmGt3T+WE2oUj
 dO5zGDC6N2tiOiwwsv91/a4tKXVpZ95lH1o+ttAzXfshVXAvvxSBlz9N8KndcHg4WEPo44VN
 63GdXvgFuZa5YkcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Pd1tc4VjDJ6eZre4te4cq0XvuZNM
 FhtnrGe1OL57KaPFla/v2Swm3Z/AYvHi3kUWi/7Hr5ktzp/fwG5xtukNu8Wmx9dYLS7vmsNm
 MeP8PiaLtUfuslss/LiVxeLBy/2MFncnH2G0mDH5JZuDkMe8NdUem1Z1snls//aA1WPeyUCP
 +93HmTw2L6n3OL7rFrtH35ZVjB6fN8kFcEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZ
 GpvHWhmZKunb2aSk5mSWpRbp2yXoZTxYfIylYBdXxaRn+9kbGPdzdDFycEgImEi8nSLYxcjF
 ISSwlFHieu89pi5GTqC4jMS8s31sELawxJ9rXWwQRZ8YJa5Nuc0IkmATMJW4ffcTWJGIgLLE
 34mrGEGKmAWOsUpMfL+KHSQhLOAgsefmX1aQbSwCqhKnviqBhHkF3CVetv+DWiYncfNcJ/ME
 Rp4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAmNi27Gfm3cwXtoYfIhRgINRiYf3wBSh
 GCHWxLLiytxDjBIczEoivGGtwjFCvCmJlVWpRfnxRaU5qcWHGE2Bdk9klhJNzgfGa15JvKGp
 obmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBkaea4zCBm36L0+sV1SS71yx
 ZKlK4ZRFz5731bFu3XZt7V+Jvcc71v1aXjhl2tZZDc7PFORu7TQPDLuw6GWjw92c8tex5xXZ
 jm2LnxL7bP3ezy2HChne7jo9bzdH8uw1n3rWrov5vnbyyizTlR6d9QfLeVNkF7fvmO8ylz1R
 29nDQp01+tHeux73lFiKMxINtZiLihMBtKOj+p8CAAA=
X-CMS-MailID: 20181214121030eucas1p265a68ae4067344ea2da52c8291cbc8cf
X-Msg-Generator: CA
X-RootMTR: 20181214121030eucas1p265a68ae4067344ea2da52c8291cbc8cf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214121030eucas1p265a68ae4067344ea2da52c8291cbc8cf
References: <CGME20181214121030eucas1p265a68ae4067344ea2da52c8291cbc8cf@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_041048_124855_0C05B4B1 
X-CRM114-Status: GOOD (  11.30  )
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
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Christoph Manszewski <c.manszewski@samsung.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>,
 David Airlie <airlied@linux.ie>, Kyungmin Park <kyungmin.park@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

This patch series adds rgb input buffer range property to exynos_mixer.
It applies on top of drm-exynos/exynos-drm-next with patches:
- [PATCH 1/2] drm/edid: Add colorimetry helper function,
- [PATCH 2/2] drm/exynos: mixer: Use colorimetry helper function

Patch 1 Add apropriate labels
Patch 2 Split color properties function
Patch 3 Add default range field to exynos_drm_plane config
Patch 4 Minor code cleanup
Patch 5 Add optional range property to exynos plane
Patch 6 Make input rgb range configurable in exynos_mixer

Regards,
Chris

Christoph Manszewski (6):
  include/drm: color_mgmt: Add enum labels
  drm: color_mgmt: Split create_color_properties function
  drm/exynos: drm_drv: Extend exynos_drm_plane_config
  drm/exynos: plane: Minor cleanup
  drm/exynos: plane: Add range property to exynos plane
  drm/exynos: mixer: Make input buffer color range configurable

 drivers/gpu/drm/drm_color_mgmt.c          | 93 ++++++++++++++++++++++++-------
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  2 +
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 15 ++++-
 drivers/gpu/drm/exynos/exynos_mixer.c     | 57 +++++++++++++++++--
 drivers/gpu/drm/exynos/regs-mixer.h       |  2 +
 include/drm/drm_color_mgmt.h              | 10 ++++
 6 files changed, 152 insertions(+), 27 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

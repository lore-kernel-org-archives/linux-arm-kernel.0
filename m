Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165FCC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:02:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB42120868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H5QfULDJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jaRLARYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB42120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:List-Owner; bh=slskOiESTYgnX1oMLUtAjVeFsX2XUEBfuUC5puaO+gM=; b=H5
	QfULDJSplJjtMR7yqnWen3ZyxhpMrfk8QQDW3GDp3EVDtZhAZNoLfRGfs7Yo/EMf6/fSBU28QAVBo
	e4uwpxvD9UtyjA1gygFNnoSanKJ/NBJpoRkxzTjW7+or1ZSJM4W0oSHkUW8ol69wWmf6x3uXMNcR7
	oRSekQXsoMVcSOEOKSmbsBHmBnxTtpsTxrK8QRvoHl3pJCu0YV2uMN+i2hO2ETaG2ymaYgG5TWQzm
	CmyXDHc/Rud9mqouv6ISh9rp06MwDcqqsi+GoYAoxNZ/mmHN0d2ad5HZG1gBQ2eAc2weQvfR+rYuU
	1FNA/T+1uQI6KLqwOK8h0kCVdTOrzmJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gShVQ-0004tx-Ay; Fri, 30 Nov 2018 12:02:48 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gShVM-0004rc-UD
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 12:02:46 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181130120227euoutp0129add277816e7b165f58060b05c1a45a~r5T0I6rLD1407714077euoutp019
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 12:02:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181130120227euoutp0129add277816e7b165f58060b05c1a45a~r5T0I6rLD1407714077euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543579347;
 bh=T2MiV17vS2dmZrOS2d+3fgYnSblTGhl/1yalx2OTBh4=;
 h=From:To:Cc:Subject:Date:References:From;
 b=jaRLARYxA8rghhq8e6vCczMhlUZLs+Jbi6PZoYvmnZgUa0r/IZ2kuuswX0FvGJT+V
 BUfTfy7U9G5s7ybGn5GWdvAH5UxptgP2Gn4zcVyzKg04icW5PCn/Zn1Ps6kYiEsrJN
 vgkf/zxt74obCUS6ZUPEDPwMLNP9fO8/8chZ7h3U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181130120226eucas1p2b9747261151e28e7d4ff5439d916b3e7~r5TzV7rMT0421404214eucas1p2i;
 Fri, 30 Nov 2018 12:02:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 83.6B.04294.2D6210C5; Fri, 30
 Nov 2018 12:02:26 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181130120225eucas1p2563258e9ede809b9d82af135e1442d80~r5TykCopl0229702297eucas1p2s;
 Fri, 30 Nov 2018 12:02:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181130120225eusmtrp2c6d79296e5587d00c30ecd70ad558f2c~r5TyUZb562249222492eusmtrp2Y;
 Fri, 30 Nov 2018 12:02:25 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-8c-5c0126d2e9cf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 5F.91.04128.1D6210C5; Fri, 30
 Nov 2018 12:02:25 +0000 (GMT)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181130120224eusmtip28a24c17544f05ebf5bdc6179eedcc53f~r5TxoT6F13144931449eusmtip2b;
 Fri, 30 Nov 2018 12:02:24 +0000 (GMT)
From: Christoph Manszewski <c.manszewski@samsung.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm: Create and use helper function
Date: Fri, 30 Nov 2018 13:02:10 +0100
Message-Id: <1543579332-16609-1-git-send-email-c.manszewski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRj2O7cdR6vTFPzS8sdEQSEvZXRIiUJ/HDCiKPqRhs08XsjNsaOW
 CXnFdN4voGiZpqUu05zT0rDygsuWihXiXdMf3pKRm4aamvOk/Xue530ufPCRqLgatyXD5VGs
 Ui6NkBBCrKVnfeDkVycQ4G6ssKOz+nsRWvfuOaC/rxoIOn8qF6PnJwcxOmd2CaUHBl4L6L6k
 nwJaMzuE09/aHhN08cB7hK741YzR0wsfAD1R0A3o4oIF4sIRpqwujtGo0wnmzdo0zpT1XmWm
 MnQI01QVz+jaRgVMtlYNGKPG/orlTaF3MBsRHsMq3c7fFoZVjVTiilf4/ZSiwASQjamAJQkp
 T1gzlwFUQEiKqRoAU8YnBDwxAVibl4nzxAjg8kfTQaRpfRPlD9UAjvT0EQeRtfSqPRdBnYFj
 EyuEGVtTDnArT703glJ1GEwca9ntJUkriobJn+PNHoxyhCZ9C2LGIoqBXa39CL9mD0f60/fW
 IKUWwNWsL3tZSPlC/cYx3mMFF3VaAY+Pw53WpwjvTwZw1DSE8yQXwI6Xqn9v8IKa4UXEXIRS
 zrChzY2XL0LVbL6A7z8Mh5ePmmV0F+a3FKG8LIJpqWLe7QSXtFpif3beuAp4zEC98RNqxmLq
 FnyRs4XkAvuS/1vlAKiBDRvNyUJZ7pScvefKSWVctDzU9U6kTAN2v49+W2d6C9r+BHUCigSS
 Q6L53zv+Ylwaw8XKOgEkUYm1qD/VIkAsCpbGPmCVkYHK6AiW6wR2JCaxEcVZTPuLqVBpFHuX
 ZRWscv+KkJa2CUBh0Lt2+OQtzgWGpF4rDW0M0bQPyia13T2bzjvW007lJTCpXVib3OzgEbRy
 LpGp3sp/+OyRQXFi8oiH7/Ylv2HV+GUvu776vKWN09dLvZ+4O+LhooY4hadbpCizPOfGTnfh
 xqaLbVeNr09PpXNhhUHvV99YVBGTGjSD/TibVjcjwbgwqYcLquSkfwGe6K2tOgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t/xe7oX1RhjDK79ULToPXeSyeL47qWM
 Fle+vmezmHR/AovFi3sXWSz6H79mtjh/fgO7xdmmN+wWmx5fY7W4vGsOm8WM8/uYLBZ+3Mpi
 8eDlfkaLu5OPMFrMmPySzYHfY96aao9NqzrZPLZ/e8DqMe9koMf97uNMHpuX1Hsc33WL3aNv
 yypGj8+b5AI4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
 i/TtEvQyltxczFqwlrWiZXp8A2MfSxcjJ4eEgInE5p+/mbsYuTiEBJYyStzb3McEkZCRmHe2
 jw3CFpb4c62LDaLoE6NE65zD7CAJNgFTidt3P4EViQgoS/yduIoRpIhZYAeLxLfPe4BWcHAI
 C1hINJ+qB6lhEVCV+HJ6G9gCXgEPicM7z0Etk5O4ea6TeQIjzwJGhlWMIqmlxbnpucVGesWJ
 ucWleel6yfm5mxiBQb/t2M8tOxi73gUfYhTgYFTi4XX49T9aiDWxrLgy9xCjBAezkgjvuTaG
 GCHelMTKqtSi/Pii0pzU4kOMpkDLJzJLiSbnAyMyryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQ
 QHpiSWp2ampBahFMHxMHp1QDo1NNmd7+2VmGnetyf/HvEIw9yMY1WWSRbFuurHZWcsjllAVl
 ZqaJv3XNTOz9tkz+qnVIxN4mO2bVldkW+vu+Tm5nZFg9w/Tqqew0o4lh3U3TT5z5afVLRX5X
 9J9962Ser+BI8L+47tEUV6O5XmkmTpd128R+zsg7l7BheY3cRoWZpQ91tmkZKrEUZyQaajEX
 FScCALI6ZoOQAgAA
X-CMS-MailID: 20181130120225eucas1p2563258e9ede809b9d82af135e1442d80
X-Msg-Generator: CA
X-RootMTR: 20181130120225eucas1p2563258e9ede809b9d82af135e1442d80
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181130120225eucas1p2563258e9ede809b9d82af135e1442d80
References: <CGME20181130120225eucas1p2563258e9ede809b9d82af135e1442d80@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_040245_108647_6D00B14F 
X-CRM114-Status: GOOD (  13.36  )
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
Cc: linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 Christoph Manszewski <c.manszewski@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Inki Dae <inki.dae@samsung.com>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

This patch series implements a generic helper function, to determine
the default color space format. I've tried to do it in analogy to 
an already existing function, but I'am not sure if it is done the right way.

Patch 1 implements the mentioned function
Patch 2 makes use of it in exynos_mixer.c

Regards,
Chris

Christoph Manszewski (2):
  drm/edid: Add colorimetry helper function
  drm/exynos: mixer: Use colorimetry helper function

 drivers/gpu/drm/drm_edid.c            | 12 ++++++++++++
 drivers/gpu/drm/exynos/exynos_mixer.c |  3 ++-
 include/drm/drm_edid.h                |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

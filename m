Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD6FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D13220892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ttZRglw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D13220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=T9/0uEbpBgjMIQDec11zQ7vycbrZReYCaD9VST560C8=; b=ttZ
	Rglw25GCK1k0WmB5m1y/Q09B0Hb+u1pUcESXlNsHrHHjxWcMc77jJaUgHuqzj1W96R5wQHzk2qtQ+
	VeCb1n9VzsiVHfDMOo5JcjUGWnSjFJDiFVzq2YxluyXe46LaiJ5TpqmHR+lji4Qbyl3r9j7V675Uy
	CVUkhonhl+bla3hCyxYLClS2FuN7iz9mFi8eaQjhiyReYYOPS5ysaWU6wZwoVLmOJH5k3SJKXZU9a
	zpWoRZCBSJ+N9Z581Ju53wAd8EaQIqT9WcA+wa97d5d0Qu0xrEmEDMQvfPFukPvFDOzcEvfyAuvdW
	3/3n1fcdJa+bwuuEQIgR1Y6lAwz4boA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyRG-0008Lt-PY; Thu, 06 Dec 2018 18:31:54 +0000
Received: from mout.kundenserver.de ([212.227.126.133])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyOv-0004os-Nq
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:29:34 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mft3h-1h6F9X2rWL-00gKsZ; Thu, 06 Dec 2018 19:29:06 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 00/10] staging: vc04_services: Improve driver load/unload
Date: Thu,  6 Dec 2018 19:28:50 +0100
Message-Id: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:H3wG5hG7VQnfD5k28AMcgpNt9+imtlZPARiFLMbDDWRECAubUZv
 rdUjbGFwnfh2dDPF6XMeH9T3ssz07SDdDPJ7Tp4rJswG7y3ZBFi+6gcgsD0ZR8w2qIZery4
 DsN0bFXLF409VKREMXopfuv17G3GOLW8DHk/DGxd6cLmuv9eGQRla20N0nftDj/3qsR3t2p
 67Y2iJS8BjcdRbxb0uTpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zoajJLs56kM=:1jGU/8Ju286lMsYnLLRZCl
 2Wy+cIknqA8MewbUsovX84EAL0ApHf3vSAX26Cf/8lZlZVNE1TL2MyYRXMnGpNULMcBAdWyDX
 GoSP2EinfY/F+6Ma3AdkMQ9Ilar4WiM6STfDGWFtX1OBpsYKBsq2ipdraosczTepoYzZZR4lA
 uc5Cazbbu+jwSicLjeNRtdTy8jRz67vV8iFi4hV13qvxs6sUwTRYcnagBL2HLEKxyIVOn/GGc
 XA1MxSwsU+fGeF2NBKEuX4QMyCYdTQ+Qcr45FVCRLEPVdLb2TYx21gjcNYdpRyk/P/h07bIlw
 3jJSNGaMcTqzzeyywtf11Lh5w5VwedkUO/CTuwj3+VlQcksJaYsyTFtBFPlJuQ4nuo4n3sy3l
 mlJ4jMlmlM5VEwaaYA6GGh8NTjOn5qyNNxjMGwqtickH1qhg+6Cp7Yhp/E+1FU5UE2amaVp+i
 jGYMBiQ8lm/28rb/ReeeF+ZyD7mXEBmCHfzwTTtck1IhXjJW7XJgydbSphZi3lV/549F0j/Y0
 OafHMbaA9jKNyTrK0c5efP4EX6C8TUslxXGzHI1L+KSLrl9JBrhSru8ZgT69IPODpFttSH+7i
 t9wnmy2hmBnJJYwx5ZW+yM6WGtRU9TRqHULsugvcZdc8jSZa2Makd/BBraB+gunL2HjOiw78B
 EVGkuX+TgAVWuGuE6s2qJpBCb++33owfknRGFvHhDQKiBvYaKIw+JZGQ2Re3JeAgOQ+TDARn0
 3XB0fbE6Z/PcRkqN78LLic8L5uKa+j3Uxjvgy6xRFBolzEu4dGwCv7ouvPg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102930_070252_2341A086 
X-CRM114-Status: UNSURE (   9.55  )
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
Cc: devel@driverdev.osuosl.org, Stefan Wahren <stefan.wahren@i2se.com>,
 Takashi Iwai <tiwai@suse.de>, Eric Anholt <eric@anholt.net>,
 linux-arm-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series improves the load/unload of bcm2835 camera and audio
drivers.

Changes since RFC:
- rebase on current staging-next
- add Nicolas' reviewed-by
- address Dan Carpenter's comments about error handling of device registration

Stefan Wahren (10):
  staging: bcm2835-camera: Abort probe if there is no camera
  staging: bcm2835-camera: fix module autoloading
  staging: bcm2835-camera: Move module info to the end
  staging: vchiq_arm: Fix camera device registration
  staging: vchiq_arm: Register a platform device for audio
  staging: bcm2835-audio: Enable compile test
  staging: bcm2835-audio: use module_platform_driver() macro
  staging: bcm2835-audio: Drop DT dependency
  staging: bcm2835-camera: Provide more specific probe error messages
  staging: bcm2835-camera: Add hint about possible faulty config

 .../staging/vc04_services/bcm2835-audio/Kconfig    |  2 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 51 +++-----------
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 78 +++++++++++++++-------
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |  5 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 29 +++++++-
 5 files changed, 95 insertions(+), 70 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

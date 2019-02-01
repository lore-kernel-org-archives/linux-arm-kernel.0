Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D954C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:03:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F042086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sCKwkWX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F042086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=+ve5HbBCPUQmRnOv0LdmfWu+E7F6MCOYCrV995hoKIA=; b=sCK
	wkWX6I98OkSb9CCNSIl87RZ5O6Ao6FLM0kVsKMTfCJUPrOwiewttClh3uiLEGBUv14jIJIv09ZeRC
	HxTBYWfynUtsko4NTAbHFfItkIFTNU31dm4Rmkqa+/aqfw075mZnP8ItGLv1S3gw/6Yb8bxtWgkO4
	5S5jQvfbFPDRuJRmLmxLKBdKV8334SK3rMX3NUqHgLbuj+U5oX3evNd76EVqoUBFmUVGHE+cIAlFG
	tbT5RJUZQ4ZFrWVNZAKihINrcQs6nCfg3OQiJNec9eCP4XdgjzH3GinU2RK28pYwWdFV7wLR2hYzT
	pg7ZMvKTafrK/XpPitRAttVADFoTd4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gphqN-0002fp-NQ; Fri, 01 Feb 2019 23:03:31 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gphqK-0002fT-Lr; Fri, 01 Feb 2019 23:03:30 +0000
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MDQqe-1gxzpf2vQ6-00AYFD; Sat, 02 Feb 2019 00:03:21 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: [GIT PULL] bcm2835-dt-64-next-2019-02-01
Date: Sat,  2 Feb 2019 00:02:59 +0100
Message-Id: <1549062179-5828-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:fB3eGHoWQE6HRo1RhgijEvTgiMdmiWiuKR/H9bBPIxNP8s7HVo1
 54OJCaQPXMuv56jvSKLaobXg5NuFiSU0zHY/GiMyMSPP9crcb2LMR1C+aWBKYLd+0LZgmN3
 CsioxL1nXE9aYwoPZcE/iNHa5D05lhHvvgFVtj/8nmiBOerZH4SWhctevAfDmna34FQ/jjX
 G8XrCWu9C3VQHliheXGlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b/3RHBjW1/A=:BXYqtVxT90Gjg9wt3BOXl9
 Z1jjarR/FLlb3P4MpnjYy3AhMc5zBC2quQi5M9Jg35nAiCoj5sRLhuT8or9vCoou4k4E9sOgy
 6kott2ZzERl0L2vLlXFWL/LDiACu1Y2oAVG0ki/Ed2X/WjVm2GQYz87RVmIdU4qfCNhl/hiyW
 liUAhAFNZTbEHRsk0RXDQ3RxVhiFxHX5X+wiRqsqeO8uTqwrNKzfAMo36MQ+bhcXHI7tvtsRD
 LxCvQvyWqOsJ8/rjTJQedtWltxaiyELve5LzPzmOIHUS5YCY+5/FsEnc8uVKnV7syGb0Dvn12
 RCwyad+lelnVTWQgtQI7227bf4uFH41R5AMhkecrXblRWfRluGCsBlNvzMBCNfO5podUGN69H
 y9TQKfOFUCcZuLLbkXCdLNw2LKQIhhucp4yZifqSERyI18Y5Ijig5lCTbyb27ZSklC7xl2oD0
 Fqrhzkf9SwdY3rRJTKP06RFCPRvMll4DJ7ypn4KpoB8eB9xrPkOmXGSM1UKsD31q6l1Ms298l
 5pHAAbRBKrh3K71cLtImnFy+5jjJXtkgCQdYyK87/ltNR6VopqoYXLhbNdgJAZQF20HxhhmcV
 Q+iIxLDxYhtTJUlxX0FPCsfRvy0wDi/ttCPGiwgSS6v7xMGDC6+JumVA25SgM4G0Eztt/nDeM
 PynqpnPUAE9wDfl2PuQOahowHyv/7VMaUry6NVxDw9fbJhFg/YbSW0S5RiCttmip0JG4+/JqO
 bwztSTybcnEfV6TQjcqoLubOrnKJ5Qavqiykj4VjJNirGgILjx/zJ+fLaBc=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_150329_013159_55615CFD 
X-CRM114-Status: GOOD (  12.48  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Florian,

this is the fixup version (cherry picked the patch with the reference target)
of the dt-64-next pull request. Please consider this as a replacement for
the broken dt-64-next pull request.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-64-next-2019-02-01

for you to fetch changes up to 441d8020d8fc8654698f5518cdf76832f84101f4:

  arm64: dts: broadcom: Add reference to RPi 3 A+ (2019-02-01 23:35:26 +0100)

----------------------------------------------------------------
This pull request brings in the arm64 reference for Raspberry Pi 3 A+.

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: dts: add Raspberry Pi 3 A+
      arm64: dts: broadcom: Add reference to RPi 3 A+


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

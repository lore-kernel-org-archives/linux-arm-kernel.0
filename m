Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA0CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:02:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2A52082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MmxscP9R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ulz79bg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2A52082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ni+UoDHN4nD0pN4gfYgPYOM2F7W8Tr8ID/fqPDyOQZk=; b=MmxscP9R5sdLXJ
	8QsGUP8iIbNTvt+uG8BXhMM8sDq73wd8fztwpnX24BoTiiE7mTZZbDRcHQj1H8tHkY03HHmjSAJFx
	G27/m8ukMEw46HUiLmyHAZtGYXizATPtUhE6S6PSceVbg39VFG6rmwZlIgP7xmieKTzeaZo6b7ufN
	BF6pzoHP6ah4HBbpGmVtkKdE9hbZsQKLIGs/3WC6HsGlb7K2VSWONY+QAc8dumsiycgNwd6Dx9Irh
	dP8C9x0B4QxSyazd3SUUg8kqrfK/OEh1ycXapZhi+zHPM7y1N+fuXC7eyMXD7waa99H4Za4QKy9dl
	PyE+t05MNlVGwpk4+NRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUh7z-0006T9-OT; Thu, 06 Dec 2018 00:02:51 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUh7s-0006Qc-8f
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 00:02:49 +0000
Received: by mail-wr1-x444.google.com with SMTP id p4so21462868wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 16:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NSFTQSZEayHkouMtOVDMYNOLbXr1bjPpdi/mDF9F+Qo=;
 b=Ulz79bg++xmJw0us1fP/5iobRbrXiGj4E2bazK6TBtWVSotAG0leHynY5ZEmxMwF02
 WieFxjPZnrbcQvlJKU2VGauIoQKawe6INuCAlnWNVBPlp8uI8l4V6utawdZ6bFDF6bX+
 sM8NCSvz8QJ+QKPtmd+wI8/uismItWGzQCrVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NSFTQSZEayHkouMtOVDMYNOLbXr1bjPpdi/mDF9F+Qo=;
 b=VNPT+YxpYLAJw7sdnEhKQ3syAM3O54wFI2YzJE36Kl7UK8+/5PsA4h+hmM/lDtCpTC
 ZKf3aM3jh+i/EJ2L1CbGG4MAUlJgm/ik1mYnloQel5AL1IdJdYfCknpf3z6mb95DLDb1
 62djF+G2+xz7Od0DlnTElu9xvtsTNeq3GifpWUkN9YHNaSGiF9CHwvahKh6dxh5lVwWF
 4YjVW68Whudaq2RAss2CWveRSBPq4hCCp5IM4EGyRH/98Ix6Q1CtsrOvT6k32qEVSBgp
 rHUER760/1A+u/FX7SCSgkh5D/Itwg/+NuZpysYsJfvfSY2az3zLIUxXPrAvReY69WA1
 Fxlg==
X-Gm-Message-State: AA+aEWZqaQrArreCQdDRKvX8Uqtl3t8JL1DbArkGV76MPCONE41HjB0S
 arQODbDC/10o3zwqGHuh4Idr8A==
X-Google-Smtp-Source: AFSGD/UOXfHw2Cr/4pA4ikcp6r+AOcGEVJFHazqpXw14hbGIR+As/CsRwoC5Tn8pcuCk9SX+FsLYnw==
X-Received: by 2002:adf:e149:: with SMTP id f9mr25286999wri.42.1544054552174; 
 Wed, 05 Dec 2018 16:02:32 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
 by smtp.gmail.com with ESMTPSA id i9sm23241184wrs.34.2018.12.05.16.02.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Dec 2018 16:02:31 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: mike.leach@linaro.org, linux@armlinux.org.uk, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Update AMBA driver for enhanced component ID spec.
Date: Thu,  6 Dec 2018 00:02:24 +0000
Message-Id: <20181206000226.2507-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_160246_043361_B2B4A37E 
X-CRM114-Status: GOOD (  10.69  )
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
Cc: mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The latest ARM CoreSight specification updates the component identification
requirements for all components attached to an AMBA bus. (ARM IHI 0029E)

This specification defines bits 15:12 in the ComponentID (CID) value as the
device class. Identification requirements now depend on this class.
Class 0xF: Traditional components identified by Peripheral ID (PID) only.
Class 0x9: CoreSight components may be identified by a Universal Component
Identifier (UCI) consisting of the PID plus CoreSight DevType and DevArch
values.

Current and future ARM CoreSight IP will now use the same PID for
components on the same function - e.g. the ETM, CTI, PMU and Debug elements
associated with a core. The first core to use this UCI method is the A35,
which currently has binding entries in the ETMv4 driver.

This patchset prepares for the addition of the upcoming CTI driver, which
will need to correctly bind with A35 and future hardware, while overcoming
the limitation of binding by PID alone, which cannot now work.

The patchset updates the current AMBA Identification mechanism, which was
already differentiating between 0xF and 0x9 CIDs, to add
additional UCI compliant tests for the for the 0x9 device class.

Additional UCI structures are provided and added to the ETMv4 driver as
appropriate.

Changes since v2:
Simplification of amba_cs_uci_id_match().
Fix CID class bitfield comments.
Dropped RFC tag on patchset.

Mike Leach (2):
  drivers: amba: Updates to component identification for driver
    matching.
  coresight: etmv4: Update ID register table to add  UCI support

 drivers/amba/bus.c                            | 45 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.c | 18 +++++++-
 include/linux/amba/bus.h                      | 32 +++++++++++++
 3 files changed, 86 insertions(+), 9 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

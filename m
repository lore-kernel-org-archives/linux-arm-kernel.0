Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28514C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB21F2190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JflLyYVm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcPgjnkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB21F2190A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DOBQSc211ay9T/hKBtTCOUAUkABnh4Cr1fGa/ezg+oo=; b=JflLyYVmmGsEA1
	wtke6Fnggz5ikFL+HU5cnKmhmXbxzkcGnZKzYJfkkcdc0PWJQsHiyLXUDJ+07QEtNqhbHPrUkbwXn
	GzErWATuW2RxCKxZ1NAXO4HK0AFIIiK5e3mT0VH/2VvkvsOftMvnYiVXKLRS3bCzp1DKWWfIW0iqY
	Szjl42X+Zj6GtfFBET0tkiLm/8JE9LHQezkWpb2lodtJccxy/si3Eo+nAwszxijxS6gKdaK+LKndz
	OUn5/D1+Drjr/EenXWKczgv78soBEZYLBkuvpKEnk4SOEUywJH3ySO49KHjzCjHUJS/g6UQyzNaWT
	L8vLHX2GWhK3PfTBe5gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuuM-0000Hq-Ie; Wed, 13 Feb 2019 13:49:02 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuuJ-0000Gf-BQ
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:49:00 +0000
Received: by mail-wm1-x344.google.com with SMTP id b11so2541967wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 05:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5uesJ6vFpSDgyknwNX5tW2UdF8aZyiOeYDlhlP4RW3s=;
 b=hcPgjnkQY8JfIIEsWFF3B/17XlBJv9LRW0AcZUuesXGYTRObZWfFjuRf3bEYalhZlC
 J8z0X6wuSM4xozQ5KhJ7+f0dk8boT+O5GUzaC3DCI3X86ChcF6v/F9c4o38+8N8K/1m9
 O8fv4ewnkte90qOIwhKcz0el1O1JcaXUBZELFXL0I33Ao6TN3mSxF/TMs93MkUH0wR6F
 iS6bEP+4MmRItnEn5A4Bmq+CpDT52jabd9v6JUvtAqxZFW2Qx7SDn2EtiqJ0foTDntNb
 6D6UHJVUAYE0e4roPTw0rZjCz06JCB9CmUfBVz9POlFK5XEcNIJ1AKJJZuZgnziaGYev
 yIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5uesJ6vFpSDgyknwNX5tW2UdF8aZyiOeYDlhlP4RW3s=;
 b=q/UEFSNreAw+nsXVtKYD3Tzbi1QR4gXTS39nU5f7zXRu/XvuZwUTJbc6mdpbn8xq5s
 JBF+F+dj7QREM7BX22bopaRGy3tzy2cnFgRK6ftpmEvg/11+AbM3fXEbH4RzfwOt0e+u
 4XjzPY4dMvfEIMJlfXTCI7RK12rnq0ImDfcAEaJX3hFAharPQHiRXsJeKrhpYjVwPoih
 idcPQi0A6PjNvEGoeEM7G7cyWuGh2f/p7abJt5DD4kFA0ZaBWpCMskOUje4MqMopR/9P
 TzdamxKf6IkZQh8jmrDQbIoqSXzXIBoL0EAseKuGXBy3MaKtvHaUARm6NaC5ZBD8sEY5
 ljBg==
X-Gm-Message-State: AHQUAuYL+zQPdtTFddXsH7jJhsHoL0y/J3IK5BeC02O0mRxRl4FSvOd+
 Swk/TEd9AMLN5z+LjnnQntEBeoEyGCc=
X-Google-Smtp-Source: AHgI3IaB52fSHZWEettOum/r2QdNDljetmKi35EYmTE5geAnTqJcJrQydHECwLBdkNUzViPIns4fpA==
X-Received: by 2002:a7b:c0c3:: with SMTP id s3mr331476wmh.141.1550065737217;
 Wed, 13 Feb 2019 05:48:57 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
 by smtp.gmail.com with ESMTPSA id g11sm3333838wmk.26.2019.02.13.05.48.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 05:48:56 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: coresight@lists.linaro.org, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/3] Update AMBA driver for enhanced component ID spec.
Date: Wed, 13 Feb 2019 13:48:20 +0000
Message-Id: <20190213134823.20150-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_054859_396386_B4D2D07F 
X-CRM114-Status: GOOD (  10.02  )
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
Cc: Mike Leach <mike.leach@linaro.org>
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
will need to correctly bind with A35, and reported new devices that share
PID for multiple components, while overcoming the limitation of binding by
PID alone, which cannot now work.

Patch 0001: Adds new UCI data structure and uses it with existing drivers
that use private data field in amba_id. This fixes issue from prior set.
Patch 0002: Implements the UCI matching code in the AMBA core code.
Patch 0003: Update ETMv4 driver to use UCI as appropriate. 

Thanks
Mike

Tested on DB410, Juno; kernel 5.0-rc6

Changes since v4:
re-based on 5.0-rc6
Added reviewed/tested by tags.

Changes since v3:
Fix UCI structure to allow CoreSight drivers to set private data. This
fixes bug where none-UCI private data would cause a driver binding
mismatch. (e.g. STM).

Add CS_AMBA macros to simplify building AMBA ID tables, with and without
UCI settings.

Changes since v2:
Simplification of amba_cs_uci_id_match().
Fix CID class bitfield comments.
Dropped RFC tag on patchset.

Mike Leach (3):
  drivers: amba: Updates to component identification for driver
    matching.
  drivers: amba: Update component matching to use the CoreSight UCI
    values.
  coresight: etmv4: Update ID register table to add UCI support

 drivers/amba/bus.c                            | 45 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm3x.c | 44 ++++++------------
 drivers/hwtracing/coresight/coresight-etm4x.c | 21 +++++----
 drivers/hwtracing/coresight/coresight-priv.h  | 40 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-stm.c   | 14 ++----
 drivers/hwtracing/coresight/coresight-tmc.c   | 30 ++++---------
 include/linux/amba/bus.h                      | 39 ++++++++++++++++
 7 files changed, 153 insertions(+), 80 deletions(-)

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

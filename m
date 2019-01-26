Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7703C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:29:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B9D21904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pgsw5sd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B9D21904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Lk7aG1g8thegJ6furdVyum50OTo8Ea5+MtliZ1R1mPQ=; b=pgsw5sd7fuYGgE
	4rP95JTAoKLFmsHdhYYf9AMYcRd8FEB4b9DQDNpQNdJioE60UWFFzg/h2xB/NQfWQ8xgJIf4VSgkp
	2ILl6wjGY6fDiNGrzT3LjbKAbCgELAA02hJyqmUgVy2JpFvT4FOgt6nRVvL9Z8o/OBws8XHCeuk2l
	pb7nQ8hFeTxs+R6hHdAdfQcFjp9i5XDLfTtykMyNiuWclP4edpdShXE4G5+W2njWxzgNMje4MbvMT
	c1qoCVi1I/cIlfwZARwg/241hnH5seQBFYNmXAVgDtYkhG9IhuhY+c2codl+zOSqY1WfgKPlRhEsC
	5npC9JQwe4GOSUrNgBlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnOxe-0001OP-UW; Sat, 26 Jan 2019 14:29:30 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnOxc-0001Nd-H3
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 14:29:29 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 3210143DD8C;
 Sat, 26 Jan 2019 14:29:26 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/3] ARM: dts: lpc32xx: fix lpc32xx-key device node
Date: Sat, 26 Jan 2019 16:29:18 +0200
Message-Id: <20190126142921.16041-1-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190126_142926_226020_C182FCC8 
X-CRM114-Status: UNSURE (   7.20  )
X-CRM114-Notice: Please train this message. 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_142926_226020_C182FCC8 
X-CRM114-Status: UNSURE (   6.59  )
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
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The changeset adds missing but required 'clocks' property and fixes
'interrupts' property of a keypad controller on NXP LPC32xx powered boards.

The devicetree binding documentation is updated accordingly.

Vladimir Zapolskiy (3):
  Input: lpc32xx-key - add clocks property and fix DT binding example
  ARM: dts: lpc32xx: add required clocks property to keypad device node
  ARM: dts: lpc32xx: reparent keypad controller to SIC1

 Documentation/devicetree/bindings/input/lpc32xx-key.txt | 5 ++++-
 arch/arm/boot/dts/lpc32xx.dtsi                          | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

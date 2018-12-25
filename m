Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C6FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:22:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709CB2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 23:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H8nfzWIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709CB2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=9YXmQmVpeNIA1dn9vFLAu8XofCZip28sezbIlyVbp3w=; b=H8nfzWIyBC5Y8MApR4X0ufkC8d
	cMzOW78zH5IysOYjoManGsRY1tiVndAT6XAWli9IZ/ZQvosMemaD0k+68WL3LvaFbWeZwQNQ0vUiy
	ZRdyGm5qUMv9cA19gRB6ZkWO9LlW6M6KIBXzKaNvCE3uq7BZAEEHb0Z9LzV6oLcFCahmZzHO5AOop
	zyYnE/MZzsNrlSbGCkh9GEntxcoR3yNZEetNfgRoyRF7+S8D+nS3i74BXvcGo32aOWTcZu167uVfI
	62seqrRIj26xVFxHGgRu7zzVgu+SdDm+VPZRIhXbgRpNUSvJLw1Uyr/BdDYcRNNZmy7jDyME4fiUD
	QJHxjsjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbw1z-0000MI-1a; Tue, 25 Dec 2018 23:22:35 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbw0o-0007ah-LD; Tue, 25 Dec 2018 23:21:25 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M26j1-1geOqT0jYP-002b1s; Wed, 26 Dec 2018 00:21:00 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH V4 1/3] dt-bindings: bcm: Add Raspberry Pi 3 A+
Date: Wed, 26 Dec 2018 00:20:06 +0100
Message-Id: <1545780008-22271-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545780008-22271-1-git-send-email-stefan.wahren@i2se.com>
References: <1545780008-22271-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:WrfO7Yj+wRnf3pWCi0mzTix3v9IGoB5gf5VAGbSsaIi+8qWaOex
 TU0s0OjEAIjoR3GuN5kygth6IVLrMSzpPsNHpMEL9/xVxwgHi5NNcjJIYrolRf7mHSk6oJm
 uK2X6c/iJ62jEy7Et+0B7psi/rcosGnYr3PUnFz1VUjJrqOJDXfTkF0gIqZndZMJiANL3lk
 WbiAxv51FhmYjydJXfWfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U1c1Gzmn6iM=:y197dH6jwqyIDp8G9CFNJA
 0j1O4MoYvOCi7oiekG1wmw8g9VY3VDktl3Mz9ULHvh0HbdvjVaSseyCIybJ6+Z8vAnEUFX1qX
 zhtHCqfsYVnGlFw2HNJlPDjIW2eCCa9IJ0NphCopie8MJMUtkOYBsHyFs52FSruR0fyQZyrI3
 MtvWI/oKqRypLCSuUTkm8y1uhLD0S+ZaBkQdP04UMOrfSNyf7MpsNwhO1ldgMpcbNuuyN2noK
 HNhjVDKs40okw2FzSjRALYtITLnY/dRj5TUNzJYm9lOdT3ungoVbDj5I3rp88SFnC2LpmK0mZ
 8YcEIityOwdfpo+4YHbumlBUHRmJDfqIAeEKfQdbB7JBtfAXnnvxsm5rY0LSv+CVCqDcCHASP
 AoNE3CHCJ8JSuGmpSBxsBki2bQnSMCJHFPPClCGRod0Gj+wsqBF/HnNsyHHr++PWLOn2q3Oor
 dAvnpW0s7H0Y2Xk6T1p7cmr9l6ASGc5ogsbiEyj4yJjXapjhwx8YDseSX4mOljzO8UVLJxHIK
 MPrBokUiTyg+ZvERb6iX+p3vwnLyuB+S+V7SCVfaTNYky7MP9edXCUqr00fHan8the+NnqGhZ
 atHkBTQO2rRIdVp8VoeX7vb1ZXtA2TMAOJMFgsZbmxY8fDs0qmgwJPOq8B559WipmLf1KMbnv
 w3yIHl8i5zCLzmyCHsrSC32HMuEv1iSmUSlH78OrtFYz83SSoMxhsVe7B+Vz4X1mDZiyJLfmz
 3xV8bW60Y8pJWCYrXN1br7R9UramAMbUfkxCavuy37Kt31SpYLh2XhgllbU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_152122_993359_78FCAB6C 
X-CRM114-Status: GOOD (  11.61  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 Phil Elwell <phil@raspberrypi.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the root properties for the Raspberry Pi 3 A+ .

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
index 0dcc3ea..245328f 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
@@ -30,6 +30,10 @@ Raspberry Pi 2 Model B
 Required root node properties:
 compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
 
+Raspberry Pi 3 Model A+
+Required root node properties:
+compatible = "raspberrypi,3-model-a-plus", "brcm,bcm2837";
+
 Raspberry Pi 3 Model B
 Required root node properties:
 compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F55C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA51D20872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M4R+RySS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ps8hgp9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA51D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=OIBCpOLbE+bP/riWxmUm5xDpBVBcJvZnTE1XVWW1qJg=; b=M4R+RySSuyAKhX+SM52X5pV9B/
	cTiqsq6pslSipV9k/NMBg2G6svG2PAo1HWpUgGcLyszwNnP9+ehNd1E0h2RdPbrNQSknI8gFYU289
	D4hkr2GPRFMMhOfYqLjPSCZLT+IdJwYBUdefwpu40b5wkLU6CARHbLaWO9mI/KzDQFjw37l1RodV+
	UryPQBv2kRIh2JSS1Ga8L/ps6qJDAjtq7MdC+KXnv359D8cvFqqCNSHnF0Rh0QLq7fhX5tGwAy53Y
	BgxYN6XLQ1tYB2KexBFhb1pt9/77oDdsd2/D4cR8QgU2N6IefjdZImG/SmHqeWSWql9xT4lNvAnMU
	wXfcY23A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghpG2-0003Uo-6g; Fri, 11 Jan 2019 05:21:26 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghpFv-0003QN-Fb
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 05:21:23 +0000
Received: by mail-pl1-x642.google.com with SMTP id y1so6230753plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 21:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Yd4M+CUErpLCr3c/0+nYCFyarZVesvGUD1M9BF/zec4=;
 b=Ps8hgp9KQELNTG1W1mrwKJ3flExA2lNI26ytiNvhzBXzgwS6wNgwmjBLCGuWHlbL37
 zBdKXfCrnBZrLA1wbv4QpFYt0pITMjTvB4Ig42TUUs6MbpD6xsy2zWJBdv1QCjnu30iO
 8JsqLylacKIcSI4yPiVNt1QbQD8w14GK/HZlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Yd4M+CUErpLCr3c/0+nYCFyarZVesvGUD1M9BF/zec4=;
 b=C0y3MJLixIgmx7CyfCtjs/nUhmK46/iLhHG2u/GpYHw3Y9WiPSGb4tAaw2eV0zUBlm
 MAvH4Ne4DmUY+eyEs6wgyCOhwYz2cKyYQ+QEdyPPNca3diC7yNoWHYamI1/snfx2AFtn
 G8h+weSr+XR20y1ivUKhHuAoKdda8Btn2RJ+0lhqiWoiZLs13YttpyMhunIlMSHcG/eM
 vXJuaonVMnUjJxVWP/4JXMid5Rkz73BQNS7h5iOa+giAT+ZaL5FGNWJ0LmNp+s6+7tM0
 3oEBY8W/BiWb/GFMl6Pk1L1N6VMsNJnLGsDgzZvMyb/OVmZ3PkuFv4Rat55nQ2q6VN7e
 NQ8A==
X-Gm-Message-State: AJcUukc2QfwZmHAifnxJmf4uKljkwUtzOZm5DjPng+5gZ7LNmcAWPj77
 XJM+TTyL4BD5xmMVGOCnuMS0rQ==
X-Google-Smtp-Source: ALg8bN4QGefj7NR/MPTsSMJLmH5z3WSsQE9axJGSg+690Oc4ppwgjnjqr/yLogVMcJdLniGqWRFOJA==
X-Received: by 2002:a17:902:42e4:: with SMTP id
 h91mr13509426pld.18.1547184078787; 
 Thu, 10 Jan 2019 21:21:18 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id 186sm148425418pga.36.2019.01.10.21.21.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 21:21:18 -0800 (PST)
From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
Date: Fri, 11 Jan 2019 10:51:14 +0530
Message-Id: <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_212119_906965_943337D6 
X-CRM114-Status: GOOD (  15.28  )
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
Cc: linux-pwm@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
 Praveen Kumar B <praveen.b@broadcom.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Praveen Kumar B <praveen.b@broadcom.com>

Add new compatible string for new version of pwm-kona

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
index 8eae9fe..d37f697 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
@@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
 This controller has 6 channels.
 
 Required Properties :
-- compatible: should contain "brcm,kona-pwm"
+- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v2"
 - reg: physical base address and length of the controller's registers
 - clocks: phandle + clock specifier pair for the external clock
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

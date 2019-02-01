Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9592FC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33972218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bx0G//sh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbTYOZJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33972218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tNetQPVWLEPRNiEjBMb3qN5qLo39Qby7oSK/jGRLNYE=; b=Bx0G//shltPuidCOlSHgbtnYgz
	XEl3pN2uymQIkHILdS8LSwE4nwpfz08Pwfqe4JDYIRfaJXjPIg/SVx6TRsmbHQTK27YbIqdunnceo
	XArBxfrndwDEX3+GIsFG09RMGfczu51eTm2uoEb2nzWv1tV7BYASq0jHT27HkvCNLL+5u1FaY1+Ww
	GeuGYaXn10uKJVkGel6uFg9rDGDES/Jm0z+bjk+OkHy5VRCbTOMNdYUUA7xUp7SKnysKnoZdWHABi
	UIH7xyFjH44pXhFYT1JFpnYbYH8BUnQBC8S4Eg/+WIg+Ow9Pt8+42rrjJma75XCjt5H20IMk7kq4W
	+vBbK1LA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpauO-0007q8-9f; Fri, 01 Feb 2019 15:39:12 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpauF-0007fs-0U
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:39:06 +0000
Received: by mail-pl1-x643.google.com with SMTP id g9so3399617plo.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/eDFiU+7KNoLYdpw1NkuAhHQ88OLOmPVAtIDTQWvTdE=;
 b=MbTYOZJvuRP6utRpezSOD/+w9RM8L9RrQYTDP7+H3mZbry+fDTp+hHmpgRqWsH0mRF
 ow0r1MF5zGmTc9TqnuAIc1+KwylQ6aV+8tCiEFl5UkKqOffRCG2Q/nBA3t9PQNh1k0pN
 96/D4U46eE1N8zkqpifQss6UDUtgabGDnpozk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/eDFiU+7KNoLYdpw1NkuAhHQ88OLOmPVAtIDTQWvTdE=;
 b=mx7ENcoO/ue06YJ3vA89jljUbsWE25naUWx+lGb3qf6KMPT1SM1vEFo22mRfAfMKuB
 9k7ymAk7JVz5Y9sO0CDQNLGWZHgCvkjtma/vUzIG0sAa0f1uk+rjKn7FUFS0eGMt57Yz
 NN9vROOY57th/C23sXWmoJBLfvd3wLy37k8Sc0iek5LgNl+jxOoS9nZdq/End8GszdCQ
 bnG3AImUzwFVy1W8CouEaxl++Q12vh/HkQf2shW6ql0r2LR3cigwAHx0lSnLtGtna4L+
 Yc/lkcyriwUZLSLU3/cHdRorcX7uZgtXeo357/7myLVdF0mU33EjOzr+4xaKGWQu0uZt
 oPRg==
X-Gm-Message-State: AJcUukcg5m1TTNH4l8ij4uDYhkVDwtGseAy/7gjw9kgrq9yxDgxpsPj3
 qkY+vpoX06Qve/Om/Dq1BzQX
X-Google-Smtp-Source: ALg8bN50b+qQrPq+/IZNPw8Lb/zo7wXHou8HW8efg6X4yWh/qpN4TgSjhUgYjtHuv3bpXqg9ByZxbA==
X-Received: by 2002:a17:902:7b91:: with SMTP id
 w17mr40015197pll.111.1549035542441; 
 Fri, 01 Feb 2019 07:39:02 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7348:9f93:3db9:68de:e3db:c028])
 by smtp.gmail.com with ESMTPSA id l22sm12350035pfj.179.2019.02.01.07.38.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:39:01 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: p.zabel@pengutronix.de,
	xuwei5@hisilicon.com,
	robh+dt@kernel.org
Subject: [PATCH 1/3] dt-bindings: reset: Add HI3670 reset controller binding
Date: Fri,  1 Feb 2019 21:08:39 +0530
Message-Id: <20190201153841.21903-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
References: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_073903_362940_4401ED34 
X-CRM114-Status: GOOD (  13.55  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
driver is reused for HI3670 SoC and the binding is documented here.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt     | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
index 2bf3344b2a02..5d60ec541331 100644
--- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
@@ -5,11 +5,12 @@ Please also refer to reset.txt in this directory for common reset
 controller binding usage.
 
 The reset controller registers are part of the system-ctl block on
-hi3660 SoC.
+hi3660 and hi3670 SoCs.
 
 Required properties:
-- compatible: should be
+- compatible: should be one of the following:
 		 "hisilicon,hi3660-reset"
+		 "hisilicon,hi3670-reset"
 - hisi,rst-syscon: phandle of the reset's syscon.
 - #reset-cells : Specifies the number of cells needed to encode a
   reset source.  The type shall be a <u32> and the value shall be 2.
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

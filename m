Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC75EC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:18:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959192147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kNWIJ5Dp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRsmHZv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959192147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qRB6oVlxJknWWYWGQzTn0YDPTXiQWsDnutmjQGPx7UQ=; b=kNWIJ5Dpo9RCS8
	ny0qSDdc72XNqyX+iqSaRLoEY/4VgS4RQt+eTV/F2es6zvy2Gci7w6BFX39HAU6ZBIkhugX3jV90I
	eZs7Q4gOWztrPA7TpXGGOtg9xox0QAiYcoNib7OWRktR92Ld3dc+zz1BQYAYZwt2vmgPTxW6LKiWq
	s8GC72/XfYOBo9YPveKRqVAWLbI7QwofN0aDBXmr2dMVF1qDnwJKAqftO+cHD3n+zurDcbK1XJrwO
	ZjpDc47h3Kr5gmDqu0d36tJ1ZYvNhVfBRS/aJYMOfcZKlKszK8n/UjnY+jnFVfXz/MXr7kL9cw+7y
	BJhMHnyQUfm8Hun9ZeTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grhhN-0000Lp-5K; Thu, 07 Feb 2019 11:18:29 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grhge-00088y-D8
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:17:50 +0000
Received: by mail-wm1-x342.google.com with SMTP id p6so6244531wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 03:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oBG4BBi2BLLQTeAw9jQ6rQjuF426ty7AkYNuZtLk2uo=;
 b=uRsmHZv0TbTfk4zGNg8tlluG9ARjmXRJZWvXuG13K9GjIPmz9A9OiH2TflgVzbkTVI
 0mMYhUwb46o2JoMSMCop8Qd4xIBcNq5kevqPlpnqFDANRgDY/BL83AVESLYa0RHT+qxx
 4jELlqQZMF2PTllBFB34EUMkQarHCbemPmYwnviAc3fv7i3gvxb48klYni1pVBVK2Q9s
 GjYQZZZvqyWmlKBl54f1E8VyJHzmAYzXmTmsUfKxgJgScuSIrKWsih6WVvkt7GU6zu2e
 R0IQZxa5qhNMWjTFxChMIalG2ZyXbiQ7b6R+GnkbowYo8JzuVmzG0exl56gaSHga7uXj
 cqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oBG4BBi2BLLQTeAw9jQ6rQjuF426ty7AkYNuZtLk2uo=;
 b=eU1sgo6n3AcoW1ffW164x+NbVYxDRaiht/Vs0oG+cdZjSrHdN2q6GpfkiOe5zIBOWn
 KBoRiVVsPEIOLqfU1O2lR3wTDqvZaUqNZ8qartDMwyRp95nIHBkf4Wbh986IBiEmBRz2
 ek6t1mSpCsJGq0XAO1ap4nymJSrdQ549iJbAlMFg/mrbnzR/es/eyfg6nh5zC4liqWiG
 taVxRHrSbIb73QB8zpWHglSnhY+nESCFYFGKKfvHpOqDRRhD3n8u59HwkGmzXA4uPfdc
 Gk1kbP/1w366YCiSIngIjMALs1F+sw3REdsEZ9ZM9QdsgYZn88LzmEp9IZdPV7dhHpi3
 PxYw==
X-Gm-Message-State: AHQUAuZoSwwH+CBpou9BvOm69Z+f9x8jKpEDaHS0iceMFfG9BX4qMhB2
 9wsnRFvOybKE81qEBMSWSubfTQ==
X-Google-Smtp-Source: AHgI3IYz6fvDsk2uDQ/EKC5vtERIuM9VvaoPjN7OBXn8QhqpzzUNAzIDc2kxjwxx7fZ/RjCVppQLNQ==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr6721438wmj.129.1549538262631; 
 Thu, 07 Feb 2019 03:17:42 -0800 (PST)
Received: from localhost.localdomain (42.red-95-121-90.dynamicip.rima-tde.net.
 [95.121.90.42])
 by smtp.gmail.com with ESMTPSA id a62sm24490224wmf.47.2019.02.07.03.17.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 07 Feb 2019 03:17:42 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh@kernel.org, bjorn.andersson@linaro.org
Subject: [PATCH v4 2/4] dt-bindings: connector: Add vbus-supply property
Date: Thu,  7 Feb 2019 12:17:32 +0100
Message-Id: <20190207111734.24171-3-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_031744_808389_1888F653 
X-CRM114-Status: GOOD (  10.82  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, jackp@codeaurora.org,
 gregkh@linuxfoundation.org, swboyd@chromium.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, kishon@ti.com,
 linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, shawn.guo@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some phys might need to control their VBUS regulators while not being
supplied by them. If such support is required, use the vbus-supply
property in the connector to retrieve the regulator.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 Documentation/devicetree/bindings/connector/usb-connector.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
index a9a2f2fc44f2..2ad22dd6dc39 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.txt
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -16,6 +16,10 @@ Optional properties:
   non-fullsize connectors: "mini", "micro".
 - self-powered: Set this property if the usb device that has its own power
   source.
+- vbus-supply:
+    Value type: <phandle>
+    Definition: phandle to the regulator VBUS supply node. Set this property if
+		 the connector is supplied by VBUS.
 
 Optional properties for usb-c-connector:
 - power-role: should be one of "source", "sink" or "dual"(DRP) if typec
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

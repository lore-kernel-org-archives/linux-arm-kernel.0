Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2CBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:08:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA3720874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q6hoRpz/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UIAJ6nNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA3720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=OIBCpOLbE+bP/riWxmUm5xDpBVBcJvZnTE1XVWW1qJg=; b=Q6hoRpz/EBogLc6sHHGjrkoJ9j
	KV4tZ4sKLGrRy/59dOb8RqD3JAZb29DL9QAuhYcWgVpcdAQMUqO6UouM183qYOW0yvJolGK5T4kAH
	JmTM+D18PZ/GX+dhrZHG2sQ9w8DF3+sP0AuacUS9e9ClZoIAJ+hpo71KKecBVVpQlHOJAyQGyPG+e
	O8HRge8haaUah9DjBt08FIzRBRKR4vWstiyO1j0rgDFf86OivYYe8qj415kQXQK/rfQemtHEDSeFI
	zWVxSARpPu+j1pw6BJ4juF6iQzs361OMRB7dFylDNuipRDbGVVaf1I1YLzlF+i/JsrLsJIPeiQ3LW
	35yulL7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghp31-0006EH-Rn; Fri, 11 Jan 2019 05:07:59 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghp2q-00060K-0C
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 05:07:51 +0000
Received: by mail-pf1-x444.google.com with SMTP id h3so6400514pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 21:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Yd4M+CUErpLCr3c/0+nYCFyarZVesvGUD1M9BF/zec4=;
 b=UIAJ6nNZon2Q2BL4+fRnjF0DSEqrmbySw11dEkZySZhoQ+RTUdFhgHcnXCWqlOfW5E
 GDuGolFppJbkfrD9KRwTrMGpMJidGgSfk4hYh/tQZM2Yeqz3d3WPP8zOQtBqU1PWr8VQ
 uKUis2EZKbD4r8J4ad3nbO5l4hX9HQsXrcfms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Yd4M+CUErpLCr3c/0+nYCFyarZVesvGUD1M9BF/zec4=;
 b=CGVxVSEtU425Vi/iDFKFFvZcyBHIUhah8lpWlor/hNbtBt/adZmSdhTUeI1hEbeW8T
 D4gkrOKaEvlV5nU2YtIhmVmdbp4CbDWJRUw+SZct7eqtXvqJBpWsBJPWbscKEM/YDgDU
 HGhVxmFyNDctM4yYYsV1Trw4H5RBAMZGydPa9bzR5dzmkmiJN7CRg9CAcO9+jQPB3fU7
 XYCjjC/1bPpC4XQx8zCGf808wqF8KMw9v2DSATZoss47jIs1O8E6wyN/CLs5N3rQJiwn
 D/oRPMl6TaogM5OCYTT09sa7Ia/hdVcCzCfskv9vLszxoYJcYjMU0PfN0dCkAzR3VGd5
 wpiA==
X-Gm-Message-State: AJcUukeh5OIlKpOUBM53le6iVgmH/vZiajMQEKVfdfmc9THbWHSUCsdf
 l8Ws7YupcK+oTxb9RVMBU/7HqA==
X-Google-Smtp-Source: ALg8bN7KaMYq0qDx2S8gRKglTIAQ+C1QlM0w7SWkpXQQG2VN6Yf061iWus0L2pVnb3FcLVei/ShJNQ==
X-Received: by 2002:a62:6ac8:: with SMTP id f191mr12937290pfc.13.1547183267128; 
 Thu, 10 Jan 2019 21:07:47 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id d6sm107520893pgc.89.2019.01.10.21.07.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 21:07:46 -0800 (PST)
From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: [PATCH INTERNAL V3 1/3] dt-bindings: pwm: kona: Add new compatible
 for new version pwm-kona
Date: Fri, 11 Jan 2019 10:38:02 +0530
Message-Id: <1547183284-19956-2-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_210748_190984_60178D33 
X-CRM114-Status: GOOD (  15.08  )
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

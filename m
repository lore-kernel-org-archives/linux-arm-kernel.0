Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05A6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:07:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A291520874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hbfehu9l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hk+CQw7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A291520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=wSAdg5k6CcNxHKtFEEW1o3cpl41qQJc9A3Ir6r9E6EE=; b=Hbf
	ehu9ldQug2QnQTgidwo11Jong53cpCtoDjKgVcWZTW5F2ESsSPbBGESX1pXpruS3zoQPoW/0UCK2A
	/N3NZs0Aql+AOQ9dsHXjy9cHWIYMEc7jU0Ol7EhZkMFmUnINy5nJc3X0FbBkqTDvRipV0hClYSkKZ
	I68iolaSsTt+VlFyJk0lTxjV1FppgYAGmNAU0YW+1KUQ8cRBuwoNAQ4dS2qGYff6GG64JWuun/TEl
	iT4NlwopOIKPQ4VR80qMO3gsImsxMa/stHPNyYttvFYDFDu2QtReZgmSPID3Nt9Vhyo5oH4YL/2+c
	6pTEH87Xr9MlPgZy073c9yJ26Fak2Tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghp2q-00060P-8r; Fri, 11 Jan 2019 05:07:48 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghp2m-0005zL-Gj
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 05:07:45 +0000
Received: by mail-pl1-x641.google.com with SMTP id e11so6220707plt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 21:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=d+QCZEbb8I1PHoVx1anwFEcq7OTA/n96FjbWbIsWIQs=;
 b=hk+CQw7bIhYF2+jOMM5aGzpthfCADKnB876xC4uS+fNuyxhe1EtzvDzr5I4mic0tr1
 JpaQGZ/GAhto9PWQvmzN3ViO2dsb3qwJKT+0EysX5xKedSusxdLi7xSTvIMxVnrKX17C
 dGpwkj4J23Qfs+Xws9kT3gnHqfp4nfU497VUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=d+QCZEbb8I1PHoVx1anwFEcq7OTA/n96FjbWbIsWIQs=;
 b=qwuQhZTtM3Ovs999w9YV8HIyHWKkzY3ZF6WqED991pPJZoVzDwI+bsTeSCVlbxksb4
 E87//s7KVnRzgifiLEoCrLaBlpfpxUzijv3ZWvfNGoVLH3kv1JJwyv5jAOzugtQlGvOv
 K4gQv43Frk4kZxmcfjPrKh+r8SXBrJtnyNQlq5hxfZAIfu6NtY5yHfqBS1apbYjshuYA
 PM+BYmZp4BXGe8xpkNxLtzA1oGiBd/P2yRJ59eApO+0j6pdR7XgC53CcbfLgP6MGAC0M
 +S2ylIfpJsELsDY62G/5SAlyjvJEaCZgOTu6muVY2Jgnju2hZHNKiBGKuONtTtJwCdF7
 MLEQ==
X-Gm-Message-State: AJcUukez4oYYrdW977DDVrPTaJcvn6PqjjIKfimFmuwnUnr91iBxIyUD
 Z6jUKhDWwBe/zw8zri8erbhdgA==
X-Google-Smtp-Source: ALg8bN45s+bPDvyOCgB9CxmMRC4mFauieOw/UCho6hq/LQpte4pdFtR3/pf74SiGGfmNWiXx9PNlXQ==
X-Received: by 2002:a17:902:64c1:: with SMTP id
 y1mr13107725pli.64.1547183263085; 
 Thu, 10 Jan 2019 21:07:43 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id d6sm107520893pgc.89.2019.01.10.21.07.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 21:07:42 -0800 (PST)
From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: [PATCH INTERNAL V3 0/3] Add support for PWM Configure and stablize
 for PWM kona
Date: Fri, 11 Jan 2019 10:38:01 +0530
Message-Id: <1547183284-19956-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_210744_563214_8C7180B1 
X-CRM114-Status: GOOD (  10.51  )
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,
	This patchset contain support to make PWM changes configure
	and stablize
	Following are brief changes done
	a. Add support for version2 compatible string
	b. Change PWM config and stablize delay in PWM Kona

Praveen Kumar B (3):
  dt-bindings: pwm: kona: Add new compatible for new version pwm-kona
  drivers: pwm: pwm-bcm-kona: Add pwm-kona-v2 support
  ARM: dts: cygnus: Change pwm compatible to new version

 .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
 drivers/pwm/pwm-bcm-kona.c                         | 128 ++++++++++++++++-----
 3 files changed, 100 insertions(+), 32 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

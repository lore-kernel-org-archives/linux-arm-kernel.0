Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C56E20872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fWKqgU6T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FWMVqFgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C56E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=wSAdg5k6CcNxHKtFEEW1o3cpl41qQJc9A3Ir6r9E6EE=; b=fWK
	qgU6TWkfhwLTwB2GOVummzPfkJfr3nh6QYBBh+lvBnGdoAHVLLAPtVS6VeKB8lr4GRy9OnP9ZDKNl
	faF321MXWQEThCFE5iQgLDgLOg930GDINbhb2aNhN/m8gT1ApHbz+M/arK/My5QJSDcANR7rmXdC7
	OM7QDJGM0PXjxj6kFlsSd9HXsGL6eIQWNrsvj24pqWh0xOcDT9iBPACY27ZnL8F811rzJV/dbwL1s
	+jpabQExiRQ9GS+1ra2HOX70b7qtVv2nZiuBup1xx68ITEFmFGXBK3efKZqcfF2yYrkDLspKt4ZKW
	GF4857E75SvPZ9FdpLi7I8hICK6Lgfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghpFl-0003Es-5W; Fri, 11 Jan 2019 05:21:09 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghpFh-0003EP-7M
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 05:21:06 +0000
Received: by mail-pg1-x543.google.com with SMTP id z11so5840113pgu.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 21:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=d+QCZEbb8I1PHoVx1anwFEcq7OTA/n96FjbWbIsWIQs=;
 b=FWMVqFggvtn9HchiFeiBPrzA6xmoVxb2I6zBZlwqpQ0FsXFc/yZvoUe5wzN3ylxK/b
 7vUmkqo0ZoH1XxcW/pc4OJy/ifYYZq1WLOB+peMpyCRJRJZm8rO5pCQTAjrRJ8/gZR8u
 QkFfMMruabjxsFAyUCwhA/JUrdrNnx37wF5VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=d+QCZEbb8I1PHoVx1anwFEcq7OTA/n96FjbWbIsWIQs=;
 b=Xmmu+4cZtuhpri4K6gpz1ZrqbTYvD0YmHl16b3GTug4S/hDqPH0zPa/Q9KsyQ+seo0
 H1WP8ONIfpOJvnQLs/eB84eAvnDAmj9oeDwXXiUzBh0xM0LMmdyZMGFVPham/HtpHHQM
 ML99r7Pzv32i/lSJdkhrwFooEwczmeDvoQ2j38Yy1mJV7FEML/XibOduVjdpcTTPsmQG
 GtpH48J+dSECZ//HKL3yyhPQi/4nWHFGBIq/hv3LQeZ+VGrTx3zh/wyTGGkPufipHva1
 OFVLlTVm7xXRRkgl8zYjDfN0TUA1cInHxvm4wUIfjqPXIfv8N3WLSvna5u+4vjZ88BUB
 oIFg==
X-Gm-Message-State: AJcUukdj3DTz+HWbmfdIM/zpGND9PP8itaCBgrZtuJDbdO8Fa/BrYfqj
 bLUlnYWH3xdfvfqBejLGSU1NGg==
X-Google-Smtp-Source: ALg8bN5n6sF59rtRzq1JIaYiy5l1r/j61rUcweghWiW0MvMZNxS3OJoahxg0nBCBRFMIhGPFtEE/0w==
X-Received: by 2002:a63:8d44:: with SMTP id z65mr2026212pgd.57.1547184064235; 
 Thu, 10 Jan 2019 21:21:04 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id 186sm148425418pga.36.2019.01.10.21.21.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 10 Jan 2019 21:21:03 -0800 (PST)
From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 0/3] Add support for PWM Configure and stablize for PWM kona
Date: Fri, 11 Jan 2019 10:51:13 +0530
Message-Id: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_212105_276030_37C3F015 
X-CRM114-Status: GOOD (  10.74  )
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

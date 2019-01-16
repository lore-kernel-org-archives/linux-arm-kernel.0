Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D07C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D80620868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wbya9V5I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FKFdpitp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D80620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=xW7Ymq5N8+5dwdePHaXLitNVEzoPrc9ZjZzzm9FJFdg=; b=Wby
	a9V5I0DLBGefMqG6ov8aCW60Lz8GSD0tLT0k1mdotM39dHBY2La5WFw1S8uBUoIl3tKlSoUIfqMCC
	6kY3vUFLVx+HNDyHHkUR6FnVHpU1Apaqs2DuGepHDues0EGeHN3A//s2t5qKwxu/yP6G6zvCLkMNo
	oo/2ELvSO10S42v14j9kOTp3EuBN8eGK8L+nKCbKkZw0Gfj8G3y97IMH9438TkGTvawBuZMs81iar
	WNhPAZtVNacOduG6ZjA688lAoK0uW4SRzvYv+zNom8rLpnZR28x+VtCWaSzz79vXc7jtQcPTUcW20
	xvUQXsLuKBOlW3GDh06D1QNIMUX0fdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjraU-00031d-5K; Wed, 16 Jan 2019 20:14:58 +0000
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjraQ-0002q7-DI
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 20:14:55 +0000
Received: by mail-yw1-xc41.google.com with SMTP id b63so2918843ywc.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 12:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=l9HGiB2QaCG+ZQSwLJEa2ko8TjgLeMDeavjJfrXdC98=;
 b=FKFdpitpEXtu/3S2xAZfETpvHvPDnvpYaccPl8hlFZuOvvgWTnYHLcXSn69ARiAviT
 4Tb2mWKqSBn4SPgK9Du8/hGYgYgP6CVbop9C92gFiUJxKIa0Swg8bgYM/p0QOCs1xSX0
 1GJwnTMUxUxg2kiq5BO16GZnf/3khdRUKfnVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=l9HGiB2QaCG+ZQSwLJEa2ko8TjgLeMDeavjJfrXdC98=;
 b=G5kdIEZhPtBHa5fk87R8yu0axn1ijFfe5dIQv7QpSOR2WdypWMW8UKtcQdG4/oXd77
 zlmzZls2EajEDw75rQwMRkVjoHuj68k27/aUsdOzAP8OK48/xEWQ4SzhQw4yt3WQ0Eqi
 OeodaAS3ivWQPe7TjFvoJtYNpVBWwkj1xB1fe5vOpI2w+UTjSlaCQI9mJR1uEt17SnH+
 bYrCV6eVm53GM9bQC7TcJJ5FTYSecduZGXVUA14RCQnWmzoKoTMF0j4vhIf9st6/O3PR
 /eN00FekZC8GUUnNTxOVCDMe4LpJrpofP5otxvahqVioBiUcQxEfnt5f7HdCRRAGGzjJ
 XYnw==
X-Gm-Message-State: AJcUukfWMspdBA822rjuyxK/yTTGQoxUkwzC4U/orkTQuLMtPf6TJeVj
 RMznLLBF/cz+BK11xhz/QfogVw==
X-Google-Smtp-Source: ALg8bN5XsnsfdzUiyl9tMp2oDQv81CzTMnrSPVFmXKiWoBrnvviwanFtChxQMA7bXyneKLww30eyxA==
X-Received: by 2002:a81:554e:: with SMTP id j75mr9441089ywb.406.1547669690717; 
 Wed, 16 Jan 2019 12:14:50 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id w63sm2541026ywc.46.2019.01.16.12.14.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 16 Jan 2019 12:14:49 -0800 (PST)
From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Subject: [PATCH V2 0/4] Add support for PWM Configure and stablize for PWM kona
Date: Thu, 17 Jan 2019 01:45:12 +0530
Message-Id: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_121454_458616_5C866F78 
X-CRM114-Status: GOOD (  10.73  )
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

Changes since V1:
	- Addressed review comments

Praveen Kumar B (3):
  dt-bindings: pwm: kona: Add new compatible for new version pwm-cygnus
  drivers: pwm: pwm-bcm-kona: Add cygnus-pwm support
  ARM: dts: cygnus: Change pwm compatible to new version

Sheetal Tigadoli (1):
  drivers: pwm: pwm-bcm-kona: Switch to using atomic PWM Framework

 .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   2 +-
 drivers/pwm/pwm-bcm-kona.c                         | 290 +++++++++++----------
 3 files changed, 158 insertions(+), 136 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

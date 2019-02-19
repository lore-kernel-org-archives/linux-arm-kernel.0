Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A2FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0610820823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="par0/TEy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1QOqPHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0610820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tJTU1FI0q6DzO8HBpO2TX3rv3EYNBVpB+/AvnDLUK0Q=; b=par
	0/TEyxFWBiZDZkHhxcrMrCXnwQSSDjPMGk8sjV364AzVgVKGAOsfSE4ZtnbrDNm6LlXIyE+1zoJnr
	kjHQD1Oc6D+1jK6AtR5ffQT7VXkGdTW1mxziz+WCDzRtqBhObzGSo8yQL7M6j1rWrC5/NB3b5HPDn
	9zu9e148VqJUA+CxJ6H5XcuN1ovYLhkA2N0HeZMGd/j/XPY1FRyatcV2fYL97ISrGZK5IwYaIbru5
	91Xlb4tz43OE1W97f3RZbn/GboyfbxbeS2on338supd6COvwXm2ovZ4gj/ici2QqABUK17FcJaC8H
	D7aGKH6WCPcSC+LqevTyvE1N2Bn0FWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw53c-0004kJ-Ii; Tue, 19 Feb 2019 13:03:32 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw53Y-0004jg-UL; Tue, 19 Feb 2019 13:03:30 +0000
Received: by mail-ed1-x544.google.com with SMTP id h58so16647208edb.5;
 Tue, 19 Feb 2019 05:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4otjqvATyvxwtVAjMO64Wyk2yKEX+nv7+hkGyQumr8Q=;
 b=h1QOqPHxb0dQS+i1scczue+yDCPTQWMTBzaoASbFniIE0ODG40vXqeIzi+Pq0rz1Pt
 A7YKhhJNlRDoAoz0sFPc4wkwIKSCmFMuojSewnexBiYUzm8MrqJlnukvjaifafdSRwlm
 qeIhew2m+wtB4chjLAYenrPbUUS9qgAGha76UnoB+fYUF4u1jBKvm6cmwnmcCx9tBUOE
 pmEPgCP+ecrqcUKj9Iy7wMY40Z6LyhlQlRtJPqIOscY/UuIUnw3hD/9CEZnHMhJzctRM
 PsaBC3lcxgrREHZ0p8hTnrfMOgPRPBRrYFo4G+nJU62jq0xyXbNtxBMGN3N3pGZ10uz2
 9sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4otjqvATyvxwtVAjMO64Wyk2yKEX+nv7+hkGyQumr8Q=;
 b=OEkLQUP2G8X8YiAABrT6nBgjZYzzSqA5loMecvDiaQYkYPptTKDcErdX7cVyDA+YLQ
 i7bMI1zTEQiZoTCK0fHZwPbX9dSfTZVff2e1bRuYt/Og/AC1bsorEirOAOuiog1lF68h
 +wFxALYUBh3UeP5IMnvT/Yo36NRBI8bvd7A6YKgpHxWjH4jfSH4NkeCFe5Or91ulD/Te
 +cc8CfZk4Pn8UfI8TfCqnVibN3hQrwoVj+0tTw6SzuBzlekdTFZefbAqG57hlMYijmAt
 6goRf2H9/jtHxguxnB0oycYMpd+QphpDuyyaBwoz099v1zJDfTY6Pd4o/+H7f3zTvGM8
 WUpQ==
X-Gm-Message-State: AHQUAub4qXXp2x3jWsybCjyyKhL3BS9QZeVu8aqIsrmPVFwOom7eysve
 lTA2hYJnQE3Kszd+kQ9eYe8=
X-Google-Smtp-Source: AHgI3IZtJFi/bzGmxFTbDze/yTGnMZmPq4B8GqNOp622LvTMvtcFMSOQKD/BXMh0fO8vkhrgX9M9xQ==
X-Received: by 2002:a17:906:68f:: with SMTP id
 u15mr19903730ejb.147.1550581406801; 
 Tue, 19 Feb 2019 05:03:26 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id q3sm3707505eja.40.2019.02.19.05.03.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Feb 2019 05:03:26 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH] ARM: dts: rockchip: remove disable-wp from rv1108-elgin-r1
 emmc node
Date: Tue, 19 Feb 2019 14:03:17 +0100
Message-Id: <20190219130317.2817-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_050328_972034_12AD6909 
X-CRM114-Status: GOOD (  10.89  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The mmc.txt didn't explicitly say disable-wp is for SD card slot only,
but that is what it was designed for in the first place.
Remove all disable-wp from emmc or sdio controllers.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108-elgin-r1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index 1c4507b..b1db924 100644
--- a/arch/arm/boot/dts/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -37,7 +37,6 @@
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
-	disable-wp;
 	no-sd;
 	no-sdio;
 	non-removable;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

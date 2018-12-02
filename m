Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDC9C64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B042082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="peUjfe3s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/KCqhGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B042082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YNSHA1PdJ7gmAvd+G1K9AQJmAU93pYw7yAxroWN5PHc=; b=peUjfe3sEkoGnG9c8QvaKNoX0N
	1vip+iMVSetnVkHrSLJn0E3sJa6AonIiPzAeNTcVriQFcX+PjoFJDbCNlNC6RbNBWr4gsvogwC+WI
	XIgUhf/SRJidv84XQFGgzVXmgkP9QWLSoISA0Ezr1fTcJkHDLPA9IZ+EQ5xVTwiYEcn1qF/YuC7EV
	tdNI7zewpICC2tL5rFkEnbxOgU9PdBDBCFiypPMREohYSnYcz5lq3uNp3BC3UyeN5FBFTKFwRrPkm
	k0EhV57deW+10wkaj8H2SjgkdGW0ajQEt+o9FkRV36j0g5y4EuSmEJSa+WNMJPha9+S5XQVa0AMmo
	9eSSaRfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZE0-0002dW-M3; Sun, 02 Dec 2018 21:24:24 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZDR-0001zP-C1
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:23:59 +0000
Received: by mail-wm1-x343.google.com with SMTP id n190so1324824wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=321l4njH4VKx1kXcZRO12v94G6OHeKZhCHKTSWfxtGw=;
 b=c/KCqhGMlJRWoAy0adHmP/uhcwsLnoDcS82IjHwJKQoG/kYnmPB+Y1utTr6x5pAyov
 f+RUXTAC+rfWumUm2W9df6BQfsDs3soW/+ArqYdu8NLtCjEcgpnnNYneqmev1HIE8Z4R
 BInFXhhLPNJD/ffVmOKdoQQ20FciNI8VEhOJqbqu9TV9OkCt7IF0C5+3VMwd9ZufYEaB
 XVwVz7yg06QT5hlhUeUxz3lnjdwRlOSJwgGa8759CeCh8hfnfW5RioAXB3oNeGTrlKRI
 yN5PW6XrpDvsLYrV6ZsUNt6P3SKJSm7w/e0Nd9be123lDTALFEL9Fb2dEJgG4Zl/Vhrn
 a0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=321l4njH4VKx1kXcZRO12v94G6OHeKZhCHKTSWfxtGw=;
 b=OAzetwI3UtSHxEz8sFhpW11Jhf+2mlbmooq6iH2KhukkzQuzAhqYCIWLmgS30X017+
 0S1CwU6QgeTqq0lrBlLEToIs/kTA+a1ySQUvvL1KZdof+0Tpx9LE4KgcPG2S9JG2fQep
 X6qUil83E1y8oraUEE8AJ2oAdONvYObo6mnRcfkGfH39il5O7knkAHuERAQLqdrWYzcm
 zr3wThZwYSrpN23Gg8Uole1xUk9T6y/JlNkSR/A4dRkAZUgNvBaL3/DFFIHYExrzVU/e
 9J7NmBvoNLkFqlUyFC2NsmKa9+kdykMYCBWq8fvKQa6zquru6G0wL2LPbS6aVWi258ga
 MtQg==
X-Gm-Message-State: AA+aEWb6N7+ME11s2+EX7tnILaVl5gLnf0lTSrptbKSO/vBHI86nG2Za
 ajKjHiytVuMladpe1TomvEQ=
X-Google-Smtp-Source: AFSGD/UFiJgDOUG3QDNwHWa5gq+EOo3BLWA/KPHD5LPyqkAK+EC7gjFf4e40y2GkJe47hvXvBg5D8A==
X-Received: by 2002:a1c:1a90:: with SMTP id a138mr6208939wma.109.1543785827957; 
 Sun, 02 Dec 2018 13:23:47 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 13:23:47 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Subject: [RFC PATCH 10/10] ARM: dts: suniv: f1c100s: Activate Audio Codec for
 Lichee Pi Nano
Date: Mon,  3 Dec 2018 00:23:17 +0300
Message-Id: <11eb58fbfd223e041d03b6cec3363a7d08bdad45.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_132349_881682_B2C749A2 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Mesih Kilinc <mesihkilinc@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allwinner suniv F1C100s now has basic audio codec support. Activate it
for Lichee Pi Nano board.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
index a1154e6..7618f8c 100644
--- a/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
+++ b/arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
@@ -24,3 +24,11 @@
 	pinctrl-0 = <&uart0_pe_pins>;
 	status = "okay";
 };
+
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Headphone", "HPCOM",
+		"MIC", "Mic";
+	status = "okay";
+};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

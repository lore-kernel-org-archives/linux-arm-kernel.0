Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B93C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:31:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFB420892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kSCm7OEH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qN+T3GUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFB420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XURTpWfQYcKTyOLSpyDBY6gqahJC/cCp90ptEc8HShM=; b=kSCm7OEHD05J58
	5AlaOnwzp07c3MDM8saRtOKmQhRnqJJ1hncC7PWNWPy8d/ErXzPovm2ugvKwL6jlI/iBuAWVk16qJ
	M5QpaHfCaWkL7TYrhG9qlgvZt47ICDahpTomxA6nMFCUbrrhNpnbA6rEVV/ryLzSWrrQyhl2Ext5x
	rYWXWblAv4MuTyz+Nt4iFgUvKzaWrftcrXSvdamns0akxnRn5xjQhcLF6WDpxgmf7XD6W6JsvSevb
	FcpDw0O40Rgkizm27DUUprVnoQImsxX6BxG0UWPJ+4CAWW6ahSeCA3lzBBgY3eprLWNPR6WHFKfh3
	RWOxWxi1F5/T8MdOnHxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTaH1-00075V-Nq; Sun, 02 Dec 2018 22:31:35 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTaGr-0006wi-Vx
 for linux-arm-kernel@bombadil.infradead.org; Sun, 02 Dec 2018 22:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ucrg0FmBQWhPhP3EvzOr0Lyei3/PizNO0LDkOiMRUHU=; b=qN+T3GUAG6Z23WbxpC9AOHawPY
 5PgnOJlSMmtzVXDW+aHofh445XKDWY4RgNsvvwpzEewntT4CNW6roYxdLJ+9CpS/UKrG9sqx1rf/k
 dLcgpW1FpuSIbyR+5ThrYfFOH6us0aiqDuUPt/Ip9P/4cmT8FQc0Dy7c5M/eYC2Vz5i5waT7xPd80
 jezGkK2lXkcEN0sf1p8Kesr7eG80TQcbsGiOLAUK0rpTWouYA+6ZvBJsOeGeN7FTSaiJKmfL41Txc
 nYMmg6tdnaJ6My08ZqfsPAb6MdToHY0Hp29m7AXsAA5log0Cy2DFe2w8iSCEVqCpmuGlSRMXQ2Lx/
 Q1IsXHjg==;
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZFh-0002gl-Nu
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:26:11 +0000
Received: by mail-qt1-f195.google.com with SMTP id n21so11653389qtl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=Ucrg0FmBQWhPhP3EvzOr0Lyei3/PizNO0LDkOiMRUHU=;
 b=NH19VLx9nsgWdRYU3KEVUeF9b6qf6H33w3B/OCXEjqbXDKdflJN1QUB7Lr9jmUAZ7D
 34fPwB8Fa7P0Vd7p4mfSjar9nflhLYBv3ZwVO34c0PMaz67qbcLKg+UuLr1XHPb2raIA
 Plzu22K2cusvIteGTBpUzzd6VLFi/KIUS7wX9RTeFOkuK0uoYqAwk7O9+jsgeo26jhac
 GlS9TZPs+xkB5cfXMpgulPZwqEzZ34zPt+1XmtoEPQsTajqvzR8gLNt7cuPN1u+rwyN3
 PlzODVPXwQKKm8yCRhYf6wsdfqo63cdW5IvzaAZ4+RIe6hp5Dj79W+khcVRqN6SxcaTF
 iCfQ==
X-Gm-Message-State: AA+aEWbdLHoZtc/OD6xX1IOSOAgbi/jsrxbQ37i8gn42nqKTodFStnqR
 54L71dtXaK2CoAofXX/m+Ji64wiV
X-Google-Smtp-Source: AFSGD/WyXdn17bQ1wucLDBQKF0jVrb+UGwZ7yQbXQrqTGjkDGmhSymaNJvu4lGSnXg5h9lyMaWu0Bg==
X-Received: by 2002:a0c:b919:: with SMTP id u25mr13566244qvf.104.1543785958509; 
 Sun, 02 Dec 2018 13:25:58 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id e26sm6077085qtg.69.2018.12.02.13.25.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:25:57 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:25:51 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/9] ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
Date: Sun,  2 Dec 2018 19:25:15 -0200
Message-Id: <20181202212520.16650-5-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_162609_804139_327AB962 
X-CRM114-Status: GOOD (  13.64  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

Pass the USBOTG1_PWR pinctrl description in the USBOTG GPIO
controlled regulator.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/imx7d-pico.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 7319e2ecec5c..cb30bded1e4a 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -41,6 +41,8 @@
 	};
 
 	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbotg1_pwr>;
 		compatible = "regulator-fixed";
 		regulator-name = "usb_otg1_vbus";
 		regulator-min-microvolt = <5000000>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

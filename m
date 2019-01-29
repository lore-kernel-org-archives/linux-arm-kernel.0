Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5021FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:11:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B8B20856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NlidEMQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B8B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=SrBqvevnKXQqotg4mP5RrT9pUEg4C0GB4LQPu5eh4VI=; b=NlidEMQTCDxKyA
	mBrQlm+lfoLBLVwx841bGxJbE4ML3Rn4oPY50Da91S6pAsjELmz4ZerR3EQpEBaJdfEcpe9audWzB
	xBq5hXBNLciubO76Km3rPb07oG7saDzeWja1tA6gh6q8YfDGaIczAXoN0ZE5q4ZeYjarnOgstIBBZ
	bs5lnhJNp1LbOrC1FACR3oZHUN9VkczTuSQlT8zsscx/TL3Wu6lGtk/y1HJJO6CMUopJryObAOajH
	Dd8li24i0nUl/t5Tm2Oyupv3NMx7x548lXmmtApRUHItSq7LOhCDm072MtG3A6mKYddsgYXZJGIvL
	GaUP+8exmNOZ5kXvxXKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goRIY-0006pj-Ta; Tue, 29 Jan 2019 11:11:22 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goRIT-0006kv-EU; Tue, 29 Jan 2019 11:11:20 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 4137FFB03;
 Tue, 29 Jan 2019 12:11:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R77ELBdo6Z_L; Tue, 29 Jan 2019 12:11:14 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 9BEA6435AD; Tue, 29 Jan 2019 12:11:13 +0100 (CET)
Date: Tue, 29 Jan 2019 12:11:13 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2] input: goodix - support Goodix gt5688
Message-ID: <20190129111113.GA32222@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12e21befacf68861ddf34020838ff7a6e6e078ad.camel@hadess.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_031117_859235_EC86D5DB 
X-CRM114-Status: UNSURE (   9.19  )
X-CRM114-Notice: Please train this message.
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
 Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From what I've seen in vendor trees it's fine to treat this as gt1x=B9.
Tested on the Purism Librem 5 Devkit (Rocktech JH057N00900 panel).

[1]: https://github.com/TadiT7/android_kernel_mtk-4.4/tree/master/drivers/i=
nput/touchscreen/mediatek/GT5688

Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
---
Changes from v1:
* Add tested board to commit message

 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 drivers/input/touchscreen/goodix.c                             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt=
 b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..57d3d8870a09 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen co=
ntroller
 Required properties:
 =

  - compatible		: Should be "goodix,gt1151"
+				 or "goodix,gt5688"
 				 or "goodix,gt911"
 				 or "goodix,gt9110"
 				 or "goodix,gt912"
diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen=
/goodix.c
index f2d9c2c41885..47b1ced41576 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -216,6 +216,7 @@ static const struct goodix_chip_data *goodix_get_chip_d=
ata(u16 id)
 {
 	switch (id) {
 	case 1151:
+	case 5688:
 		return &gt1x_chip_data;
 =

 	case 911:
@@ -942,6 +943,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] =3D {
 	{ .compatible =3D "goodix,gt1151" },
+	{ .compatible =3D "goodix,gt5688" },
 	{ .compatible =3D "goodix,gt911" },
 	{ .compatible =3D "goodix,gt9110" },
 	{ .compatible =3D "goodix,gt912" },
-- =

2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

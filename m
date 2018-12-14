Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6431DC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:35:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1ABB206BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hg9/rduD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ABB206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oZxf6CElFiUIYhlU38a57tcKRkcabTOjFsjgna7LArs=; b=hg9/rduDBrnZD4
	l6J8KeUfbbXJthN0gYiNQGJjrg1w1w0xbjrYV0NTYqA39K69qkQmE5EKPGq40WlGjypQ+2oc7rVga
	4LTZpquSPhdbUMfETz3FXW3cbukWxkdMtbUG8mU+zc/LI9Lc90sj4sn2pRko0NQyxG/n8EoUFUAxd
	dksjMUrO0v5VzasiQI5HG7KkRTsFxoo1aQpSOs/s7B3O/8CmxRHXSNe8cogLaFB+v7mHZrJYD40fh
	SF/btxtD79hBu4gluEvFRiyCz1vT41vHJ4UqDMVLxErUopecW4FN8qnSVxYVv7Vus/kDPKRoKtaIu
	CDNOmAzZmBXRBM2Vkm3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXoYJ-0000BY-FQ; Fri, 14 Dec 2018 14:34:55 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXoY3-0008IO-6w
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 14:34:41 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBEEVIJZ030822; Fri, 14 Dec 2018 15:34:23 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p85qkm06d-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 14 Dec 2018 15:34:23 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DFF934;
 Fri, 14 Dec 2018 14:34:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09EA052EC;
 Fri, 14 Dec 2018 14:34:23 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 14 Dec
 2018 15:34:22 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 14 Dec 2018 15:34:22 +0100
From: Pascal PAILLET-LME <p.paillet@st.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com"
 <lgirdwood@gmail.com>
Subject: [PATCH v8 3/6] dt-bindings: input: document stpmic1 pmic onkey
Thread-Topic: [PATCH v8 3/6] dt-bindings: input: document stpmic1 pmic onkey
Thread-Index: AQHUk7oaecGFTE0pbk2lhI+DNvoCJg==
Date: Fri, 14 Dec 2018 14:34:22 +0000
Message-ID: <1544798057-1499-4-git-send-email-p.paillet@st.com>
References: <1544798057-1499-1-git-send-email-p.paillet@st.com>
In-Reply-To: <1544798057-1499-1-git-send-email-p.paillet@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-14_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_063439_529184_D7093962 
X-CRM114-Status: GOOD (  11.12  )
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
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Pascal PAILLET-LME <p.paillet@st.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The stpmic1 pmic is able to manage an onkey button. It can be configured
to shut-down the power supplies on a long key-press with an adjustable
duration.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes in v8: nothing

 .../devicetree/bindings/input/st,stpmic1-onkey.txt | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt

diff --git a/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
new file mode 100644
index 0000000..4494613
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
@@ -0,0 +1,28 @@
+STMicroelectronics STPMIC1 Onkey
+
+Required properties:
+
+- compatible = "st,stpmic1-onkey";
+- interrupts: interrupt line to use
+- interrupt-names = "onkey-falling", "onkey-rising"
+	onkey-falling: happens when onkey is pressed; IT_PONKEY_F of pmic
+	onkey-rising: happens when onkey is released; IT_PONKEY_R of pmic
+
+Optional properties:
+
+- st,onkey-clear-cc-flag: onkey is able power on after an
+  over-current shutdown event.
+- st,onkey-pu-inactive: onkey pull up is not active
+- power-off-time-sec: Duration in seconds which the key should be kept
+        pressed for device to power off automatically (from 1 to 16 seconds).
+        see See Documentation/devicetree/bindings/input/keys.txt
+
+Example:
+
+onkey {
+	compatible = "st,stpmic1-onkey";
+	interrupt-parent = <&pmic>;
+	interrupts = <IT_PONKEY_F 0>,<IT_PONKEY_R 1>;
+	interrupt-names = "onkey-falling", "onkey-rising";
+	power-off-time-sec = <10>;
+};
-- 
1.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

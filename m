Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588D6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:37:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CF1206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tOjXIHf8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="r3QAP4yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CF1206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:MIME-Version:Subject:From:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1lbq89qQ4kaJDHbmt8wDByOoTj8IRAX74glA7KswmDY=; b=tOjXIHf8ydKg9U
	GvPFbcNWbaobUO9jGwsT0W1LUEJMM+RpMZFydVhR8M69twAnJ0z6LHB7KpRqejSTidKesReZ+esIw
	mXA7F+rqVLquxhXtGdtqVSqbXCtPjJJA03CMt4eavdwVdnEApmflQwepbgOD0kfeeRjrkYEVfH3Jo
	cE7i9Eg+2j9Hoe4urXLuET0KQm9JbtifEOjF4/ObpUoxvpYJ6TjbJkGRXjDfzo/j05gUKQe6hv0Zd
	l74tMw62/voMlk5U/htOmSOgs1rmi7B1lGKz6jCw8Ioel8kz7IA5pjsvPrJO1gD42aU8iIRMmn4Ai
	HAn9IX6Lx5FiVdLRFyQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYyhm-00063o-Sg; Mon, 17 Dec 2018 19:37:30 +0000
Received: from rere.qmqm.pl ([91.227.64.183])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYyhi-000628-Rp
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 19:37:28 +0000
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 43JWbG1f2vz60;
 Mon, 17 Dec 2018 20:35:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1545075339; bh=B0IHFVymz4dj8jF2LKmyqX+dBVLS/zqRKUHcldhF5Gk=;
 h=Date:From:Subject:To:Cc:From;
 b=r3QAP4yqmHq5ohv2mGSblubtmuQu0og9rS0DDxWSZzVsXD1vS3CQmEKD7AUppxmtd
 /BHKpER3w4meNax3vP6LYIZgW5Iy2d5lAo63jd+GlXgG3kh9rH9v9MQw/lUV1PP2m0
 vRCPITXVDEY/f2MqepoARGUynQUafPYxzX8gxW1kI+ekpDp7pKWrCRh6MmhDD9knMo
 W0mQg3WC8GbtB/QaY6kj/rJP5IOHnbSjXBSZ2berNG2yGJVCpjsT6S9+2ACFFkQ+t8
 AFyt8TYDiyRrNAZkxtAYMTk4fH8I3X4PwuYBEI5b4m7+xPtIZ8yOhZpM6M9J7D9TGe
 Rfb/L3lk7MMFA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date: Mon, 17 Dec 2018 20:37:04 +0100
Message-Id: <e07fdef0c9a959a6e820a040048e9ab5b7aec9d2.1545075103.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] clk: at91: enable AUDIOPLL as source for PCKx
MIME-Version: 1.0
To: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_113727_070579_B28C34EE 
X-CRM114-Status: UNSURE (   9.23  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

U0FNQTVEMnggaGF2ZSA2IHNvdXJjZXMsIHRoZSBsYXN0IGJlaW5nIEFVRElPUExMLgoKU2lnbmVk
LW9mZi1ieTogTWljaGHFgiBNaXJvc8WCYXcgPG1pcnEtbGludXhAcmVyZS5xbXFtLnBsPgotLS0K
IGFyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaSB8IDIgKy0KIGRyaXZlcnMvY2xrL2F0OTEv
ZHQtY29tcGF0LmMgICB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRz
aSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaQppbmRleCBkZDBkZGE2ZWQ0NGIuLjZj
OGMxNWMzNjNlNCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNpCisr
KyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaQpAQCAtNTI2LDcgKzUyNiw3IEBACiAJ
CQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwogCQkJCQkjc2l6ZS1jZWxscyA9IDwwPjsKIAkJCQkJ
aW50ZXJydXB0LXBhcmVudCA9IDwmcG1jPjsKLQkJCQkJY2xvY2tzID0gPCZjbGszMms+LCA8Jm1h
aW4+LCA8JnBsbGFkaXY+LCA8JnV0bWk+LCA8Jm1jaz47CisJCQkJCWNsb2NrcyA9IDwmY2xrMzJr
PiwgPCZtYWluPiwgPCZwbGxhZGl2PiwgPCZ1dG1pPiwgPCZtY2s+LCA8JmF1ZGlvX3BsbF9wbWM+
OwogCiAJCQkJCXByb2cwOiBwcm9nMCB7CiAJCQkJCQkjY2xvY2stY2VsbHMgPSA8MD47CmRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL2R0LWNvbXBhdC5jIGIvZHJpdmVycy9jbGsvYXQ5MS9k
dC1jb21wYXQuYwppbmRleCBiOTViYjRlMmE5MjcuLjE5YmFkZmM1MWY1MCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9jbGsvYXQ5MS9kdC1jb21wYXQuYworKysgYi9kcml2ZXJzL2Nsay9hdDkxL2R0LWNv
bXBhdC5jCkBAIC0xNyw3ICsxNyw3IEBACiAKICNkZWZpbmUgUEVSSVBIRVJBTF9JRF9NSU4JMgog
Ci0jZGVmaW5lIFBST0dfU09VUkNFX01BWAkJNQorI2RlZmluZSBQUk9HX1NPVVJDRV9NQVgJCTYK
ICNkZWZpbmUgUFJPR19JRF9NQVgJCTcKIAogI2RlZmluZSBTWVNURU1fTUFYX0lECQkzMQotLSAK
Mi4xOS4yCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=

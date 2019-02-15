Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3F2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:12:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7722192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XbHcyXDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7722192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g9ZRtVoNqbawjmGy2/yQkhcrCmwcUxu+UtnqItzbL0w=; b=XbHcyXDekbO3c1
	URsO2h+xLr7gqTJy/MYrgJCZEdgQQhMa8LiT+DItNebDx1QtGfm4+DxtwUt7jXHEbWzxEymEE9XAq
	MNB/NQ0o8KO45xpeYRXxElG+ojwlaMCDSsPKMJiOFW1LwdCJhOGA7INykgpi+tk6Yg49zzdQYU0f6
	/Ef0+5IRNz5qqI6fPvH0GKqr0V7NBzIQ0ToO6rW8yU7Ohy+3empQu0dm1bdmbXwOBkxFx+zl7XqOG
	kUu1aEoqEs5IHUfwk13k69zhRi+3YzxNLQIYHOvUrlQVhP2XzHRRac+Rm2NOsuZCZCSy5YHveM39e
	QIacOtEeUOCWe1GwR2fA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueEL-0006eV-KU; Fri, 15 Feb 2019 14:12:41 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueDg-0005nL-1v; Fri, 15 Feb 2019 14:12:02 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id B8D4DFB05;
 Fri, 15 Feb 2019 15:11:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EKDJlwlJj3iu; Fri, 15 Feb 2019 15:11:53 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 4A4AA48DC3; Fri, 15 Feb 2019 15:11:53 +0100 (CET)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Bastien Nocera <hadess@hadess.net>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/3] input: goodix - support Goodix gt5688
Date: Fri, 15 Feb 2019 15:11:51 +0100
Message-Id: <f342ad633683716cd2acb99b819da76c06ce0850.1550239328.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550239328.git.agx@sigxcpu.org>
References: <cover.1550239328.git.agx@sigxcpu.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_061200_251840_75789966 
X-CRM114-Status: UNSURE (   9.40  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbSB3aGF0IEkndmUgc2VlbiBpbiB2ZW5kb3IgdHJlZXMgaXQncyBmaW5lIHRvIHRyZWF0IHRo
aXMgYXMgZ3QxeMK5LgpUZXN0ZWQgb24gdGhlIFB1cmlzbSBMaWJyZW0gNSBEZXZraXQgKFJvY2t0
ZWNoIEpIMDU3TjAwOTAwIHBhbmVsKS4KClsxXTogaHR0cHM6Ly9naXRodWIuY29tL1RhZGlUNy9h
bmRyb2lkX2tlcm5lbF9tdGstNC40L3RyZWUvbWFzdGVyL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3Jl
ZW4vbWVkaWF0ZWsvR1Q1Njg4CgpTaWduZWQtb2ZmLWJ5OiBHdWlkbyBHw7xudGhlciA8YWd4QHNp
Z3hjcHUub3JnPgpSZXZpZXdlZC1ieTogQmFzdGllbiBOb2NlcmEgPGhhZGVzc0BoYWRlc3MubmV0
PgotLS0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC90b3VjaHNjcmVl
bi9nb29kaXgudHh0IHwgMSArCiBkcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaW5wdXQvdG91Y2hzY3JlZW4vZ29vZGl4LnR4dAppbmRleCBmN2U5NWM1MmYzYzcu
LjU3ZDNkODg3MGEwOSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC50eHQKQEAgLTMsNiArMyw3
IEBAIERldmljZSB0cmVlIGJpbmRpbmdzIGZvciBHb29kaXggR1Q5eHggc2VyaWVzIHRvdWNoc2Ny
ZWVuIGNvbnRyb2xsZXIKIFJlcXVpcmVkIHByb3BlcnRpZXM6CiAKICAtIGNvbXBhdGlibGUJCTog
U2hvdWxkIGJlICJnb29kaXgsZ3QxMTUxIgorCQkJCSBvciAiZ29vZGl4LGd0NTY4OCIKIAkJCQkg
b3IgImdvb2RpeCxndDkxMSIKIAkJCQkgb3IgImdvb2RpeCxndDkxMTAiCiAJCQkJIG9yICJnb29k
aXgsZ3Q5MTIiCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC5j
IGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9nb29kaXguYwppbmRleCBmMmQ5YzJjNDE4ODUu
LjQ3YjFjZWQ0MTU3NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9nb29k
aXguYworKysgYi9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2dvb2RpeC5jCkBAIC0yMTYsNiAr
MjE2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBnb29kaXhfY2hpcF9kYXRhICpnb29kaXhfZ2V0
X2NoaXBfZGF0YSh1MTYgaWQpCiB7CiAJc3dpdGNoIChpZCkgewogCWNhc2UgMTE1MToKKwljYXNl
IDU2ODg6CiAJCXJldHVybiAmZ3QxeF9jaGlwX2RhdGE7CiAKIAljYXNlIDkxMToKQEAgLTk0Miw2
ICs5NDMsNyBAQCBNT0RVTEVfREVWSUNFX1RBQkxFKGFjcGksIGdvb2RpeF9hY3BpX21hdGNoKTsK
ICNpZmRlZiBDT05GSUdfT0YKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGdvb2Rp
eF9vZl9tYXRjaFtdID0gewogCXsgLmNvbXBhdGlibGUgPSAiZ29vZGl4LGd0MTE1MSIgfSwKKwl7
IC5jb21wYXRpYmxlID0gImdvb2RpeCxndDU2ODgiIH0sCiAJeyAuY29tcGF0aWJsZSA9ICJnb29k
aXgsZ3Q5MTEiIH0sCiAJeyAuY29tcGF0aWJsZSA9ICJnb29kaXgsZ3Q5MTEwIiB9LAogCXsgLmNv
bXBhdGlibGUgPSAiZ29vZGl4LGd0OTEyIiB9LAotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

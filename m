Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E393AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41A721873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ce8ThsUs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQISw3iY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41A721873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YSGyVcSyHJvegu9w1TpeMMLKh/OhbR8hc6vgQj0nbJg=; b=Ce8ThsUshdXVSw
	Jx+puYMEN7Cbh0cXEgd0ME62xHuWBWqr1ktLfQdwgPtcBhafwjb3imA7mFc39F0sHd0ne3cfVyUD1
	3jEEbAGNsUARkzt6cRrA58QevyYGlvH/DlnWNm7XuxraW1strf6tIjO7/ch1Lxyo7MWKTyDMDsBSL
	vpSMnb/rN0uZi0RVDMAB5KVKRscYk7cSzaN4raIM5Pnd/vHXbem+ABpjX6CuxVRs/p1fe+ytekHBp
	O00JA6SjD4n126+peQAvhQP82i2DmKj5EvYk5lr/WEeqnJB9dPJDjUFltDndRlc5lGu6IeTYgNyOy
	YetYHKtqEszO9MTOqJhQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZGul-0000uE-W0; Tue, 18 Dec 2018 15:04:08 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZGu8-0000EE-4X
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:03:38 +0000
Received: by mail-pg1-x543.google.com with SMTP id v28so7926270pgk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SNPmZXdeiPat27OKf7lQvtx2gmSw3oL4RvR/cVfcbOo=;
 b=RQISw3iYiD2dHa8oqpEBLZzzHay/RB2beToYv6DQ7GzX95iLHGvbinz53De+M9r/9g
 +K4LuKo2mw/vY/D3QsXubkHyRWAq3pnUQiEy+OfoRan7L2r5FzZVb5z5cB7VrxlyX0dk
 88fHW0WLKwMgOZ7vJArJ1h4Sqej5Oqute2HzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SNPmZXdeiPat27OKf7lQvtx2gmSw3oL4RvR/cVfcbOo=;
 b=qhBr4zpLXpEarpVfEJHUnK2+qbKuNUjbbJZ9StHvcBshMU6hlDitFXLAgGB7Jbhcm5
 WK35vob/rBVKlCooW4z+HwiDvkUVFamP5Bj57b1v3YlTX1IT/iNqbz4APc7WiLTrpV+U
 UveM4ODsd9nhPU3P047xKJbtF/ySXTWiyBqDqPmt8DlSARzw3vGDYI/ZRRyZIxg1fKSD
 MiBOxiedVcQeCziTT1vU2fbjnyEVJKaFXVUm+nEskj5LiPzubTlNHwzklYWD9uD424Bc
 ByTpORsN4Ar6GHfl9XtJGHfd1GQjpMvWBHdDV/azoUJIxJ4gqI6vf3ejnjYYY7afKnJS
 x2+g==
X-Gm-Message-State: AA+aEWZ2QHqY6j/92ed33/pAgFTjZNZXJPWXPWNhmEX8eiZi8nSUHbOg
 oPQcLhwLRBTzczK2qnFFqc+h
X-Google-Smtp-Source: AFSGD/VhZgtTPfsawvWHIIxym/rI4Zq09WgbYG5jZW5UJB7TWWqOiK/7LkjOgfWctAgqwHhHOVakig==
X-Received: by 2002:a63:c904:: with SMTP id o4mr3147216pgg.331.1545145397568; 
 Tue, 18 Dec 2018 07:03:17 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Dec 2018 07:03:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 03/11] ARM: Prepare RDA8810PL SoC
Date: Tue, 18 Dec 2018 20:32:30 +0530
Message-Id: <20181218150238.23010-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_070328_400587_4982B201 
X-CRM114-Status: GOOD (  14.15  )
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
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, afaerber@suse.de,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgoKSW50cm9kdWNlIEFSQ0hf
UkRBIGFuZCBtYWNoLXJkYSBmb3IgUkRBIE1pY3JvIFNvQ3MuCgpTaWduZWQtb2ZmLWJ5OiBBbmRy
ZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6IE1hbml2YW5uYW4g
U2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+CkFja2VkLWJ5OiBB
cm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgotLS0KIGFyY2gvYXJtL0tjb25maWcgICAgICAg
ICAgIHwgMiArKwogYXJjaC9hcm0vTWFrZWZpbGUgICAgICAgICAgfCAxICsKIGFyY2gvYXJtL21h
Y2gtcmRhL0tjb25maWcgIHwgNyArKysrKysrCiBhcmNoL2FybS9tYWNoLXJkYS9NYWtlZmlsZSB8
IDEgKwogNCBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2
NDQgYXJjaC9hcm0vbWFjaC1yZGEvS2NvbmZpZwogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJt
L21hY2gtcmRhL01ha2VmaWxlCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vS2NvbmZpZyBiL2FyY2gv
YXJtL0tjb25maWcKaW5kZXggOTFiZTc0ZDhkZjY1Li4wODRmMDk4M2U2YjIgMTAwNjQ0Ci0tLSBh
L2FyY2gvYXJtL0tjb25maWcKKysrIGIvYXJjaC9hcm0vS2NvbmZpZwpAQCAtODA0LDYgKzgwNCw4
IEBAIHNvdXJjZSAiYXJjaC9hcm0vcGxhdC1weGEvS2NvbmZpZyIKIAogc291cmNlICJhcmNoL2Fy
bS9tYWNoLXFjb20vS2NvbmZpZyIKIAorc291cmNlICJhcmNoL2FybS9tYWNoLXJkYS9LY29uZmln
IgorCiBzb3VyY2UgImFyY2gvYXJtL21hY2gtcmVhbHZpZXcvS2NvbmZpZyIKIAogc291cmNlICJh
cmNoL2FybS9tYWNoLXJvY2tjaGlwL0tjb25maWciCmRpZmYgLS1naXQgYS9hcmNoL2FybS9NYWtl
ZmlsZSBiL2FyY2gvYXJtL01ha2VmaWxlCmluZGV4IDA1YTkxZDhiODlmMy4uMTAwNTZjY2RiOGJl
IDEwMDY0NAotLS0gYS9hcmNoL2FybS9NYWtlZmlsZQorKysgYi9hcmNoL2FybS9NYWtlZmlsZQpA
QCAtMjAyLDYgKzIwMiw3IEBAIG1hY2hpbmUtJChDT05GSUdfQVJDSF9PUklPTjVYKQkJKz0gb3Jp
b241eAogbWFjaGluZS0kKENPTkZJR19BUkNIX1BJQ09YQ0VMTCkJKz0gcGljb3hjZWxsCiBtYWNo
aW5lLSQoQ09ORklHX0FSQ0hfUFhBKQkJKz0gcHhhCiBtYWNoaW5lLSQoQ09ORklHX0FSQ0hfUUNP
TSkJCSs9IHFjb20KK21hY2hpbmUtJChDT05GSUdfQVJDSF9SREEpCQkrPSByZGEKIG1hY2hpbmUt
JChDT05GSUdfQVJDSF9SRUFMVklFVykJCSs9IHJlYWx2aWV3CiBtYWNoaW5lLSQoQ09ORklHX0FS
Q0hfUk9DS0NISVApCQkrPSByb2NrY2hpcAogbWFjaGluZS0kKENPTkZJR19BUkNIX1JQQykJCSs9
IHJwYwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1yZGEvS2NvbmZpZyBiL2FyY2gvYXJtL21h
Y2gtcmRhL0tjb25maWcKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAwLi40
ZGY4YjhlZTFhOWQKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL2FybS9tYWNoLXJkYS9LY29uZmln
CkBAIC0wLDAgKzEsNyBAQAorbWVudWNvbmZpZyBBUkNIX1JEQQorCWJvb2wgIlJEQSBNaWNybyBT
b0NzIgorCWRlcGVuZHMgb24gQVJDSF9NVUxUSV9WNworCXNlbGVjdCBSREFfSU5UQworCXNlbGVj
dCBSREFfVElNRVIKKwloZWxwCisJICBUaGlzIGVuYWJsZXMgc3VwcG9ydCBmb3IgdGhlIFJEQSBN
aWNybyA4ODEwUEwgU29DIGZhbWlseS4KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcmRhL01h
a2VmaWxlIGIvYXJjaC9hcm0vbWFjaC1yZGEvTWFrZWZpbGUKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
aW5kZXggMDAwMDAwMDAwMDAwLi42YmVhM2QzYTJkZDcKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNo
L2FybS9tYWNoLXJkYS9NYWtlZmlsZQpAQCAtMCwwICsxIEBACitvYmotICs9IGR1bW15Lm8KLS0g
CjIuMTcuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK

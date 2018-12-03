Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040ADC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6AD320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kodsq0S2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AD320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LjHlAq1VSJ/KRJjD48XF9hm/Do7uvrillitgsSwz9DE=; b=kodsq0S2bey3Zv
	WKgPeVsAsh9NQTV9FGYLOTRckM746X/arnuTvUfYbKqerrGGWdhPDYVQZwN5UDQlVQR0tB2409r4P
	/Q9ojrlVxCRgKB4atR9/eLESEgmV5cMleMsRyJ09fg3LSbTMkX/79Ci5t/zVOm2bQ8yCW8/qN1C+2
	FcEDPcQT0TutwybyiiZTyk57ibjYABWXsbh2WCHtbMsxFxoH1s2nWhITvhljfUM592C52ScBg9VRa
	mu1/INC8t/Yy5GY4Lgtey/bcJf6BbwRH6TAN61NbaewrOpxJUtyBDwBg/uneWPJY8MJjUHz1sOHnq
	+nGmhex+XCLs9OmcUYlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvsU-0006Dh-8I; Mon, 03 Dec 2018 21:35:42 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvph-00022m-4S
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 21:33:00 +0000
Received: by mail-ot1-f67.google.com with SMTP id u16so13120875otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 13:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fzihti73hKbmmJj389IERxLXU8bEWQPykR3QHUcAyXE=;
 b=UJxyBnZqizamqPGZ1p5ouI/AXc2F0gBjMsEWClh8mKrQCpye5ft00ucWTCy6HharjW
 r8z4L1r2/D6ekvN/K9sMjI517PYZChcrVxtW8XmS/0FpnJy9KvF/rgkyX8CAh2tvOT8E
 Tfs/2mMS25UE6P2Ukw/R/5xyLUKpRwPKCCdVAUSed6SUL7tBlGNFkIqFRv0fNSm1uUR4
 mw5GJNLZDCqhyjcoGpnUyb7ydrqySnm9/XeL2clARlh00kb+ynhx0Nl8poP/wJkI1dkw
 AL721ysqVafRKRUFCSZsqZedUfYl3D6YGjN6yBqW60Ay9sCjGJtMW4NZXXiGmLnuhVrF
 LtHg==
X-Gm-Message-State: AA+aEWbp4bJbqwI6bUdYo4HIXHsMMMfo166kGF/xxSeXLtRxlmXElB6U
 IxWpS3A4eIB4xOfCKJqaRg==
X-Google-Smtp-Source: AFSGD/W3VkST+YpK8l89kosRsB/Jx0BIl4Ln4graJWqTZKltf+DvjeoVagLbD7o1NTXUWuTn6VUyGA==
X-Received: by 2002:a9d:694a:: with SMTP id p10mr12005275oto.44.1543872757948; 
 Mon, 03 Dec 2018 13:32:37 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id c78sm8545501oig.30.2018.12.03.13.32.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 13:32:37 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/34] dt-bindings: arm: Convert Actions Semi bindings to
 jsonschema
Date: Mon,  3 Dec 2018 15:31:59 -0600
Message-Id: <20181203213223.16986-11-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203213223.16986-1-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_133249_630466_CCC1040B 
X-CRM114-Status: GOOD (  14.43  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <kumar.gala@linaro.org>,
 arm@kernel.org, Sean Hudson <darknighte@darknighte.com>,
 Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@arm.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Q29udmVydCBBY3Rpb25zIFNlbWkgU29DIGJpbmRpbmdzIHRvIERUIHNjaGVtYSBmb3JtYXQgdXNp
bmcganNvbi1zY2hlbWEuCgpDYzogIkFuZHJlYXMgRsOkcmJlciIgPGFmYWVyYmVyQHN1c2UuZGU+
CkNjOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8u
b3JnPgpDYzogTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4KQ2M6IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcKU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KLS0tCiAuLi4v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYWN0aW9ucy50eHQgICAgICAgfCA1NiAtLS0tLS0tLS0t
LS0tLS0tLS0tCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYWN0aW9ucy55YW1sICAgICAg
fCAzOCArKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDU2
IGRlbGV0aW9ucygtKQogZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vYWN0aW9ucy50eHQKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FjdGlvbnMueWFtbAoKZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYWN0aW9ucy50eHQgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FjdGlvbnMudHh0CmRlbGV0ZWQgZmlsZSBt
b2RlIDEwMDY0NAppbmRleCBkNTRmMzNjNGUwZGEuLjAwMDAwMDAwMDAwMAotLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FjdGlvbnMudHh0CisrKyAvZGV2L251bGwK
QEAgLTEsNTYgKzAsMCBAQAotQWN0aW9ucyBTZW1pIHBsYXRmb3JtcyBkZXZpY2UgdHJlZSBiaW5k
aW5ncwotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQotCi0KLVM1
MDAgU29DCi09PT09PT09PQotCi1SZXF1aXJlZCByb290IG5vZGUgcHJvcGVydGllczoKLQotIC0g
Y29tcGF0aWJsZSA6ICBtdXN0IGNvbnRhaW4gImFjdGlvbnMsczUwMCIKLQotCi1Nb2R1bGVzOgot
Ci1Sb290IG5vZGUgcHJvcGVydHkgY29tcGF0aWJsZSBtdXN0IGNvbnRhaW4sIGRlcGVuZGluZyBv
biBtb2R1bGU6Ci0KLSAtIExlTWFrZXIgR3VpdGFyOiAibGVtYWtlcixndWl0YXIiCi0KLQotQm9h
cmRzOgotCi1Sb290IG5vZGUgcHJvcGVydHkgY29tcGF0aWJsZSBtdXN0IGNvbnRhaW4sIGRlcGVu
ZGluZyBvbiBib2FyZDoKLQotIC0gQWxsby5jb20gU3Bhcmt5OiAiYWxsbyxzcGFya3kiCi0gLSBD
dWJpZXRlY2ggQ3ViaWVCb2FyZDY6ICJjdWJpZXRlY2gsY3ViaWVib2FyZDYiCi0gLSBMZU1ha2Vy
IEd1aXRhciBCYXNlIEJvYXJkIHJldi4gQjogImxlbWFrZXIsZ3VpdGFyLWJiLXJldi1iIiwgImxl
bWFrZXIsZ3VpdGFyIgotCi0KLVM3MDAgU29DCi09PT09PT09PQotCi1SZXF1aXJlZCByb290IG5v
ZGUgcHJvcGVydGllczoKLQotLSBjb21wYXRpYmxlIDogIG11c3QgY29udGFpbiAiYWN0aW9ucyxz
NzAwIgotCi0KLUJvYXJkczoKLQotUm9vdCBub2RlIHByb3BlcnR5IGNvbXBhdGlibGUgbXVzdCBj
b250YWluLCBkZXBlbmRpbmcgb24gYm9hcmQ6Ci0KLSAtIEN1YmlldGVjaCBDdWJpZUJvYXJkNzog
ImN1YmlldGVjaCxjdWJpZWJvYXJkNyIKLQotCi1TOTAwIFNvQwotPT09PT09PT0KLQotUmVxdWly
ZWQgcm9vdCBub2RlIHByb3BlcnRpZXM6Ci0KLS0gY29tcGF0aWJsZSA6ICBtdXN0IGNvbnRhaW4g
ImFjdGlvbnMsczkwMCIKLQotCi1Cb2FyZHM6Ci0KLVJvb3Qgbm9kZSBwcm9wZXJ0eSBjb21wYXRp
YmxlIG11c3QgY29udGFpbiwgZGVwZW5kaW5nIG9uIGJvYXJkOgotCi0gLSB1Q1JvYm90aWNzIEJ1
YmJsZWd1bS05NjogInVjcm9ib3RpY3MsYnViYmxlZ3VtLTk2IgpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hY3Rpb25zLnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FjdGlvbnMueWFtbApuZXcgZmlsZSBtb2RlIDEw
MDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjYwYWJkMzcxZTQ3NAotLS0gL2Rldi9udWxsCisrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYWN0aW9ucy55YW1sCkBAIC0w
LDAgKzEsMzggQEAKKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKKyVZQU1MIDEu
MgorLS0tCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2FybS9hY3Rpb25zLnlh
bWwjCiskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFt
bCMKKwordGl0bGU6IEFjdGlvbnMgU2VtaSBwbGF0Zm9ybXMgZGV2aWNlIHRyZWUgYmluZGluZ3MK
KworbWFpbnRhaW5lcnM6CisgIC0gQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPgor
ICAtIE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5v
cmc+CisKK3Byb3BlcnRpZXM6CisgIGNvbXBhdGlibGU6CisgICAgb25lT2Y6CisgICAgICAjIFRo
ZSBBY3Rpb25zIFNlbWkgUzUwMCBpcyBhIHF1YWQtY29yZSBBUk0gQ29ydGV4LUE5IFNvQy4KKyAg
ICAgIC0gaXRlbXM6CisgICAgICAgICAgLSBlbnVtOgorICAgICAgICAgICAgICAtIGFsbG8sc3Bh
cmt5ICMgQWxsby5jb20gU3Bhcmt5CisgICAgICAgICAgICAgIC0gY3ViaWV0ZWNoLGN1YmllYm9h
cmQ2ICMgQ3ViaWV0ZWNoIEN1YmllQm9hcmQ2CisgICAgICAgICAgLSBjb25zdDogYWN0aW9ucyxz
NTAwCisgICAgICAtIGl0ZW1zOgorICAgICAgICAgIC0gZW51bToKKyAgICAgICAgICAgICAgLSBs
ZW1ha2VyLGd1aXRhci1iYi1yZXYtYiAjIExlTWFrZXIgR3VpdGFyIEJhc2UgQm9hcmQgcmV2LiBC
CisgICAgICAgICAgLSBjb25zdDogbGVtYWtlcixndWl0YXIKKyAgICAgICAgICAtIGNvbnN0OiBh
Y3Rpb25zLHM1MDAKKworICAgICAgIyBUaGUgQWN0aW9ucyBTZW1pIFM3MDAgaXMgYSBxdWFkLWNv
cmUgQVJNIENvcnRleC1BNTMgU29DLgorICAgICAgLSBpdGVtczoKKyAgICAgICAgICAtIGVudW06
CisgICAgICAgICAgICAgIC0gY3ViaWV0ZWNoLGN1YmllYm9hcmQ3ICMgQ3ViaWV0ZWNoIEN1Ymll
Qm9hcmQ3CisgICAgICAgICAgLSBjb25zdDogYWN0aW9ucyxzNzAwCisKKyAgICAgICMgVGhlIEFj
dGlvbnMgU2VtaSBTOTAwIGlzIGEgcXVhZC1jb3JlIEFSTSBDb3J0ZXgtQTUzIFNvQy4KKyAgICAg
IC0gaXRlbXM6CisgICAgICAgICAgLSBlbnVtOgorICAgICAgICAgICAgICAtIHVjcm9ib3RpY3Ms
YnViYmxlZ3VtLTk2ICMgdUNSb2JvdGljcyBCdWJibGVndW0tOTYKKyAgICAgICAgICAtIGNvbnN0
OiBhY3Rpb25zLHM5MDAKLS0gCjIuMTkuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

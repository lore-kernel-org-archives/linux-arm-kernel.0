Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12680C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB3721841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TSkYvhCm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3Ytmy/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB3721841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9uFE8TkP5Wep3Yw2i9AedZsfFAz2pWwdMH2fRST5xP0=; b=TSkYvhCme0a0my
	97N/UP29xb0qFRT48L/di6BiggeAJT6kJOPR1vU5WXg1dfmhTMoYckL+asmrXEqrqIzsWZr0x7OUU
	C+9gS9O+G5pWlOj8ltveUBdYnF0xevI2eCZGVt34AVHQy7LkJsuoLKKY1XgTEb+wzg5w/JwqzthAf
	7uCNDPgSR7RO6OKBtSPBqA+qTqmVvKQPmH6cDCdhZzcnfkvSV0CcHrdbTYz802GGMcztlU2tQjkqS
	EajsTxnQxS3A+ysUf1RM6XB9CUjXk1/Qr0EjYBRYEMi+kkXQNqNW92ok864KekR8cNQozZZxEWeJ2
	/I3iskJy7Xo1bTP1Gsuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ6Gt-0006SF-BH; Tue, 18 Dec 2018 03:42:15 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ6Gp-0006Qz-6X
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 03:42:13 +0000
Received: by mail-pf1-x441.google.com with SMTP id c123so7442544pfb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 19:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hs4OFtBvTEICsxyk99pvT2Zl5zpLIGiZC2HOUjEKzsA=;
 b=f3Ytmy/LDGeCLbrL9sdHmR5darDWzsw8l4fZqkocXJ4Pxmpr267zHcK6w/taFkCvQj
 PVolR1lvpHQU8pJswlx6b0e7q1/FKul6SDXRNSaDkj37GfWCfiitiCR4pkjYrIBSS/Hu
 RSgqZYNSfendmgFKrktZ8QekMVBokp5mJ549o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hs4OFtBvTEICsxyk99pvT2Zl5zpLIGiZC2HOUjEKzsA=;
 b=i9Su367rDo6ir91lSUCbDYHBYfr4QarSFNaPpq6gKM0zzVcDjoESq2uMd+RZr8X7/C
 UedSZd9NXjFSrfsXQ+4Nm501vNLjnFBdL3oP4fomEvpetfz/DjTVCGIGGTiOEXenzm/x
 1hree29sc0PUxI8bOU5Kcr1WbPGO3/YPc0QQdDq4K/UcFy8zzwBQMYDni3Iw3sgTT7RI
 Yv69oPobzZl1RZcSMyuOYhNbTqQwsfKLcGvlgptTVdmF2mbjeXZw9HlcETljOhG95Gdg
 YyCm7dp+IeTN6Xd8DlxZ6sFMeVZSGpe3nDVvBdlYQBaGMedOahSoiBPtiq4bQaHNLVQh
 Hsmg==
X-Gm-Message-State: AA+aEWajcohrCfcjtND6sJGKZXTcP7QZ4aXpDyTcTajNwF6pau7MKJly
 58setjigk5dferAPBQ3RcsU+
X-Google-Smtp-Source: AFSGD/VOwnxWXLoTmh722zFsIUvGzjAyDv3btMDEuGDp0Ed03798aQ+q+1Gi08Xi/fKPHgo5qXNNbQ==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr14259363pgl.186.1545104519695; 
 Mon, 17 Dec 2018 19:41:59 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
 by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.41.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Dec 2018 19:41:58 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
 gregkh@linuxfoundation.org, jslaby@suse.com
Subject: [PATCH v5 00/11] Add initial RDA8810PL SoC and Orange Pi boards
 support
Date: Tue, 18 Dec 2018 09:11:21 +0530
Message-Id: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_194211_243590_1DB9043A 
X-CRM114-Status: GOOD (  15.07  )
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
Cc: devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, linux-serial@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org, zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGVsbG8sCgpUaGlzIHBhdGNoc2V0IGFkZHMgaW5pdGlhbCBSREE4ODEwUEwgU29DIGFuZCBPcmFu
Z2UgUGkgYm9hcmRzICgyRyBJb1QgYW5kCmk5Nikgc3VwcG9ydC4gUkRBODgxMFBMIGlzIGFuIEFS
TSBDb3J0ZXggQTUgYmFzZWQgU29DIHdpdGggVml2YW50ZSdzIEdDODYwCkdQVS4gVGhlIFNvQyBo
YXMgYmVlbiBhZGRlZCBhcyBhIG5ldyBBUk0gc3ViIGFyY2hpdGVjdHVyZSB3aXRoIG15c2VsZgph
bmQgQW5kcmVhcyBhcyB0aGUgbWFpbnRhaW5lcnMuCgpNb3JlIGluZm9ybWF0aW9uIGFib3V0IHRo
ZSBib2FyZHMgY2FuIGJlIGZvdW5kIGluIGJlbG93IGxpbmtzOgoKMS4gT3JhbmdlIFBpIDJHLUlv
VCAtIGh0dHA6Ly93d3cub3JhbmdlcGkub3JnL09yYW5nZVBpMkdJT1QvCjIuIE9yYW5nZSBQaSBp
OTYgLSBodHRwczovL3d3dy45NmJvYXJkcy5vcmcvcHJvZHVjdC9vcmFuZ2VwaS1pOTYvCgpUaGlz
IHBhdGNoc2V0IGlzIGJhc2VkIG9uIHRoZSBpbml0aWFsIHJldmlzaW9uIHNlbnQgb3V0IGJ5IEFu
ZHJlYXMgbG9uZwpiYWNrIChodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGlu
dXgtYXJtLWtlcm5lbC8yMDE3LUp1bmUvNTE1OTUxLmh0bWwpLgoKSSBoYXZlIGV4dGVuZGVkIGhp
cyBwYXRjaHNldCB3aXRoIHByb3BlciBpcnFjaGlwIGFuZCBVQVJUIGRyaXZlcnMuIE5vdywKYm9h
cmRzIGNhbiBib290IGludG8gaW5pdHJhbWZzIHdpdGggY29uc29sZSBhdCBVQVJUMi4KClRoYW5r
cywKTWFuaQoKQ2hhbmdlcyBpbiB2NToKCiogRHJvcHBlZCB0aW1lciBhbmQgaXJxY2hpcCBwYXRj
aGVzIHNpbmNlIHRoZXkgZ290IGFwcGxpZWQKKiBEcm9wcGVkIEFuZHJlYXMgZnJvbSBNQUlOVEFJ
TkVSUyBhcyBwZXIgaGlzIHJlcXVlc3QKCkNoYW5nZXMgaW4gdjQ6CgoqIEFkZGVkIFJvYidzIFJl
dmlld2VkLWJ5IHRhZ3MgZm9yIHZlbmRvciBhbmQgU29DIHBhdGNoZXMuCiogTW92ZWQgcGxhdGZv
cm0gS2NvbmZpZyBjaGFuZ2VzIGZyb20gdGltZXIgYW5kIGlycWNoaXAgZHJpdmVycyB0bwogIFNv
QyBzdXBwb3J0IHBhdGNoLgoqIEFkZGVkIE1hcmMncyBSZXZpZXdlZC1ieSB0YWcgZm9yIGlycWNo
aXAgZHJpdmVyLgoqIEFkZHJlc3NlZCBSb2IncyByZXZpZXcgY29tbWVudHMgZm9yIGJpbmRpbmdz
IHBhdGNoZXMuCiogQWRkZWQgdGhlIG5ld2x5IGNyZWF0ZWQgbGludXgtdW5pc29jIG1haWxpbmcg
bGlzdCB0byBNQUlOVEFJTkVSUwogIGVudHJ5LgoqIERyb3BwZWQgb3ZlcnNlYXMuc2FsZXNAdW5p
c29jLmNvbSBtYWlsIGFkZHJlc3MgYXMgaXQgaXMgYm91bmNpbmcgYmFjay4KKiBNb2RpZmllZCB0
aGUgRFRTIHN1YmplY3QgcHJlZml4IHRvIEFSTTogZnJvbSBhcm06CgpDaGFuZ2VzIGluIHYzOgoK
QXMgcGVyIE1hcmMncyByZXZpZXc6CgoqIFJlbW92ZWQgdW51c2VkIGhlYWRlciBhbmQgZGVmaW5l
cyBmcm9tIGlycWNoaXAgZHJpdmVyLgoqIFJlbW92ZWQgc2V0dGluZyBmbG93IGhhbmRsZXJzIGZy
b20gc2V0X3R5cGUgY2FsbGJhY2suCiogTWlub3IgY29kZSBjbGVhbnVwcy4KCkFzIHBlciBBcm5k
J3MgcmV2aWV3OgoKKiBNb2RpZmllZCB0aGUgVUFSVCBpbmRleGVzIHRvIHN0YXJ0IGZyb20gMSB0
byBtYXRjaCB0aGUgU29DIG51bWJlcmluZwoqIEVuYWJsZWQgZXhwb3NlZCBVQVJUcyAoYWxsIDMg
b24gYm90aCBib2FyZHMpCiogTW9kaWZpZWQgdGhlIHNlcmlhbCBhbGlhc2VzIGFzIHBlciBib2Fy
ZCBudW1iZXJpbmcKCiogQWRkZWQgR3JlZydzIFJldmlld2VkLWJ5IHRhZyBmb3Igc2VyaWFsIGRy
aXZlci4KCkNoYW5nZXMgaW4gdjI6CgoqIFVzZWQgcmVhZGwvd3JpdGVsX3JlbGF4ZWQgY2FsbHMg
Zm9yIGJvdGggaXJxY2hpcCBhbmQgdGltZXIgZHJpdmVycyBhcwogIHBlciBNYXJjJ3MgcmV2aWV3
LgoqIEltcGxlbWVudGVkIHRoZSBsb2dpYyB0byBwcmV2ZW50IGNvdW50ZXIgd3JhcHBpbmcgZHVy
aW5nIHJlYWQgYXMKICBzdWdnZXN0ZWQgYnkgTWFyYy4KKiBVc2VkIHRoZSB0aW1lci1vZiBBUEkg
YXMgcGVyIERhbmllbCdzIHN1Z2dlc3Rpb24uCiogQWRkZWQgZGVzY3JpcHRpb24gYWJvdXQgdGhl
IHRpbWVyIGluIGJvdGggY29tbWl0IGxvZyBhbmQgZHJpdmVyLgoqIENoYW5nZWQgdGhlIFZlbmRv
ciBuYW1lIGZvciBSREEgdG8gVW5pc29jIENvbW11bmljYXRpb25zIEluYy4KKiBSZW1vdmVkIHRo
ZSBzb2Mgbm9kZSBsZXZlbCBhbmQgY2xlYW5lZCB1cCBkZXZpY2V0cmVlcyBhcyBwZXIgUm9iJ3MK
ICByZXZpZXcuCiogTWVyZ2VkIGludGVycnVwdCBjb250cm9sbGVyIERUIHBhdGNoIHRvIFNvQy4K
KiBNb3ZlZCBhbGlhc2VzIHRvIGJvYXJkIGR0cyBhcyBwZXIgQXJuZCdzIHN1Z2dlc3Rpb24uCiog
UmVtb3ZlZCBSREEgTWljcm8gc3VwcG9ydCBtYWlsIGFkZHJlc3MgYW5kIHVzZWQgVW5pc29jIG9u
ZSBhbmQgYWRkZWQKICBteSBtaXNzaW5nIHNpZ25lZCBvZmYgYnkgdGFnIGFzIHBlciBBbmRyZWFz
J3MgY29tbWVudHMuCgpBbmRyZWFzIEbDpHJiZXIgKDQpOgogIGR0LWJpbmRpbmdzOiBBZGQgUkRB
IE1pY3JvIHZlbmRvciBwcmVmaXgKICBkdC1iaW5kaW5nczogYXJtOiBEb2N1bWVudCBSREE4ODEw
UEwgYW5kIHJlZmVyZW5jZSBib2FyZHMKICBBUk06IFByZXBhcmUgUkRBODgxMFBMIFNvQwogIGR0
LWJpbmRpbmdzOiBzZXJpYWw6IERvY3VtZW50IFJEQSBNaWNybyBVQVJUCgpNYW5pdmFubmFuIFNh
ZGhhc2l2YW0gKDcpOgogIEFSTTogZHRzOiBBZGQgZGV2aWNldHJlZSBmb3IgUkRBODgxMFBMIFNv
QwogIEFSTTogZHRzOiBBZGQgZGV2aWNldHJlZSBmb3IgT3JhbmdlUGkgMkcgSW9UIGJvYXJkCiAg
QVJNOiBkdHM6IEFkZCBkZXZpY2V0cmVlIGZvciBPcmFuZ2VQaSBpOTYgYm9hcmQKICBBUk06IGR0
czogcmRhODgxMHBsOiBBZGQgdGltZXIgc3VwcG9ydAogIEFSTTogZHRzOiByZGE4ODEwcGw6IEFk
ZCBpbnRlcnJ1cHQgc3VwcG9ydCBmb3IgVUFSVAogIHR0eTogc2VyaWFsOiBBZGQgUkRBODgxMFBM
IFVBUlQgZHJpdmVyCiAgTUFJTlRBSU5FUlM6IEFkZCBlbnRyeSBmb3IgUkRBIE1pY3JvIFNvQyBh
cmNoaXRlY3R1cmUKCiAuLi4vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0ICAgICAg
ICAgfCAgIDYgKwogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZGEudHh0
IHwgIDE3ICsKIC4uLi9iaW5kaW5ncy9zZXJpYWwvcmRhLDg4MTBwbC11YXJ0LnR4dCAgICAgICB8
ICAxNyArCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0ICAgfCAg
IDEgKwogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE0
ICsKIGFyY2gvYXJtL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiAr
CiBhcmNoL2FybS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwog
YXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgICAzICsKIC4u
Li9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGktMmctaW90LmR0cyAgICB8ICA1MCArKwogYXJj
aC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLW9yYW5nZXBpLWk5Ni5kdHMgIHwgIDUwICsrCiBhcmNo
L2FybS9ib290L2R0cy9yZGE4ODEwcGwuZHRzaSAgICAgICAgICAgICAgfCAgOTkgKysrCiBhcmNo
L2FybS9tYWNoLXJkYS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKwogYXJjaC9h
cm0vbWFjaC1yZGEvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIGRyaXZlcnMv
dHR5L3NlcmlhbC9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAxOSArCiBkcml2ZXJzL3R0
eS9zZXJpYWwvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogZHJpdmVycy90dHkv
c2VyaWFsL3JkYS11YXJ0LmMgICAgICAgICAgICAgICAgIHwgODMxICsrKysrKysrKysrKysrKysr
KwogaW5jbHVkZS91YXBpL2xpbnV4L3NlcmlhbF9jb3JlLmggICAgICAgICAgICAgIHwgICAzICsK
IDE3IGZpbGVzIGNoYW5nZWQsIDExMjQgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vcmRhLnR4dAogY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcmRhLDg4
MTBwbC11YXJ0LnR4dAogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL3JkYTg4
MTBwbC1vcmFuZ2VwaS0yZy1pb3QuZHRzCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9v
dC9kdHMvcmRhODgxMHBsLW9yYW5nZXBpLWk5Ni5kdHMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNo
L2FybS9ib290L2R0cy9yZGE4ODEwcGwuZHRzaQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJt
L21hY2gtcmRhL0tjb25maWcKIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLXJkYS9N
YWtlZmlsZQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdHR5L3NlcmlhbC9yZGEtdWFydC5j
CgotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=

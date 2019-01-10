Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C212DC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:41:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937922173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ARouPPk3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+FGocRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937922173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ttt0vX54L3D+FEPsIxR+ErLnYxwiFpKQnl5biylkCpA=; b=ARouPPk3hj35Y0
	P17yOWmq24WfuwgoBgAXYJ2mYnxU3m7B187lRRcNDKbIp9G9JaKmeqkWzjlxOsK0iskIdM7cvjzw+
	lvHNToyTyTDY4oR+VAroDN2YNxBczdtzSZGwy0zoPx9QVtqjFokQ7p2uPnnPQuGiThON31VJV5rYY
	O8F9f+DSwAwL5fV5WbotHBHp6V2tBJBsr/oXxx2sDGmq9Rd0Jn1Jhas/IG8VdX5DTrjThBXIdBpfK
	iHPmFBafzzGZp/2LEWmmUvV5w4y6+BJg5j7hSkCnUy7OIZCQeCwhVyksAI8X/xu3wh7rnCExjjhu2
	n3Gi9CT92liCHwaTzOYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghYhn-0004cI-BW; Thu, 10 Jan 2019 11:40:59 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghYhj-0004bs-U4
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 11:40:57 +0000
Received: by mail-lf1-x141.google.com with SMTP id c16so8055308lfj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 03:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IlDK8bGb/kRNe1UzuHHE+g8wvOU0YDJW7WMbCLP2uh0=;
 b=d+FGocRvhsD+gmzQW8HEJEv1gnpLdpOeJZQW4JLualBkev6vkye2YieO0ftmo4S1LZ
 3NaeHEdVLiJ1F64qJQck7pL3MLX+mGPONC/cenzjYeQ4CMWPFL3ttvi0AwA2zPNpKhqn
 mgkPMjQvNAOD/rbvU4fNNritrslBMOTMzyWEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IlDK8bGb/kRNe1UzuHHE+g8wvOU0YDJW7WMbCLP2uh0=;
 b=NtP2d75ffbgTMQT2ey6Wk+yndlamLp/WxI8995cdQ+uhStNNZQnu3jHB3tErX/g7rJ
 Zn5UVI9JIbuEWEEKvDJ4NOQZ9NpEcR0aODPz3bJ61yMLv9Zft6rEWS4RGBmwY8gy+8Gc
 E3nvB3Q4mxasPmwFGqtk1iq/nLXLrnTl3zMS9g5u5rCdbW70OoJ5QxizE0lYzpdVlqZy
 3tmx0ZfPuOj4e2BnIVdY440Yz/U+hG3pEikMps3LiU0b4LHTpPLTWfphTDZ/zdvlcDOf
 6f6cp9oGfWn1EoshENTjaqbWCHFs4fg4j50F/ohViGG2bkoBTMAQiPo3HSaW8ptFxMMB
 iIWw==
X-Gm-Message-State: AJcUukdV073NZHdHjgQuohTsiyw4zw7s+5hdGcpqFL8XodT1ZszkYVtx
 WWuAMuX8ObKpVv3Yv05+zG0MaQ==
X-Google-Smtp-Source: ALg8bN58DACMjpRLx0nlXmAzkCQGoq7jXWdIzihg1A6aHe/BaExdkcz8HtWDy7/yZltzh50HnH3i3w==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr5974222lfb.140.1547120453263; 
 Thu, 10 Jan 2019 03:40:53 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id k20sm7573177lfe.3.2019.01.10.03.40.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 03:40:52 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Eric Anholt <eric@anholt.net>,
 =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
 Dave Airlie <airlied@redhat.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v4] drm/fb-helper: Scale back depth to supported maximum
Date: Thu, 10 Jan 2019 12:40:49 +0100
Message-Id: <20190110114049.10618-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_034055_973453_EC9DA244 
X-CRM114-Status: GOOD (  21.60  )
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
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGZvbGxvd2luZyBoYXBwZW5lZCB3aGVuIG1pZ3JhdGluZyBhbiBvbGQgZmJkZXYgZHJpdmVy
IHRvIERSTToKClRoZSBJbnRlZ3JhdG9yL0NQIFBMMTExIHN1cHBvcnRzIDE2QlBQIGJ1dCBvbmx5
IEFSR0IxNTU1L0FCR1IxNTU1Cm9yIFhSR0IxNTU1L1hCR1IxNTU1IGkuZS4gdGhlIG1heGltdW0g
ZGVwdGggaXMgMTUuCgpUaGlzIG1ha2VzIHRoZSBpbml0aWFsaXphdGlvbiBvZiB0aGUgZnJhbWVi
dWZmZXIgZmFpbCBzaW5jZQp0aGUgY29kZSBpbiBkcm1fZmJfaGVscGVyX3NpbmdsZV9mYl9wcm9i
ZSgpIGFzc2lnbnMgdGhlIHNhbWUgdmFsdWUKdG8gc2l6ZXMuc3VyZmFjZV9icHAgYW5kIHNpemVz
LnN1cmZhY2VfZGVwdGguIEkuZS4gaXQgc2ltcGx5IGFzc3VtZXMKYSAxLXRvLTEgbWFwcGluZyBi
ZXR3ZWVuIEJQUCBhbmQgZGVwdGgsIHdoaWNoIGlzIHRydWUgaW4gbW9zdCBjYXNlcwpidXQgbm90
IGZvciB0aGlzIGhhcmR3YXJlIHRoYXQgb25seSBzdXBwb3J0IG9kZCBmb3JtYXRzLgoKVG8gc3Vw
cG9ydCB0aGUgb2RkIGNhc2Ugb2YgYSBkcml2ZXIgc3VwcG9ydGluZyAxNkJQUCB3aXRoIG9ubHkg
MTUKYml0cyBvZiBkZXB0aCwgdGhpcyBwYXRjaCB3aWxsIG1ha2UgdGhlIGNvZGUgbG9vcCBvdmVy
IHRoZSBmb3JtYXRzCnN1cHBvcnRlZCBvbiB0aGUgcHJpbWFyeSBwbGFuZSBvbiBlYWNoIENSVEMg
bWFuYWdlZCBieSB0aGUgRkIKaGVscGVyIGFuZCBjYXAgdGhlIGRlcHRoIHRvIHRoZSBtYXhpbXVt
IHN1cHBvcnRlZCBvbiBhbnkgcHJpbWFyeQpwbGFuZS4KCk9uIHRoZSBQTDExMCBJbnRlZ3JhdG9y
LCB0aGlzIG1ha2VzIGRybV9tb2RlX2xlZ2FjeV9mYl9mb3JtYXQoKQpzZWxlY3QgRFJNX0ZPUk1B
VF9YUkdCMTU1NSB3aGljaCBpcyBhY2NlcHRhYmxlIGZvciB0aGlzIGRyaXZlciwgYW5kCnRodXMg
d2UgZ2V0IGZyYW1lYnVmZmVyLCBwZW5ndWluIGFuZCBjb25zb2xlIG9uIHRoZSBJbnRlZ3JhdG9y
L0NQLgoKQ2M6IE5vcmFsZiBUcsO4bm5lcyA8bm9yYWxmQHRyb25uZXMub3JnPgpDYzogVmlsbGUg
U3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KUmV2aWV3ZWQtYnk6IERh
bmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3bGwuY2g+ClNpZ25lZC1vZmYtYnk6IExpbnVz
IFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4KLS0tCkNoYW5nZUxvZyB2My0+djQ6
Ci0gQXNzaWduIGJlc3RfZGVwdGggYWxzbyB3aGVuIHdlIGhhdmUgYSBwZXJmZWN0IGZpdCwgZHVo
LgpDaGFuZ2VMb2cgdjItPnYzOgotIFJlYmFzZWQgYW5kIHRlc3RlZCB3aXRoIHY1LjAtcmMxCi0g
U2tpcCBhbnkgZm9ybWF0cyB3aXRoIGZtdC0+ZGVwdGggPT0gMAotIENvbGxlY3RlZCBEYW5pZWxz
IHJldmlldyB0YWcuCkNoYW5nZUxvZyB2MS0+djI6Ci0gTG9vcCBvdmVyIHRoZSBDUlRDcyBtYW5h
Z2VkIGJ5IHRoZSBoZWxwZXIgYW5kIGNoZWNrIHRoZQogIGNydGMtPnByaW1hcnkgb24gZWFjaCBD
UlRDIGZvciB0aGUgYXBwbGljYWJsZSBmb3JtYXRzIGFuZAogIHRodXMgZGVwdGhzLgotIFNraXAg
b3ZlciBZVVYgZm9ybWF0cy4gVGhlIGZyYW1lYnVmZmVyIGVtdWxhdGlvbiBjYW5ub3QKICBoYW5k
bGUgdGhlc2UgZm9ybWF0cy4KClRoZSB2MSB3YXMgc2VudCBzb21lIHdoaWxlIGJhY2sgaW4gZmVi
cnVhcnkgYW5kIEkgb25seSByZWNlbnRseQpnb3QgYmFjayB0byBmaXhpbmcgdGhpcyB1cCB0byBz
dXBwb3J0IHRoZSBsYXN0IENMQ0QgZGlzcGxheXMuCkl0IHdhcyBhZ3JlZWQgdGhhdCBpdCBpcyBw
cm9iYWJseSBiZXN0IHRvIGF1Z21lbnQgdGhlIGZyYW1lYnVmZmVyCmluaXRpYWxpemVyIHRvIHBh
c3MgYSBkZXNpcmVkIHBpeGVsIGZvcm1hdCBpbnN0ZWFkIG9mIGp1c3QKQlBQIGFzIHRvZGF5LCBi
dXQgdGhhdCBpcyBhIGJpdCBkYXVudGluZywgYW5kIERhbmllbCBzYWlkIHRoYXQKd2Ugd291bGQg
cHJvYmFibHkgYW55d2F5cyBuZWVkIGEgZmFsbGJhY2sgbGlrZSB0aGlzLgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9kcm1fZmJfaGVscGVyLmMgfCA1NSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9mYl9oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1
L2RybS9kcm1fZmJfaGVscGVyLmMKaW5kZXggZDNhZjA5OGIwOTIyLi5mN2YzMWFkNWQzZWUgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZmJfaGVscGVyLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2RybV9mYl9oZWxwZXIuYwpAQCAtMTc5Nyw2ICsxNzk3LDcgQEAgc3RhdGljIGludCBk
cm1fZmJfaGVscGVyX3NpbmdsZV9mYl9wcm9iZShzdHJ1Y3QgZHJtX2ZiX2hlbHBlciAqZmJfaGVs
cGVyLAogCWludCBpOwogCXN0cnVjdCBkcm1fZmJfaGVscGVyX3N1cmZhY2Vfc2l6ZSBzaXplczsK
IAlpbnQgZ2FtbWFfc2l6ZSA9IDA7CisJaW50IGJlc3RfZGVwdGggPSAwOwogCiAJbWVtc2V0KCZz
aXplcywgMCwgc2l6ZW9mKHN0cnVjdCBkcm1fZmJfaGVscGVyX3N1cmZhY2Vfc2l6ZSkpOwogCXNp
emVzLnN1cmZhY2VfZGVwdGggPSAyNDsKQEAgLTE4MDQsNyArMTgwNSwxMCBAQCBzdGF0aWMgaW50
IGRybV9mYl9oZWxwZXJfc2luZ2xlX2ZiX3Byb2JlKHN0cnVjdCBkcm1fZmJfaGVscGVyICpmYl9o
ZWxwZXIsCiAJc2l6ZXMuZmJfd2lkdGggPSAodTMyKS0xOwogCXNpemVzLmZiX2hlaWdodCA9ICh1
MzIpLTE7CiAKLQkvKiBpZiBkcml2ZXIgcGlja3MgOCBvciAxNiBieSBkZWZhdWx0IHVzZSB0aGF0
IGZvciBib3RoIGRlcHRoL2JwcCAqLworCS8qCisJICogSWYgZHJpdmVyIHBpY2tzIDggb3IgMTYg
YnkgZGVmYXVsdCB1c2UgdGhhdCBmb3IgYm90aCBkZXB0aC9icHAKKwkgKiB0byBiZWdpbiB3aXRo
CisJICovCiAJaWYgKHByZWZlcnJlZF9icHAgIT0gc2l6ZXMuc3VyZmFjZV9icHApCiAJCXNpemVz
LnN1cmZhY2VfZGVwdGggPSBzaXplcy5zdXJmYWNlX2JwcCA9IHByZWZlcnJlZF9icHA7CiAKQEAg
LTE4MzksNiArMTg0Myw1NSBAQCBzdGF0aWMgaW50IGRybV9mYl9oZWxwZXJfc2luZ2xlX2ZiX3By
b2JlKHN0cnVjdCBkcm1fZmJfaGVscGVyICpmYl9oZWxwZXIsCiAJCX0KIAl9CiAKKwkvKgorCSAq
IElmIHdlIHJ1biBpbnRvIGEgc2l0dWF0aW9uIHdoZXJlLCBmb3IgZXhhbXBsZSwgdGhlIHByaW1h
cnkgcGxhbmUKKwkgKiBzdXBwb3J0cyBSR0JBNTU1MSAoMTYgYnBwLCBkZXB0aCAxNSkgYnV0IG5v
dCBSR0I1NjUgKDE2IGJwcCwgZGVwdGgKKwkgKiAxNikgd2UgbmVlZCB0byBzY2FsZSBkb3duIHRo
ZSBkZXB0aCBvZiB0aGUgc2l6ZXMgd2UgcmVxdWVzdC4KKwkgKi8KKwlmb3IgKGkgPSAwOyBpIDwg
ZmJfaGVscGVyLT5jcnRjX2NvdW50OyBpKyspIHsKKwkJc3RydWN0IGRybV9tb2RlX3NldCAqbW9k
ZV9zZXQgPSAmZmJfaGVscGVyLT5jcnRjX2luZm9baV0ubW9kZV9zZXQ7CisJCXN0cnVjdCBkcm1f
Y3J0YyAqY3J0YyA9IG1vZGVfc2V0LT5jcnRjOworCQlzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSA9
IGNydGMtPnByaW1hcnk7CisJCWludCBqOworCisJCURSTV9ERUJVRygidGVzdCBDUlRDICVkIHBy
aW1hcnkgcGxhbmVcbiIsIGkpOworCisJCWZvciAoaiA9IDA7IGogPCBwbGFuZS0+Zm9ybWF0X2Nv
dW50OyBqKyspIHsKKwkJCWNvbnN0IHN0cnVjdCBkcm1fZm9ybWF0X2luZm8gKmZtdDsKKworCQkJ
Zm10ID0gZHJtX2Zvcm1hdF9pbmZvKHBsYW5lLT5mb3JtYXRfdHlwZXNbal0pOworCisJCQkvKgor
CQkJICogRG8gbm90IGNvbnNpZGVyIFlVViBvciBvdGhlciBjb21wbGljYXRlZCBmb3JtYXRzCisJ
CQkgKiBmb3IgZnJhbWVidWZmZXJzLiBUaGlzIG1lYW5zIG9ubHkgbGVnYWN5IGZvcm1hdHMKKwkJ
CSAqIGFyZSBzdXBwb3J0ZWQgKGZtdC0+ZGVwdGggaXMgYSBsZWdhY3kgZmllbGQpIGJ1dAorCQkJ
ICogdGhlIGZyYW1lYnVmZmVyIGVtdWxhdGlvbiBjYW4gb25seSBkZWFsIHdpdGggc3VjaAorCQkJ
ICogZm9ybWF0cywgc3BlY2lmaWNhbGx5IFJHQi9CR0EgZm9ybWF0cy4KKwkJCSAqLworCQkJaWYg
KGZtdC0+ZGVwdGggPT0gMCkKKwkJCQljb250aW51ZTsKKworCQkJLyogV2UgZm91bmQgYSBwZXJm
ZWN0IGZpdCwgZ3JlYXQgKi8KKwkJCWlmIChmbXQtPmRlcHRoID09IHNpemVzLnN1cmZhY2VfZGVw
dGgpIHsKKwkJCQliZXN0X2RlcHRoID0gZm10LT5kZXB0aDsKKwkJCQlicmVhazsKKwkJCX0KKwor
CQkJLyogU2tpcCBkZXB0aHMgYWJvdmUgd2hhdCB3ZSdyZSBsb29raW5nIGZvciAqLworCQkJaWYg
KGZtdC0+ZGVwdGggPiBzaXplcy5zdXJmYWNlX2RlcHRoKQorCQkJCWNvbnRpbnVlOworCisJCQkv
KiBCZXN0IGRlcHRoIGZvdW5kIHNvIGZhciAqLworCQkJaWYgKGZtdC0+ZGVwdGggPiBiZXN0X2Rl
cHRoKQorCQkJCWJlc3RfZGVwdGggPSBmbXQtPmRlcHRoOworCQl9CisJfQorCWlmIChzaXplcy5z
dXJmYWNlX2RlcHRoICE9IGJlc3RfZGVwdGgpIHsKKwkJRFJNX0lORk8oInJlcXVlc3RlZCBicHAg
JWQsIHNjYWxlZCBkZXB0aCBkb3duIHRvICVkIiwKKwkJCSAgc2l6ZXMuc3VyZmFjZV9icHAsIGJl
c3RfZGVwdGgpOworCQlzaXplcy5zdXJmYWNlX2RlcHRoID0gYmVzdF9kZXB0aDsKKwl9CisKIAlj
cnRjX2NvdW50ID0gMDsKIAlmb3IgKGkgPSAwOyBpIDwgZmJfaGVscGVyLT5jcnRjX2NvdW50OyBp
KyspIHsKIAkJc3RydWN0IGRybV9kaXNwbGF5X21vZGUgKmRlc2lyZWRfbW9kZTsKLS0gCjIuMTku
MgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK

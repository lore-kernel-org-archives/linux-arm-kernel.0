Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D74C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:05:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDE3214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CeUepNmU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSiskSSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDE3214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/dWsXt2egB7FZEBIKeybvPnUtn1ZelI/oaaB7vb4B6M=; b=CeUepNmUL6byuG
	csmQHx9jWUsUVrBY1HHp+jN4jsROOQyGJm1dGSJiF8ywIjUVj32EEA8fx0VO0NS94QdCRsC9knKko
	zPa8F9bk49dP6ZXb7Tq0/RU6SA+5BRYdYzoalzbgwPEikfViEkvtBzyok430j4VxP6jLMhEODoIHd
	V58LiIX0FCEvIXKBniq2W9Jj5xB9LSrWhPzTVW6sCx/jnnWPfGEOFe7Phr8rSZ5bHDqJnSoEGuFML
	OkYSBEdWAmeLIwcRRgdLigDqjH6/x1S6dniT9/jHdgyCumU2pOdXqauqXNafjgjxx6uSvBq0m0qpR
	XflitOXII8U09Jux7sdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZeL8-0001E7-Ue; Wed, 19 Dec 2018 16:04:54 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeKs-00010P-Ta
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:04:40 +0000
Received: by mail-lf1-x142.google.com with SMTP id i26so15446466lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZZI8ioWXkc4sq7/+UaHZVn4uYxbM0VQloyZQGuqbwgg=;
 b=JSiskSSCKMdW6SROQWsAN+3PI4AOXKr9SmcP/NJCUlOUJ13ZuYHnccEJQa16U3eRHf
 rN6UIPgmOA+vfs26YoTNj+eLoZCY55M4BVMsot0glgvtKdj2i/b7+qi2oqNZOwEoggkY
 DqbkNX90bI1Q2vHeSUZGhbVSTgcAY7D+VMmjHcKT6ntRlPIGF+T/HlNC8rn32JhK/jls
 dwU7je2wrUvAMXbcIVdhxYMntfFEj2LGn0or0Z8fSSe5H2yiqkszrmvlbq4XelS1f0/g
 grLB7vCyiFAewfzu3/1Fcaau+HD4yd4W7FpihnrBwhrZEnrHoN264E6Wz9AoydQ6xB/C
 SJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZZI8ioWXkc4sq7/+UaHZVn4uYxbM0VQloyZQGuqbwgg=;
 b=DCS26iVIv1w+YFTDa4jq78EafSTnZV52xzAPQJwlE8Ebk0vLCGQBashV8w+02rEQj9
 P8A///cbYA7ILmhrzaVD2v3NFkIDwo+P+4sEyI0ga7xSMzaglmrXbJmfRGl4o7h+Ls4V
 KdnljojI16ImLNuf6qBbtzq5qkKZqhKFat3kLZb9OwBT4enCKed+KrYtycPMZ/LZO7Af
 nHOgJVDg6JhJrNnEQMxqLzrj9ad52CLpEfzYO/v4pDEYj5ybPeEaBqrJrnsEnkBA8mHJ
 ld1C8ZoNNnwZaKz3VICKNuW0QO3YYWgJ91Do0tdrSqPIpCC+xcQiKCKoksWy6LKNpd4S
 4pfA==
X-Gm-Message-State: AA+aEWaaeDYJWVvTcGF75Cy6riJghkgL8ixDM3Y8HxKQttP7ZF5i44pf
 5BxcfW24k7kMQZ8i5uoroNg=
X-Google-Smtp-Source: AFSGD/XvQ2nuSqE4wy/SbLlLNPEkqpARqK5tWnC9Ud8eRUmdV0WeVTBjc0PXOds7iOWSNVOByjIIkw==
X-Received: by 2002:a19:c18d:: with SMTP id r135mr1884611lff.59.1545235466806; 
 Wed, 19 Dec 2018 08:04:26 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:253f:4197:555d:bfba])
 by smtp.googlemail.com with ESMTPSA id i75sm3943979lfb.58.2018.12.19.08.04.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 08:04:26 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: inki.dae@samsung.com,
	krzk@kernel.org,
	airlied@linux.ie
Subject: [PATCH 1/3] drm/exynos: rotator: Add support for s5pv210
Date: Wed, 19 Dec 2018 16:57:02 +0100
Message-Id: <20181219155704.15264-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_080438_954006_3EDAB17D 
X-CRM114-Status: GOOD (  14.28  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh+dt@kernel.org, kyungmin.park@samsung.com,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBjb21taXQgYWRkcyBzdXBwb3J0IGZvciBzNXB2MjEwLgpDdXJyZW50bHkgb25seSBOVjEy
IGFuZCBYUkdCODg4OCBmb3JtYXRzIGFyZSBzdXBwb3J0ZWQuCkl0IHdhcyB0ZXN0ZWQgYnkgdXNp
bmcgdG9vbCBmcm9tCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LXNhbXN1bmct
c29jL21zZzYwNDk4Lmh0bWwKClNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1p
a29sYWouY2htaWVsQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5v
c19kcm1fcm90YXRvci5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9leHlub3Mv
ZXh5bm9zX2RybV9yb3RhdG9yLmMgYi9kcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1f
cm90YXRvci5jCmluZGV4IGE4MjBhNjg0MjliOS4uYTgyMmQzNDBjY2Y2IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fcm90YXRvci5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9yb3RhdG9yLmMKQEAgLTM1Nyw2ICszNTcsMTEgQEAg
c3RhdGljIGludCByb3RhdG9yX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikKIH0K
ICNlbmRpZgogCitzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9leHlub3NfaXBwX2xpbWl0IHJvdGF0
b3JfczVwdjIxMF9yYmc4ODhfbGltaXRzW10gPSB7CisJeyBJUFBfU0laRV9MSU1JVChCVUZGRVIs
IC5oID0geyA4LCBTWl8xNksgfSwgLnYgPSB7IDgsIFNaXzE2SyB9KSB9LAorCXsgSVBQX1NJWkVf
TElNSVQoQVJFQSwgLmguYWxpZ24gPSAyLCAudi5hbGlnbiA9IDIpIH0sCit9OworCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IGRybV9leHlub3NfaXBwX2xpbWl0IHJvdGF0b3JfNDIxMF9yYmc4ODhfbGlt
aXRzW10gPSB7CiAJeyBJUFBfU0laRV9MSU1JVChCVUZGRVIsIC5oID0geyA4LCBTWl8xNksgfSwg
LnYgPSB7IDgsIFNaXzE2SyB9KSB9LAogCXsgSVBQX1NJWkVfTElNSVQoQVJFQSwgLmguYWxpZ24g
PSA0LCAudi5hbGlnbiA9IDQpIH0sCkBAIC0zNzIsNiArMzc3LDExIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgZHJtX2V4eW5vc19pcHBfbGltaXQgcm90YXRvcl81MjUwX3JiZzg4OF9saW1pdHNbXSA9
IHsKIAl7IElQUF9TSVpFX0xJTUlUKEFSRUEsIC5oLmFsaWduID0gMiwgLnYuYWxpZ24gPSAyKSB9
LAogfTsKIAorc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1fZXh5bm9zX2lwcF9saW1pdCByb3RhdG9y
X3M1cHYyMTBfeXV2X2xpbWl0c1tdID0geworCXsgSVBQX1NJWkVfTElNSVQoQlVGRkVSLCAuaCA9
IHsgMzIsIFNaXzY0SyB9LCAudiA9IHsgMzIsIFNaXzY0SyB9KSB9LAorCXsgSVBQX1NJWkVfTElN
SVQoQVJFQSwgLmguYWxpZ24gPSA4LCAudi5hbGlnbiA9IDgpIH0sCit9OworCiBzdGF0aWMgY29u
c3Qgc3RydWN0IGRybV9leHlub3NfaXBwX2xpbWl0IHJvdGF0b3JfNDIxMF95dXZfbGltaXRzW10g
PSB7CiAJeyBJUFBfU0laRV9MSU1JVChCVUZGRVIsIC5oID0geyAzMiwgU1pfNjRLIH0sIC52ID0g
eyAzMiwgU1pfNjRLIH0pIH0sCiAJeyBJUFBfU0laRV9MSU1JVChBUkVBLCAuaC5hbGlnbiA9IDgs
IC52LmFsaWduID0gOCkgfSwKQEAgLTM4Miw2ICszOTIsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBkcm1fZXh5bm9zX2lwcF9saW1pdCByb3RhdG9yXzQ0MTJfeXV2X2xpbWl0c1tdID0gewogCXsg
SVBQX1NJWkVfTElNSVQoQVJFQSwgLmguYWxpZ24gPSA4LCAudi5hbGlnbiA9IDgpIH0sCiB9Owog
CitzdGF0aWMgY29uc3Qgc3RydWN0IGV4eW5vc19kcm1faXBwX2Zvcm1hdHMgcm90YXRvcl9zNXB2
MjEwX2Zvcm1hdHNbXSA9IHsKKwl7IElQUF9TUkNEU1RfRk9STUFUKFhSR0I4ODg4LCByb3RhdG9y
X3M1cHYyMTBfcmJnODg4X2xpbWl0cykgfSwKKwl7IElQUF9TUkNEU1RfRk9STUFUKE5WMTIsIHJv
dGF0b3JfczVwdjIxMF95dXZfbGltaXRzKSB9LAorfTsKKwogc3RhdGljIGNvbnN0IHN0cnVjdCBl
eHlub3NfZHJtX2lwcF9mb3JtYXRzIHJvdGF0b3JfNDIxMF9mb3JtYXRzW10gPSB7CiAJeyBJUFBf
U1JDRFNUX0ZPUk1BVChYUkdCODg4OCwgcm90YXRvcl80MjEwX3JiZzg4OF9saW1pdHMpIH0sCiAJ
eyBJUFBfU1JDRFNUX0ZPUk1BVChOVjEyLCByb3RhdG9yXzQyMTBfeXV2X2xpbWl0cykgfSwKQEAg
LTM5Nyw2ICs0MTIsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBleHlub3NfZHJtX2lwcF9mb3Jt
YXRzIHJvdGF0b3JfNTI1MF9mb3JtYXRzW10gPSB7CiAJeyBJUFBfU1JDRFNUX0ZPUk1BVChOVjEy
LCByb3RhdG9yXzQ0MTJfeXV2X2xpbWl0cykgfSwKIH07CiAKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
cm90X3ZhcmlhbnQgcm90YXRvcl9zNXB2MjEwX2RhdGEgPSB7CisJLmZvcm1hdHMgPSByb3RhdG9y
X3M1cHYyMTBfZm9ybWF0cywKKwkubnVtX2Zvcm1hdHMgPSBBUlJBWV9TSVpFKHJvdGF0b3JfczVw
djIxMF9mb3JtYXRzKSwKK307CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgcm90X3ZhcmlhbnQgcm90
YXRvcl80MjEwX2RhdGEgPSB7CiAJLmZvcm1hdHMgPSByb3RhdG9yXzQyMTBfZm9ybWF0cywKIAku
bnVtX2Zvcm1hdHMgPSBBUlJBWV9TSVpFKHJvdGF0b3JfNDIxMF9mb3JtYXRzKSwKQEAgLTQxNCw2
ICs0MzQsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJvdF92YXJpYW50IHJvdGF0b3JfNTI1MF9k
YXRhID0gewogCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBleHlub3Nfcm90YXRv
cl9tYXRjaFtdID0gewogCXsKKwkJLmNvbXBhdGlibGUgPSAic2Ftc3VuZyxzNXB2MjEwLXJvdGF0
b3IiLAorCQkuZGF0YSA9ICZyb3RhdG9yX3M1cHYyMTBfZGF0YSwKKwl9LCB7CiAJCS5jb21wYXRp
YmxlID0gInNhbXN1bmcsZXh5bm9zNDIxMC1yb3RhdG9yIiwKIAkJLmRhdGEgPSAmcm90YXRvcl80
MjEwX2RhdGEsCiAJfSwgewotLSAKMi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5EDC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:00:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755E7217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XYIu4E7D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Rt6PfzU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755E7217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dEADQZgIaaNOOyPAh4ggANWjZcP/6Wqh/wxaj2gafAk=; b=XYIu4E7D/4l/Uw
	Q2fScBoke66Z9pk0SMN/VicANCxrMuFGcrd21a7Il04KorPVsjoy4mX8+U4uVI6JLE0wihCtYc1ea
	hGM9G/F6WmOe/PLk6WU0VaFteinmSrKVlgGV1mY0yN1UDtob1/seH6LjZf4mXEHlRCHxSV57PJn/w
	F752otVMrQQOLwZrjQ6LHFuodcOt9sWdox2xtKG2FlJ5s0UtO+einY0euzAinuxcdq5GWAxwZ6Sot
	VWw4ba12AdPW5pO6Aq8RTlZvqKyj3w7u+jnYVlvbgn5CLx3a4CVjB0VKfonnlMPrN325ZkfUheaia
	N+ugEKvS9+mennkw3poQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmiMF-0001in-VO; Thu, 24 Jan 2019 17:00:03 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmiLZ-0001FT-VN
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:59:32 +0000
Received: by mail-ed1-x542.google.com with SMTP id y56so5141352edd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 08:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ptbpNHmP1IxQtArJCgNoGU5Wyd+HU0A6AohvI8TPRfU=;
 b=Rt6PfzU432vYC255tCk6KIHHyvRhuBe6Cr4ECdk/HGjbKFVxwPColt3cfVmfVrV9MS
 W3MhOCZ+cgpmhyGTXgM7/8jsM5lmi5V4fGOykTlXt+o+TxxaaPYJ7sqKU0rIiEKQ5+eS
 S5lUV2UAwWSu6AlE4Fx7HCnide18gGuMeiHXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ptbpNHmP1IxQtArJCgNoGU5Wyd+HU0A6AohvI8TPRfU=;
 b=FTL32CIxiVNzAueD/WcmzE6jg9BvQ1pSWQ9nK+Ws28qn/bF4OuZGSDDSp0vvasEOoX
 vk+FtHZ2OpgVPPYXIEEDjEWqoydVl7BlPAPw/kEVBnUTdkfEXuslAsBCVKN2JEcusdNc
 J4B8tnZvd0jk+TKp/qLTmKFnKiSIu+Ld1e7R3adoJtYvfpZIR8i3VmRXho+csV2LTW4X
 UsfOT7taQlYvvKjZrVwq4NutFhLLInWaZ04l+T2e9/w4eZoDL2QT2WpGsh56Xv8Eds94
 S21FHA/yWVdgdwtWv4v/PsHtLVjCGLaRAUWlaPw3UHuVbP0b1vcZH66/5/+2BAnHCCSa
 E3Qw==
X-Gm-Message-State: AJcUukchsOftVLVoMik/H+OR2fNXXfqqiIhXb93Jo5x+C+jY1lSgakXa
 d2HIXjOmBxmo8Au1jucZPpeIrQ==
X-Google-Smtp-Source: ALg8bN6QRj6TYEc0DG6xoIG4I77HrQVorGJHHpvEscd+oOzXyorDQyWoWiFnODoPZMRCl94pbLsKsQ==
X-Received: by 2002:a50:fb03:: with SMTP id d3mr7224510edq.183.1548349160604; 
 Thu, 24 Jan 2019 08:59:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id w31sm11219233edw.82.2019.01.24.08.59.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 08:59:19 -0800 (PST)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 26/26] drm/<drivers>: Don't set FBINFO_(FLAG_)DEFAULT
Date: Thu, 24 Jan 2019 17:58:31 +0100
Message-Id: <20190124165831.16427-27-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_085922_730332_8949572F 
X-CRM114-Status: GOOD (  14.99  )
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
Cc: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Thierry Reding <thierry.reding@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Daniel Vetter <daniel.vetter@intel.com>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alexander Kapshuk <alexander.kapshuk@gmail.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Inki Dae <inki.dae@samsung.com>, Hans de Goede <hdegoede@redhat.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Sandy Huang <hjc@rock-chips.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SXQncyAwLgoKU2lnbmVkLW9mZi1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBpbnRl
bC5jb20+CkNjOiBJbmtpIERhZSA8aW5raS5kYWVAc2Ftc3VuZy5jb20+CkNjOiBKb29ueW91bmcg
U2hpbSA8ankwOTIyLnNoaW1Ac2Ftc3VuZy5jb20+CkNjOiBTZXVuZy1Xb28gS2ltIDxzdzAzMTIu
a2ltQHNhbXN1bmcuY29tPgpDYzogS3l1bmdtaW4gUGFyayA8a3l1bmdtaW4ucGFya0BzYW1zdW5n
LmNvbT4KQ2M6IEt1a2ppbiBLaW0gPGtnZW5lQGtlcm5lbC5vcmc+CkNjOiBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+CkNjOiBQYXRyaWsgSmFrb2Jzc29uIDxwYXRyaWsuci5q
YWtvYnNzb25AZ21haWwuY29tPgpDYzogQmVuIFNrZWdncyA8YnNrZWdnc0ByZWRoYXQuY29tPgpD
YzogU2FuZHkgSHVhbmcgPGhqY0Byb2NrLWNoaXBzLmNvbT4KQ2M6ICJIZWlrbyBTdMO8Ym5lciIg
PGhlaWtvQHNudGVjaC5kZT4KQ2M6IFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFp
bC5jb20+CkNjOiBKb25hdGhhbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPgpDYzogSGFu
cyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0
dGVyQGZmd2xsLmNoPgpDYzogQmFydGxvbWllaiBab2xuaWVya2lld2ljeiA8Yi56b2xuaWVya2ll
QHNhbXN1bmcuY29tPgpDYzogQWxleGFuZGVyIEthcHNodWsgPGFsZXhhbmRlci5rYXBzaHVrQGdt
YWlsLmNvbT4KQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpDYzogbGlu
dXgtc2Ftc3VuZy1zb2NAdmdlci5rZXJuZWwub3JnCkNjOiBub3V2ZWF1QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogbGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpDYzogbGludXgt
dGVncmFAdmdlci5rZXJuZWwub3JnCi0tLQogZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3Nf
ZHJtX2ZiZGV2LmMgICAgIHwgMSAtCiBkcml2ZXJzL2dwdS9kcm0vZ21hNTAwL2ZyYW1lYnVmZmVy
LmMgICAgICAgICAgfCAxIC0KIGRyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZmJjb24u
YyAgICAgICB8IDQgKystLQogZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX2RybV9m
YmRldi5jIHwgMSAtCiBkcml2ZXJzL2dwdS9kcm0vdGVncmEvZmIuYyAgICAgICAgICAgICAgICAg
ICAgfCAxIC0KIDUgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9mYmRldi5j
IGIvZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX2ZiZGV2LmMKaW5kZXggYjIwMTg5
NjFiOWNmLi4wMGJmY2QyOGU1ODkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9leHlub3Mv
ZXh5bm9zX2RybV9mYmRldi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2Ry
bV9mYmRldi5jCkBAIC04Nyw3ICs4Nyw2IEBAIHN0YXRpYyBpbnQgZXh5bm9zX2RybV9mYmRldl91
cGRhdGUoc3RydWN0IGRybV9mYl9oZWxwZXIgKmhlbHBlciwKIAkJcmV0dXJuIFBUUl9FUlIoZmJp
KTsKIAl9CiAKLQlmYmktPmZsYWdzID0gRkJJTkZPX0ZMQUdfREVGQVVMVDsKIAlmYmktPmZib3Bz
ID0gJmV4eW5vc19kcm1fZmJfb3BzOwogCiAJZHJtX2ZiX2hlbHBlcl9maWxsX2luZm8oZmJpLCBo
ZWxwZXIpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2dtYTUwMC9mcmFtZWJ1ZmZlci5j
IGIvZHJpdmVycy9ncHUvZHJtL2dtYTUwMC9mcmFtZWJ1ZmZlci5jCmluZGV4IGM3YTVjMjlmOWE2
OS4uM2I1OWRiYWRmYTYzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZ21hNTAwL2ZyYW1l
YnVmZmVyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2dtYTUwMC9mcmFtZWJ1ZmZlci5jCkBAIC00
MDEsNyArNDAxLDYgQEAgc3RhdGljIGludCBwc2JmYl9jcmVhdGUoc3RydWN0IHBzYl9mYmRldiAq
ZmJkZXYsCiAKIAlmYmRldi0+cHNiX2ZiX2hlbHBlci5mYiA9IGZiOwogCi0JaW5mby0+ZmxhZ3Mg
PSBGQklORk9fREVGQVVMVDsKIAlpZiAoZGV2X3ByaXYtPm9wcy0+YWNjZWxfMmQgJiYgcGl0Y2hf
bGluZXMgPiA4KQkvKiAyRCBlbmdpbmUgKi8KIAkJaW5mby0+ZmJvcHMgPSAmcHNiZmJfb3BzOwog
CWVsc2UgaWYgKGd0dF9yb2xsKSB7CS8qIEdUVCByb2xsaW5nIHNlZW1zIGJlc3QgKi8KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZmJjb24uYyBiL2RyaXZlcnMv
Z3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZmJjb24uYwppbmRleCAzYTNkNDU0YjY1ZTMuLjExMzZl
ZTI2MDA1ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9mYmNv
bi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZmJjb24uYwpAQCAtMzcw
LDkgKzM3MCw5IEBAIG5vdXZlYXVfZmJjb25fY3JlYXRlKHN0cnVjdCBkcm1fZmJfaGVscGVyICpo
ZWxwZXIsCiAJZmJjb24tPmhlbHBlci5mYiA9ICZmYi0+YmFzZTsKIAogCWlmICghY2hhbikKLQkJ
aW5mby0+ZmxhZ3MgPSBGQklORk9fREVGQVVMVCB8IEZCSU5GT19IV0FDQ0VMX0RJU0FCTEVEOwor
CQlpbmZvLT5mbGFncyA9IEZCSU5GT19IV0FDQ0VMX0RJU0FCTEVEOwogCWVsc2UKLQkJaW5mby0+
ZmxhZ3MgPSBGQklORk9fREVGQVVMVCB8IEZCSU5GT19IV0FDQ0VMX0NPUFlBUkVBIHwKKwkJaW5m
by0+ZmxhZ3MgPSBGQklORk9fSFdBQ0NFTF9DT1BZQVJFQSB8CiAJCQkgICAgICBGQklORk9fSFdB
Q0NFTF9GSUxMUkVDVCB8CiAJCQkgICAgICBGQklORk9fSFdBQ0NFTF9JTUFHRUJMSVQ7CiAJaW5m
by0+ZmJvcHMgPSAmbm91dmVhdV9mYmNvbl9zd19vcHM7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX2ZiZGV2LmMgYi9kcml2ZXJzL2dwdS9kcm0vcm9j
a2NoaXAvcm9ja2NoaXBfZHJtX2ZiZGV2LmMKaW5kZXggZDEyMTY0ODc4ZTA1Li5mZWQ3ZDc2OTgx
NjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fZmJk
ZXYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfZHJtX2ZiZGV2LmMK
QEAgLTkwLDcgKzkwLDYgQEAgc3RhdGljIGludCByb2NrY2hpcF9kcm1fZmJkZXZfY3JlYXRlKHN0
cnVjdCBkcm1fZmJfaGVscGVyICpoZWxwZXIsCiAJCWdvdG8gb3V0OwogCX0KIAotCWZiaS0+Zmxh
Z3MgPSBGQklORk9fRkxBR19ERUZBVUxUOwogCWZiaS0+ZmJvcHMgPSAmcm9ja2NoaXBfZHJtX2Zi
ZGV2X29wczsKIAogCWZiID0gaGVscGVyLT5mYjsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS90ZWdyYS9mYi5jIGIvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL2ZiLmMKaW5kZXggODIzNDhkZGQw
YjgzLi5lYTgyMTg0MDczYmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90ZWdyYS9mYi5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS90ZWdyYS9mYi5jCkBAIC0yNTUsNyArMjU1LDYgQEAgc3Rh
dGljIGludCB0ZWdyYV9mYmRldl9wcm9iZShzdHJ1Y3QgZHJtX2ZiX2hlbHBlciAqaGVscGVyLAog
CWhlbHBlci0+ZmIgPSBmYjsKIAloZWxwZXItPmZiZGV2ID0gaW5mbzsKIAotCWluZm8tPmZsYWdz
ID0gRkJJTkZPX0ZMQUdfREVGQVVMVDsKIAlpbmZvLT5mYm9wcyA9ICZ0ZWdyYV9mYl9vcHM7CiAK
IAlkcm1fZmJfaGVscGVyX2ZpbGxfaW5mbyhpbmZvLCBoZWxwZXIpOwotLSAKMi4yMC4xCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=

Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC2FC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:12:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1D520837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RTBDuy1+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX+e4XDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1D520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1BoJszPZF+9rEn8st2QblBOrhd330DbHypmoC8qQCK4=; b=RTBDuy1+Rsr+3t
	dd1OdOHJjZMBimfgDqBVCIqNWVUgudHaFv+iZlXovWKjfLixdtZsAL1jOC+pKpMSDpV4kBj7QdE8H
	FW6y3fIGnE+y3/VrHDX2cuWpjHR3GYDquEz6Vhb+S9HU+A19k1CQomf/zUO7Ow5tlXRmolS1ow74Q
	88UphBPumddQxAC9Y9BVZctAcqM8rPUU9IOKSOhqQE4joCEmN7hEqi9pR+vRz9Qju/IhFIBBc+zGh
	RoYh1toU3DzOP1s1srE8xPcNk/ezatGba3mrGKmiz3kyb25ulcdqYmwSyKncsLSL344sg/ts/vi9p
	jwAM2icAiA8SCCM8hLqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLYR-0001h5-Qm; Fri, 07 Dec 2018 19:12:51 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLXg-0000lf-6e
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 19:12:05 +0000
Received: by mail-lj1-x244.google.com with SMTP id t9-v6so4464836ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KLoK8dxaYhkkvoDpPS82xpkVnSH4qU0dp8vtgaAdqTE=;
 b=HX+e4XDBM1RO5xTwGc74azJX8XJQFVhsu+8lpf5ZELaCCb6j5G4/71XpkPiqJ3RCgP
 VNeCZidzoU5ILeX6Mmu/xtwJI1BpV8DWuBCp8nOWBFqKwhFBf3VlNxuL75pOHXcFjHxQ
 NOokIor5Z3jkj8GVU0j6I7NRMqmIRluV5qK2+to0ZziF3F/ra8fxXBF0UPEOgqRd1+op
 pO4NFF/pC+Teyr0vm5X5aTHPdzlqC5klzFsLKg7i0anVnSR35tHUzRM0eQBppLL3yy57
 xfs+SGEUsclZjamACSiZ34EtdMIwn47pR8dsBsR+RQ+sUwzAg+5oPuXxgXfrjOdJKwLO
 VWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KLoK8dxaYhkkvoDpPS82xpkVnSH4qU0dp8vtgaAdqTE=;
 b=AV/RLlzeuoBJy/ZAtXkFG9mzgp9bs8+IW8Imb100qbzwJ1hP7jgNZxfkKuWyR6nUaj
 hcVaJPYV1OMNwU3xh31enk1mVFJ+AtXzVRucGar1tFdhI9ltqCxmmQLpO4INurX8vUP9
 +rfJjgpXBIXZqBp9RpyDLAaEBAYByO83BajQfYk9ZkHtJIbP4Rl5ELU6SaYQFYvXuGFc
 IF8/1xck1JuVMwJIC+eA+lC4SQwoDnT7Uz6KpsZ/dS6QffRyoBFmbBeYsIv5S6LKCxE0
 URm8gy0o/4+PjrorYUfo7HXZ02FEmjrwZBnBFUoSEA8KCW6Ayas1BK6ozpjcInOiMBwQ
 c3ow==
X-Gm-Message-State: AA+aEWZ52WEADhDchXnIiPk6CsxtxwaepZSqlDS7uG+Nk4l+mJLn+yTt
 eSlKe+WstPruhlcwlT47pLs=
X-Google-Smtp-Source: AFSGD/XBeZQPwmkFSo16rt1CctJcoLbztk0UDADFMQLOMWmRwsLXkobD2L6mwE+fwip1oTMMl8RmAA==
X-Received: by 2002:a2e:92ca:: with SMTP id
 k10-v6mr2043984ljh.63.1544209912365; 
 Fri, 07 Dec 2018 11:11:52 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:45d9:69e8:d41f:b616])
 by smtp.googlemail.com with ESMTPSA id 12-v6sm727915ljs.29.2018.12.07.11.11.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 11:11:51 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 2/3] iio: adc: Allow selection of Exynos ADC on S5PV210
Date: Fri,  7 Dec 2018 20:11:35 +0100
Message-Id: <20181207191136.5464-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_111204_244396_D76B2EF7 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: mark.rutland@arm.com, linux-iio@vger.kernel.org, xc-racer2@live.ca,
 pmeerw@pmeerw.net, freeman.liu@spreadtrum.com, marcus.folkesson@gmail.com,
 lars@metafoo.de, krzk@kernel.org, linux-samsung-soc@vger.kernel.org,
 kgene@kernel.org, geert@linux-m68k.org, pawel.mikolaj.chmiel@gmail.com,
 devicetree@vger.kernel.org, smohanad@codeaurora.org, vilhelm.gray@gmail.com,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 baolin.wang@linaro.org, rdunlap@infradead.org, arnaud.pouliquen@st.com,
 linux-kernel@vger.kernel.org, broonie@kernel.org, knaack.h@gmx.de,
 eugen.hristev@microchip.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogSm9uYXRoYW4gQmFra2VyIDx4Yy1yYWNlcjJAbGl2ZS5jYT4KCk1ha2UgaXQgcG9zc2li
bGUgdG8gdXNlIEV4eW5vcyBBREMgZHJpdmVyIG9uIFM1UFYyMTAgYmFzZWQgZGV2aWNlcy4KClNp
Z25lZC1vZmYtYnk6IEpvbmF0aGFuIEJha2tlciA8eGMtcmFjZXIyQGxpdmUuY2E+ClNpZ25lZC1v
ZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KLS0t
CiBkcml2ZXJzL2lpby9hZGMvS2NvbmZpZyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9LY29u
ZmlnIGIvZHJpdmVycy9paW8vYWRjL0tjb25maWcKaW5kZXggYTUyZmVhODc0OWE5Li4yMGUxMjZm
ZjAzMGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaWlvL2FkYy9LY29uZmlnCisrKyBiL2RyaXZlcnMv
aWlvL2FkYy9LY29uZmlnCkBAIC0yNzQsNyArMjc0LDcgQEAgY29uZmlnIEVQOTNYWF9BREMKIAog
Y29uZmlnIEVYWU5PU19BREMKIAl0cmlzdGF0ZSAiRXh5bm9zIEFEQyBkcml2ZXIgc3VwcG9ydCIK
LQlkZXBlbmRzIG9uIEFSQ0hfRVhZTk9TIHx8IEFSQ0hfUzNDMjRYWCB8fCBBUkNIX1MzQzY0WFgg
fHwgKE9GICYmIENPTVBJTEVfVEVTVCkKKwlkZXBlbmRzIG9uIEFSQ0hfRVhZTk9TIHx8IEFSQ0hf
UzNDMjRYWCB8fCBBUkNIX1MzQzY0WFggfHwgQVJDSF9TNVBWMjEwIHx8IChPRiAmJiBDT01QSUxF
X1RFU1QpCiAJZGVwZW5kcyBvbiBIQVNfSU9NRU0KIAloZWxwCiAJICBDb3JlIHN1cHBvcnQgZm9y
IHRoZSBBREMgYmxvY2sgZm91bmQgaW4gdGhlIFNhbXN1bmcgRVhZTk9TIHNlcmllcwotLSAKMi4x
Ny4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=

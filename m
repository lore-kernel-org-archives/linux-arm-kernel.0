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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FBCC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:12:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434A620837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WPlC2nnf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMzuIcZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434A620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fMV4+I8bo8CnfHE6qEXskRBBCK3m0e5v98EFHIzuygs=; b=WPlC2nnfDHj9aJ
	bGESwR3Xh2OmZGCoH98k2xejbvmxA852WgpNn49b5xCChKVOICaRro5NONm2UgcHLbO0paYyxHsH+
	kijlfH0NXBLj0GP1Avfxt2iUS9xAxMcnQITe0ujph+lRiYdZ6utM21OqEA9BdEfrnoTIZaJPRmy+l
	NhQ+lp1mTBHiNMCi8OHjKCMiRrBTwOfPcplxY0XvpvamSLaVD/Rdl4hqZRqPc0DKGpFP4gOGl3xaQ
	zxBhmkWiVCjTNbyrWA9UljLApsU09qFOTfIZ4uCuiYYZ42fDN/62EiG2Ss364aFYVKjAICmxQNMCE
	5Qf9tm0LRAnnUaC3k5vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLXh-0000qQ-IF; Fri, 07 Dec 2018 19:12:05 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLXd-0000m7-2n
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 19:12:03 +0000
Received: by mail-lj1-x242.google.com with SMTP id s5-v6so4429422ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 11:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g2x5BRD7D0OPE9JeIh4cIErJAv6rfykzoqrwzqsJVYI=;
 b=UMzuIcZe7mTZw0Ou8g5w5fRJxwWU+RMMNT0TDXCHpZsj5rFme3BqLltsNGU0Pky18A
 Iuryxn4DGVtfe+oHVSSZdyw2lq17D78s/AZhZHZi7L+Nbzr+ogLkuZ6F9C7lV/+V5eHX
 U8MMpS9RYmre81XKtFsji0sdWV12MBaNuIa528SBoYb8wtz5/aTcLt7K3gcCW+xt6jtV
 F7HIVkiIvTxRWI0pufOJUs1NYKoQGC2jHEmACi4iIfAg8mU+CbK/LxcVQOdv3SpvmBdA
 woxfhwwF5Af2vHN4XrrtP7lKT0yJOgWbNzVDnCwv/jgU3N3D9kkG0qMLfQmRgCCiBHfO
 ZO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g2x5BRD7D0OPE9JeIh4cIErJAv6rfykzoqrwzqsJVYI=;
 b=O7InffpAC9ZG6eZ5R4iYmIT0ls0XTc4Xtl94yZMK6k5OmZFsQ5RdSIyGJ7nVx/4z9b
 +HKHTKbZQyrhRvtlUhmVIOEqYiMq2B2NDLuQhZ1oSqiPcV9zgwcnyM5CJyEAGwCQwbgG
 OG/QktlbWPNdbHzEuYzVhl4k+USPp38O6oZPp15VK4lL+vTb2VGdJEVC9p61wyoKrWj3
 gwip51FcxJAQVVJ1B4Sejw5PFtnQ5GXsO2DyJL6MfwEMrqWlIuRSe+sOKwSR/W8ZvXGw
 XKCoO5aK1PGxtPysvPzSIx9xTE8o8KGLREqDJGbRt6Aj1HBS7/ogZVB60+2FEoIv+iVd
 LGmQ==
X-Gm-Message-State: AA+aEWbu1q5EdXKm1yEJtlQd1WdDu+8e7lxtCKgcAKGrfMXsaF6HjXzf
 4JCULIuTqNDTqigt1znsU/Y=
X-Google-Smtp-Source: AFSGD/Uwhu9dmo2o6pcdMi52WE4LA4EXixzLK2K9odxFN1ZMjWB57nNPdaIOl/G02+0IfFuJOKdhMw==
X-Received: by 2002:a2e:97d7:: with SMTP id
 m23-v6mr2275086ljj.18.1544209914351; 
 Fri, 07 Dec 2018 11:11:54 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:45d9:69e8:d41f:b616])
 by smtp.googlemail.com with ESMTPSA id 12-v6sm727915ljs.29.2018.12.07.11.11.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 11:11:53 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 3/3] dt-bindings: iio: adc: exynos-adc: Add S5PV210 variant
Date: Fri,  7 Dec 2018 20:11:36 +0100
Message-Id: <20181207191136.5464-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_111201_178876_C2CD31D0 
X-CRM114-Status: GOOD (  11.88  )
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

RnJvbTogSm9uYXRoYW4gQmFra2VyIDx4Yy1yYWNlcjJAbGl2ZS5jYT4KCkFkZCBpbmZvcm1hdGlv
biBhYm91dCBuZXcgY29tcGF0aWJsZSBmb3IgUzVQVjIxMAoKU2lnbmVkLW9mZi1ieTogSm9uYXRo
YW4gQmFra2VyIDx4Yy1yYWNlcjJAbGl2ZS5jYT4KU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWll
bCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgotLS0KIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9hZGMvc2Ftc3VuZyxleHlub3MtYWRjLnR4dCAgICAgICAgfCA0ICsrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9zYW1zdW5nLGV4eW5v
cy1hZGMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvc2Ft
c3VuZyxleHlub3MtYWRjLnR4dAppbmRleCA2YzQ5ZGI3ZjhhZDIuLmExMGMxZjg5MDM3ZCAxMDA2
NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvc2Ftc3Vu
ZyxleHlub3MtYWRjLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aWlvL2FkYy9zYW1zdW5nLGV4eW5vcy1hZGMudHh0CkBAIC0xMSw3ICsxMSw3IEBAIE5ldyBkcml2
ZXIgaGFuZGxlcyB0aGUgZm9sbG93aW5nCiAKIFJlcXVpcmVkIHByb3BlcnRpZXM6CiAtIGNvbXBh
dGlibGU6CQlNdXN0IGJlICJzYW1zdW5nLGV4eW5vcy1hZGMtdjEiCi0JCQkJZm9yIGV4eW5vczQ0
MTIvNTI1MCBhbmQgczVwdjIxMCBjb250cm9sbGVycy4KKwkJCQlmb3IgZXh5bm9zNDQxMi81MjUw
IGNvbnRyb2xsZXJzLgogCQkJTXVzdCBiZSAic2Ftc3VuZyxleHlub3MtYWRjLXYyIiBmb3IKIAkJ
CQlmdXR1cmUgY29udHJvbGxlcnMuCiAJCQlNdXN0IGJlICJzYW1zdW5nLGV4eW5vczMyNTAtYWRj
IiBmb3IKQEAgLTI4LDYgKzI4LDggQEAgUmVxdWlyZWQgcHJvcGVydGllczoKIAkJCQl0aGUgQURD
IGluIHMzYzI0NDMgYW5kIGNvbXBhdGlibGVzCiAJCQlNdXN0IGJlICJzYW1zdW5nLHMzYzY0MTAt
YWRjIiBmb3IKIAkJCQl0aGUgQURDIGluIHMzYzY0MTAgYW5kIGNvbXBhdGlibGVzCisJCQlNdXN0
IGJlICJzYW1zdW5nLHM1cHYyMTAtYWRjIiBmb3IKKwkJCQl0aGUgQURDIGluIHM1cHYyMTAgYW5k
IGNvbXBhdGlibGVzCiAtIHJlZzoJCQlMaXN0IG9mIEFEQyByZWdpc3RlciBhZGRyZXNzIHJhbmdl
CiAJCQktIFRoZSBiYXNlIGFkZHJlc3MgYW5kIHJhbmdlIG9mIEFEQyByZWdpc3RlcgogCQkJLSBU
aGUgYmFzZSBhZGRyZXNzIGFuZCByYW5nZSBvZiBBRENfUEhZIHJlZ2lzdGVyIChldmVyeQotLSAK
Mi4xNy4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=

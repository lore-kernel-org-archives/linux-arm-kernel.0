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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1223C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D3620837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KD3gC645";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTL2MKoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D3620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ApVaOuPH6aDZ9Bg9jJcBIW81LUE9iUOHgg+O53ZNvJM=; b=KD3gC645BkK+4i
	C4c5SUa79fJKZcxTpyNu/S1P8DWNM7mrRLGnuZwL6NkIDh6IWaw0ENqJt9jPK49tKXtomW7Tvi3Ls
	842Yf+bA17ZZiv+A64HsxtfXfuFaTiux6TNAoqmT4ZUAH3tJlvKpU+AnSO3Z92ShsN09OFRn374pq
	h5rzS9HyhW12/0Z855ryffy/9aJ/NqCQhiWjFEWqJrN3recnG6Ezj+RlbblNakmf7GsgCPdUfN8Wi
	MxsQ0pbd31oho2FWQruemdLALrLDOXKPyN+vI6WVkT9ir0KF3Pw8IFMYq8p+T3uE+05txMUoBWWv5
	mZUWE0I18Xrp0tXoEAog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLYC-0001Oc-P8; Fri, 07 Dec 2018 19:12:36 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLXf-0000lO-AZ
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 19:12:04 +0000
Received: by mail-lj1-x241.google.com with SMTP id v1-v6so4509607ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 11:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9lZ1jc9eu+qngoQSAA5KNgJbshVX5vnWxLkDtgSyMDI=;
 b=DTL2MKoPhuwQPtRKrUkKDelyhdY0lUC3nLAMbQyPWQLlC7mGxuY/CZY4GMsZqQwp0t
 Xu13lS2mvRDFmTWR+WsWDufyPomAn7GXFezlHdZ7DKYBgNKitStQ0bC+axqBzWhR+17w
 dL0jlpgfIZjczX+6NFsihD7beFxAg2gDIJvkH9YAvSyJUDKSJV4Z5g+2DmDwXR89nox2
 HgOs53kUfkVdhQWDbYHCwneGMkiXRmqDu7opknV1OTHQz+d5DX/bdOn7dRchfriJv4fI
 LUY/u9F8HHy4OMsLpM09hHUV7zx8+VV4IBr7soB0jQfAKetVkRFfeUbWFoj00PLKNOMr
 NLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9lZ1jc9eu+qngoQSAA5KNgJbshVX5vnWxLkDtgSyMDI=;
 b=m03X26MeAK3wFDRR1tZMwOO3KqdFzYRjnfW2KPbIc0JwE2ZieQ/EgSuQhxrCgBIVcA
 G2qMHvH1m37y4TlFDx8gQYm9Xh01PvI/wR2Mq0m4zDrLcXCGpEIQ5HrFTz5piUkY+uc+
 vzxEOanlNluXkmnrImEWkCNffeQSHOoy4aO1KTc04VIv+4s3Q0KAXECaNnX6e0dajqWb
 6qhfX1HPkEyIVkqjt1Z8jgPRuLYPxOXlm61X5avE1FDReF5l/b5SchwPT18iajMQ3OGF
 xHnmudBW34N7VhCtrh5rpFY6NuNVTvIR21ludyuq4eBHdijmdgZCuEwRQOsuCY7UWABn
 vvpQ==
X-Gm-Message-State: AA+aEWZE/e5ps+1tv8ObQToPgzTUQG7to0q+qABSRp09IAmh5iRc1D6/
 he9MJjsIqXyGCTlE4vykptI=
X-Google-Smtp-Source: AFSGD/XLtd860YcbUUErKxHr82lc8x+SxGhOFNQbMdvXXFtQCqeBCCCTlBgHl0KRWlpBUEotjGf0nA==
X-Received: by 2002:a2e:3603:: with SMTP id d3-v6mr2030639lja.46.1544209910517; 
 Fri, 07 Dec 2018 11:11:50 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:45d9:69e8:d41f:b616])
 by smtp.googlemail.com with ESMTPSA id 12-v6sm727915ljs.29.2018.12.07.11.11.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 11:11:49 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: jic23@kernel.org
Subject: [PATCH 1/3] iio: adc: exynos-adc: Add S5PV210 variant
Date: Fri,  7 Dec 2018 20:11:34 +0100
Message-Id: <20181207191136.5464-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_111203_370721_121D35F7 
X-CRM114-Status: GOOD (  12.78  )
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

RnJvbTogSm9uYXRoYW4gQmFra2VyIDx4Yy1yYWNlcjJAbGl2ZS5jYT4KClM1UFYyMTAncyBBREMg
dmFyaWFudCBpcyBhbG1vc3QgdGhlIHNhbWUgYXMgdjEgZXhjZXB0IHRoYXQgaXQgaGFzIDEwCmNo
YW5uZWxzIGFuZCBkb2Vzbid0IHJlcXVpcmUgdGhlIHBtdSByZWdpc3RlcgoKU2lnbmVkLW9mZi1i
eTogSm9uYXRoYW4gQmFra2VyIDx4Yy1yYWNlcjJAbGl2ZS5jYT4KU2lnbmVkLW9mZi1ieTogUGF3
ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgotLS0KIGRyaXZlcnMv
aWlvL2FkYy9leHlub3NfYWRjLmMgfCAxNCArKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvZXh5bm9zX2Fk
Yy5jIGIvZHJpdmVycy9paW8vYWRjL2V4eW5vc19hZGMuYwppbmRleCBmMTA0NDNmOTJlNGMuLmZh
MmQyYjU3NjdmMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9paW8vYWRjL2V4eW5vc19hZGMuYworKysg
Yi9kcml2ZXJzL2lpby9hZGMvZXh5bm9zX2FkYy5jCkBAIC0xMTUsNiArMTE1LDcgQEAKICNkZWZp
bmUgTUFYX0FEQ19WMl9DSEFOTkVMUwkJMTAKICNkZWZpbmUgTUFYX0FEQ19WMV9DSEFOTkVMUwkJ
OAogI2RlZmluZSBNQVhfRVhZTk9TMzI1MF9BRENfQ0hBTk5FTFMJMgorI2RlZmluZSBNQVhfUzVQ
VjIxMF9BRENfQ0hBTk5FTFMJMTAKIAogLyogQml0IGRlZmluaXRpb25zIGNvbW1vbiBmb3IgQURD
X1YxIGFuZCBBRENfVjIgKi8KICNkZWZpbmUgQURDX0NPTl9FTl9TVEFSVAkoMXUgPDwgMCkKQEAg
LTI4Miw2ICsyODMsMTYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBleHlub3NfYWRjX2RhdGEgZXh5
bm9zX2FkY192MV9kYXRhID0gewogCS5zdGFydF9jb252CT0gZXh5bm9zX2FkY192MV9zdGFydF9j
b252LAogfTsKIAorc3RhdGljIGNvbnN0IHN0cnVjdCBleHlub3NfYWRjX2RhdGEgZXh5bm9zX2Fk
Y19zNXB2MjEwX2RhdGEgPSB7CisJLm51bV9jaGFubmVscwk9IE1BWF9TNVBWMjEwX0FEQ19DSEFO
TkVMUywKKwkubWFzawkJPSBBRENfREFUWF9NQVNLLAkvKiAxMiBiaXQgQURDIHJlc29sdXRpb24g
Ki8KKworCS5pbml0X2h3CT0gZXh5bm9zX2FkY192MV9pbml0X2h3LAorCS5leGl0X2h3CT0gZXh5
bm9zX2FkY192MV9leGl0X2h3LAorCS5jbGVhcl9pcnEJPSBleHlub3NfYWRjX3YxX2NsZWFyX2ly
cSwKKwkuc3RhcnRfY29udgk9IGV4eW5vc19hZGNfdjFfc3RhcnRfY29udiwKK307CisKIHN0YXRp
YyB2b2lkIGV4eW5vc19hZGNfczNjMjQxNl9zdGFydF9jb252KHN0cnVjdCBleHlub3NfYWRjICpp
bmZvLAogCQkJCQkgIHVuc2lnbmVkIGxvbmcgYWRkcikKIHsKQEAgLTQ3OCw2ICs0ODksOSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBleHlub3NfYWRjX21hdGNoW10gPSB7CiAJ
fSwgewogCQkuY29tcGF0aWJsZSA9ICJzYW1zdW5nLHMzYzY0MTAtYWRjIiwKIAkJLmRhdGEgPSAm
ZXh5bm9zX2FkY19zM2M2NHh4X2RhdGEsCisJfSwgeworCQkuY29tcGF0aWJsZSA9ICJzYW1zdW5n
LHM1cHYyMTAtYWRjIiwKKwkJLmRhdGEgPSAmZXh5bm9zX2FkY19zNXB2MjEwX2RhdGEsCiAJfSwg
ewogCQkuY29tcGF0aWJsZSA9ICJzYW1zdW5nLGV4eW5vcy1hZGMtdjEiLAogCQkuZGF0YSA9ICZl
eHlub3NfYWRjX3YxX2RhdGEsCi0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

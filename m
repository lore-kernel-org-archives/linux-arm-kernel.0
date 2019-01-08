Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9CBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F25214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kO1C+P8q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A31b7aW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F25214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XQISgMNPserEwYH0jMaldpwLAI/GhGzuPO+QvOuBaEQ=; b=kO1C+P8qFcXLAZ
	7QMtUoshm/katgxj7RFaRpJEUlV8OeR4QPpnQ17kJyp3JgZVEqM5KfB4PiZlx7dQVJvsLsPZby/Uv
	1H8+K3RUtwxFCPZ89wfrWoPuyjlg7hQSQggbnH66OAsaEPvHKTwK52ui9a7u0wfNAlGDXSO6cbVKa
	UlCbO7XUocAJcoL/lS0d8hED0dH9YmnnSn4iIXijYkNW9rHb1A1xViWeyMQxtlyEJxL/eS+QVyR72
	1qTEbRX4u7lUVhvXM+yd+2wsHR1ck6UwtOIe+tozuAuqGTxmqEQXYivcKvWP/LsgbjfPBTW6pwz0C
	ICxmz9Z1TVsgjoVNCJ6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggug0-0003UZ-JX; Tue, 08 Jan 2019 16:56:28 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggufi-0003BG-Bn
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:56:13 +0000
Received: by mail-lj1-x241.google.com with SMTP id g11-v6so4015211ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jAEXFJkBZ3UVZneEhxEUAboaTpH0jjDGy7Sznxt2tMw=;
 b=A31b7aW85KjLT5S9fD0JOkn66FArIYgUEAabFdE0BoN9HbQ8YiOMGC94Vr8Y67UX6l
 9DUzAaBI9h+fIB6qQRAe8EuyrBdbBKq27+ul+2Z/oyyzd/MTmbOj8KKleRoswwKwGLp/
 cBO2ys1ru3VcFD9f83yRSvq4ifNMlHxsrkExSK5gnoIPqEStYlnYlqbF1O5SArVHv/33
 WZW1bFFEiIotYNftF1E+bVcya4NvX1thwEpU8fNNpazh8SOp27MRmtvHNGKEdVwxj/kp
 bMsL/fX6w+Eymu5SOXR4nA+URpj//lG1LwONM0XajRMcTV2/OwGotwYZpyYhkYl1q0N1
 qqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jAEXFJkBZ3UVZneEhxEUAboaTpH0jjDGy7Sznxt2tMw=;
 b=VIXdKaNMPtobjAOPGefAYdE2Y5N/BCTmL+cYvBirEWzg4qaJ0k7p5XdixSCUnXNaIt
 skM9AH3HQUsD8n9hOMzFFSPqj+WdFRRDmj32onEFWOCtaybKZVQl5ilT4WGNzt4QNlSt
 M8uEvNZRo8ktCszgkBUvj5URJDjOOOdxM3DgBFhMxnjiyNWpK2cadXKcSP8WznfEkPNm
 w5egL9FngoFOY/PmJUAVutfmr9OSKS5uWhbna6Lhd1KKNbJdDQSOtVJugJqByK808tIR
 eTxtjxvBo5DJ8z7btZDdyZ7KTez+6HTNXYtMiRCCxxEqKRUTduyUdYWeqyVJ5L1Exn6f
 GqKA==
X-Gm-Message-State: AJcUukfhkFkyQDIoT6xHEPR2hgUZorKSVUrM0NqNQzA1/6LN00v/NhiT
 xogQeYjEoWh5Q/oeIJ7DY/E=
X-Google-Smtp-Source: ALg8bN7vWxUp46zVTLsiadiH8y0zquk4m8rzMk8e+zfqwL/X/eTuBX6xuma+zuTHUhLZSUJjIV1rlA==
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr1524269lje.110.1546966568574; 
 Tue, 08 Jan 2019 08:56:08 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
 by smtp.googlemail.com with ESMTPSA id f8sm14687989lfe.72.2019.01.08.08.56.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 08:56:07 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH v2 1/4] ARM: dts: s5pv210: aries: Add reserved memory for mfc
Date: Tue,  8 Jan 2019 17:55:58 +0100
Message-Id: <20190108165601.25708-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_085610_726524_1C5CE090 
X-CRM114-Status: GOOD (  12.63  )
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
 linux-samsung-soc@vger.kernel.org, xc-racer2@live.ca, linux@armlinux.org.uk,
 robh+dt@kernel.org, linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org, pawel.mikolaj.chmiel@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VEhpcyBjb21taXQgYWRkcyBtZW1vcnkgcmVzZXJ2YXRpb24gcmVxdWlyZWQgYnkgTUZDIHRvIHJ1
bi4KT24gUzVQVjIxMCBib3RoIHJlZ2lvbnMgbmVlZHMgdG8gYmUgb24gc2VwYXJhdGUgbWVtb3J5
IGJhbmtzLgpTaXplIG9mIGJvdGggcmVnaW9ucyBpcyB0YWtlbiBmcm9tIHN0b2NrIHNvdXJjZXMu
CgpTaWduZWQtb2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFp
bC5jb20+Ci0tLQpDaGFuZ2VzIGZyb20gdjE6CiAgIC0gRml4ZWQgbmFtZSBvZiBub2RlcyB0byBi
ZSBtb3JlIGdlbmVyaWMKLS0tCiBhcmNoL2FybS9ib290L2R0cy9zNXB2MjEwLWFyaWVzLmR0c2kg
fCAyMiArKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAtYXJpZXMuZHRzaSBi
L2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAtYXJpZXMuZHRzaQppbmRleCA1NzUwOTRlYTcwMjQu
Ljg5NTI1ZTU2Y2M3YyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC1hcmll
cy5kdHNpCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3M1cHYyMTAtYXJpZXMuZHRzaQpAQCAtMjMs
NiArMjMsMjQgQEAKIAkJCTB4NTAwMDAwMDAgMHgwODAwMDAwMD47CiAJfTsKIAorCXJlc2VydmVk
LW1lbW9yeSB7CisJCSNhZGRyZXNzLWNlbGxzID0gPDE+OworCQkjc2l6ZS1jZWxscyA9IDwxPjsK
KwkJcmFuZ2VzOworCisJCW1mY19sZWZ0OiByZWdpb25ANDMwMDAwMDAgeworCQkJY29tcGF0aWJs
ZSA9ICJzaGFyZWQtZG1hLXBvb2wiOworCQkJbm8tbWFwOworCQkJcmVnID0gPDB4NDMwMDAwMDAg
MHgyMDAwMDAwPjsKKwkJfTsKKworCQltZmNfcmlnaHQ6IHJlZ2lvbkA1MTAwMDAwMCB7CisJCQlj
b21wYXRpYmxlID0gInNoYXJlZC1kbWEtcG9vbCI7CisJCQluby1tYXA7CisJCQlyZWcgPSA8MHg1
MTAwMDAwMCAweDIwMDAwMDA+OworCQl9OworCX07CisKIAl3aWZpX3B3cnNlcTogd2lmaS1wd3Jz
ZXEgewogCQljb21wYXRpYmxlID0gIm1tYy1wd3JzZXEtc2ltcGxlIjsKIAkJcmVzZXQtZ3Bpb3Mg
PSA8JmdwZzEgMiBHUElPX0FDVElWRV9MT1c+OwpAQCAtMzI5LDYgKzM0NywxMCBAQAogCXN0YXR1
cyA9ICJva2F5IjsKIH07CiAKKyZtZmMgeworCW1lbW9yeS1yZWdpb24gPSA8Jm1mY19sZWZ0Piwg
PCZtZmNfcmlnaHQ+OworfTsKKwogJnBpbmN0cmwwIHsKIAl3bGFuX2J0X2VuOiB3bGFuLWJ0LWVu
IHsKIAkJc2Ftc3VuZyxwaW5zID0gImdwYi01IjsKLS0gCjIuMTcuMQoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

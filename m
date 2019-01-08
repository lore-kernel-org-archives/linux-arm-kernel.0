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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9DEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE54214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMJVci4k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTARVH//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE54214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2+h+f04B2MiKqeixZPU6H9oFAThYRVFUPGz0UQb5qQw=; b=BMJVci4kqjecVi
	7w9aT3IJSq1xE8R8WTcOIdmhMKJYlUlCETJy6VJXPoDxRq4dAIBi5fdarobAvFGAVHw9uc71hngUt
	jh+NF1hilH6PD9KR6QuTt/HXtYkOdFhUSgaoAQBv5VepLPAeDEjqNp4q1CZlqsd/X//SYZhFW8n5a
	8Fov1kafy+g8JzVRtQQww22AyjAie8i31m0IO5s7t/toQRmSyO4z9asM7K8ep4FtE6EFg+VSWqjwP
	dxxXXRw8zn9a0IBJgKgAixSYe/ow9RknpPNNfEdvM+ZR+ftsNiH+hfehSi6iHoql827C1CqXUtn8v
	XwxpvNp1oaubZe8cO+EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggugI-0003np-2e; Tue, 08 Jan 2019 16:56:46 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggufk-0003EJ-K8
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:56:15 +0000
Received: by mail-lj1-x242.google.com with SMTP id s5-v6so3972693ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 08:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qm3kH8GLO1p5FL1um7ZtOZvte6VCmWdydXR6NoeZ7Es=;
 b=PTARVH//VPLb0I7s9ocf3yJDeoJ04KDwRavID8/SLagPu12NsGewW+ABBZ6oHvJTSD
 91D4Ccl8o6lvT4vrtcTFs+CJTlKHItURlb7tpgZnWGYRgsGRPLmaReJfOdFEufZrs68w
 nyFj7U7QC83xEVwh2xePFImRJNo5fA2jL4dJ+VWFx8RQqNBt9RUa8dhW65PPjlG/ZffE
 kYR+fk6XHXwYdr8HGhf6ezATOPewu9dEkOcvAVQAtv4Ki6vdXEKLVXzKCAwWSrcnJkzW
 r0UKOFPBkgB5iViAH8GmQlI7ynH7P4MR0YPPB7lBjlNCpIwPVTgTeqBTr7oDA5c84N0O
 d71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qm3kH8GLO1p5FL1um7ZtOZvte6VCmWdydXR6NoeZ7Es=;
 b=Ft1Kpl+A3Z1SbUVzl8ja8v9l7lqEPlTKe89nDSbYPRWfdUc+IQfa9YMDNT61+ZvY73
 tVdc78TYOjjtqaQZmYHibR9o/hjt97egRWGgm+5m1XdLixgIewV1lTLyeRnvDqgbWaiL
 /1Dg9WS3psEliqKJY6u0zui0JQUj+YP7a20dBjEGmHfpTdvJL5BpM2t40uTKjDZyNeZ0
 /3sqvKdHsmQCZx2Z55giAWhf2SIKJr/LvpXPydvOogVZz33OybG8nNUEnx2Tz9j+Cfhk
 /SSRa3Tb12AG1GEBDfY4j463s94xCE3f5eMZjgYaBpqR+0Yl1zs7OkkCrusbajaCv/7O
 X9RQ==
X-Gm-Message-State: AJcUukdCZnSjxpQz454b+eX17M4NTF3I+TTZEgVReu1JFV88kGfhYtGA
 TFz4ct7ifjFBVnvacnKlgpvcmnHdXbzfxQ==
X-Google-Smtp-Source: ALg8bN5ypCyCaYzp2SMDRfXA5h7gGHj23xEwXr7w7+m7MR6ORyDTkUXHkyqkZeO4NVSH0INbnkPjyA==
X-Received: by 2002:a2e:568d:: with SMTP id
 k13-v6mr1558880lje.105.1546966570457; 
 Tue, 08 Jan 2019 08:56:10 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
 by smtp.googlemail.com with ESMTPSA id f8sm14687989lfe.72.2019.01.08.08.56.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 08:56:09 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: krzk@kernel.org
Subject: [PATCH v2 2/4] ARM: dts: s5pv210: aries: Support for more devices
 present on Aries
Date: Tue,  8 Jan 2019 17:55:59 +0100
Message-Id: <20190108165601.25708-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_085612_873194_BE9B9EDF 
X-CRM114-Status: GOOD (  14.13  )
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

RnJvbTogSm9uYXRoYW4gQmFra2VyIDx4Yy1yYWNlcjJAbGl2ZS5jYT4KClRoaXMgY29tbWl0IGVu
YWJsZXMgZm9sbG93aW5nIGRldmljZXMgcHJlc2VudCBvbiBBcmllcyBiYXNlZCBwaG9uZXM6Ci0g
cHdtLXZpYnJhdG9yIGF0dGFjaGVkIHRvIFBXTSAxCi0gcG93ZXJvZmYgc3VwcG9ydAotIEF0bWVs
IG1hWFRvdWNoIHRvdWNoc2NyZWVuLCBjb25uZWN0ZWQgdG8gaTJjMgotIEJyb2FkY29tIEJDTTQz
MjkgYmx1ZXRvb3RoIG92ZXIgdWFydDAKClNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEJha2tlciA8
eGMtcmFjZXIyQGxpdmUuY2E+ClNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBhd2VsLm1p
a29sYWouY2htaWVsQGdtYWlsLmNvbT4KLS0tCkNoYW5nZXMgZnJvbSB2MToKICAgLSBUb3VjaHNj
cmVlbiBpcnEgcGluIHNob3VsZCBoYXZlIFBVTExfTk9ORSwgc2luY2UgaXQncyBhbHJlYWR5CiAg
ICAgcHVsbGVkIHVwIHdpdGggMi44dgogICAtIFRvdWNoc2NyZWVuIGlycSBzaG91bGQgYmUgZWRn
ZSBmYWlsaW5nIChsaWtlIGluIHZlbmRvciBzb3VyY2VzKQotLS0KIGFyY2gvYXJtL2Jvb3QvZHRz
L3M1cHYyMTAtYXJpZXMuZHRzaSB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvczVwdjIxMC1hcmllcy5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvczVwdjIxMC1hcmll
cy5kdHNpCmluZGV4IDg5NTI1ZTU2Y2M3Yy4uOGZmNzBiODU2MzM0IDEwMDY0NAotLS0gYS9hcmNo
L2FybS9ib290L2R0cy9zNXB2MjEwLWFyaWVzLmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMv
czVwdjIxMC1hcmllcy5kdHNpCkBAIC00MSw2ICs0MSwxMyBAQAogCQl9OwogCX07CiAKKwl2aWJy
YXRvcl9wd3I6IHJlZ3VsYXRvci1maXhlZC0wIHsKKwkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3It
Zml4ZWQiOworCQlyZWd1bGF0b3ItbmFtZSA9ICJ2aWJyYXRvci1lbiI7CisJCWVuYWJsZS1hY3Rp
dmUtaGlnaDsKKwkJZ3BpbyA9IDwmZ3BqMSAxIEdQSU9fQUNUSVZFX0hJR0g+OworCX07CisKIAl3
aWZpX3B3cnNlcTogd2lmaS1wd3JzZXEgewogCQljb21wYXRpYmxlID0gIm1tYy1wd3JzZXEtc2lt
cGxlIjsKIAkJcmVzZXQtZ3Bpb3MgPSA8JmdwZzEgMiBHUElPX0FDVElWRV9MT1c+OwpAQCAtMzE0
LDYgKzMyMSwyMiBAQAogCQkJcmVnID0gPDB4MzY+OwogCQl9OwogCX07CisKKwl2aWJyYXRvcjog
cHdtLXZpYnJhdG9yIHsKKwkJY29tcGF0aWJsZSA9ICJwd20tdmlicmF0b3IiOworCQlwd21zID0g
PCZwd20gMSA0NDY0MiAwPjsKKwkJcHdtLW5hbWVzID0gImVuYWJsZSI7CisJCXZjYy1zdXBwbHkg
PSA8JnZpYnJhdG9yX3B3cj47CisJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CisJCXBpbmN0
cmwtMCA9IDwmcHdtMV9vdXQ+OworCX07CisKKwlwb3dlcm9mZjogc3lzY29uLXBvd2Vyb2ZmIHsK
KwkJY29tcGF0aWJsZSA9ICJzeXNjb24tcG93ZXJvZmYiOworCQlyZWdtYXAgPSA8JnBtdV9zeXNj
b24+OworCQlvZmZzZXQgPSA8MHg2ODFjPjsgLyogUFNfSE9MRF9DT05UUk9MICovCisJCXZhbHVl
ID0gPDB4NTIwMD47CisJfTsKIH07CiAKICZmaW1kIHsKQEAgLTM0Nyw2ICszNzAsMjMgQEAKIAlz
dGF0dXMgPSAib2theSI7CiB9OwogCismaTJjMiB7CisJc2Ftc3VuZyxpMmMtc2RhLWRlbGF5ID0g
PDEwMD47CisJc2Ftc3VuZyxpMmMtbWF4LWJ1cy1mcmVxID0gPDQwMDAwMD47CisJc2Ftc3VuZyxp
MmMtc2xhdmUtYWRkciA9IDwweDEwPjsKKwlzdGF0dXMgPSAib2theSI7CisKKwl0b3VjaHNjcmVl
bkA0YSB7CisJCWNvbXBhdGlibGUgPSAiYXRtZWwsbWF4dG91Y2giOworCQlyZWcgPSA8MHg0YT47
CisJCWludGVycnVwdC1wYXJlbnQgPSA8JmdwajA+OworCQlpbnRlcnJ1cHRzID0gPDUgSVJRX1RZ
UEVfRURHRV9GQUxMSU5HPjsKKwkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKKwkJcGluY3Ry
bC0wID0gPCZ0c19pcnE+OworCQlyZXNldC1ncGlvcyA9IDwmZ3BqMSAzIEdQSU9fQUNUSVZFX0hJ
R0g+OworCX07Cit9OworCiAmbWZjIHsKIAltZW1vcnktcmVnaW9uID0gPCZtZmNfbGVmdD4sIDwm
bWZjX3JpZ2h0PjsKIH07CkBAIC0zNzIsNiArNDEyLDEzIEBACiAJCXNhbXN1bmcscGluLWRydiA9
IDxFWFlOT1M0X1BJTl9EUlZfTFYxPjsKIAl9OwogCisJYnRfaG9zdF93YWtlOiBidC1ob3N0LXdh
a2UgeworCQlzYW1zdW5nLHBpbnMgPSAiZ3BoMi01IjsKKwkJc2Ftc3VuZyxwaW4tZnVuY3Rpb24g
PSA8RVhZTk9TX1BJTl9GVU5DX0lOUFVUPjsKKwkJc2Ftc3VuZyxwaW4tcHVkID0gPFMzQzY0WFhf
UElOX1BVTExfRE9XTj47CisJCXNhbXN1bmcscGluLWRydiA9IDxFWFlOT1M0X1BJTl9EUlZfTFYx
PjsKKwl9OworCiAJdGZfZGV0ZWN0OiB0Zi1kZXRlY3QgewogCQlzYW1zdW5nLHBpbnMgPSAiZ3Bo
My00IjsKIAkJc2Ftc3VuZyxwaW4tZnVuY3Rpb24gPSA8RVhZTk9TX1BJTl9GVU5DX0lOUFVUPjsK
QEAgLTM4NCw2ICs0MzEsMTcgQEAKIAkJc2Ftc3VuZyxwaW4tZnVuY3Rpb24gPSA8RVhZTk9TX1BJ
Tl9GVU5DX09VVFBVVD47CiAJCXNhbXN1bmcscGluLXB1ZCA9IDxTM0M2NFhYX1BJTl9QVUxMX05P
TkU+OwogCX07CisKKwl0c19pcnE6IHRzLWlycSB7CisJCXNhbXN1bmcscGlucyA9ICJncGowLTUi
OworCQlzYW1zdW5nLHBpbi1mdW5jdGlvbiA9IDxFWFlOT1NfUElOX0ZVTkNfSU5QVVQ+OworCQlz
YW1zdW5nLHBpbi1wdWQgPSA8UzNDNjRYWF9QSU5fUFVMTF9OT05FPjsKKwkJc2Ftc3VuZyxwaW4t
ZHJ2ID0gPEVYWU5PUzRfUElOX0RSVl9MVjE+OworCX07Cit9OworCismcHdtIHsKKwlzYW1zdW5n
LHB3bS1vdXRwdXRzID0gPDE+OwogfTsKIAogJnNkaGNpMSB7CkBAIC00MjEsNiArNDc5LDE2IEBA
CiAKICZ1YXJ0MCB7CiAJc3RhdHVzID0gIm9rYXkiOworCisJYmx1ZXRvb3RoIHsKKwkJY29tcGF0
aWJsZSA9ICJicmNtLGJjbTQzNDM4LWJ0IjsKKwkJbWF4LXNwZWVkID0gPDExNTIwMD47CisJCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CisJCXBpbmN0cmwtMCA9IDwmdWFydDBfZGF0YSAmdWFy
dDBfZmN0bCAmYnRfaG9zdF93YWtlPjsKKwkJc2h1dGRvd24tZ3Bpb3MgPSA8JmdwYiAzIEdQSU9f
QUNUSVZFX0hJR0g+OworCQlkZXZpY2Utd2FrZXVwLWdwaW9zID0gPCZncGczIDQgR1BJT19BQ1RJ
VkVfSElHSD47CisJCWhvc3Qtd2FrZXVwLWdwaW9zID0gPCZncGgyIDUgR1BJT19BQ1RJVkVfSElH
SD47CisJfTsKIH07CiAKICZ1YXJ0MSB7Ci0tIAoyLjE3LjEKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

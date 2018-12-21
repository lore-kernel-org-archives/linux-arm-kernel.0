Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CFBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:13:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624522190A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ILkHiOBe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tcHZIDOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624522190A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b4w3uuaZHvHZ9i7KrtxePfhjXytICkhEO2B5fWFfCCk=; b=ILkHiOBeI5qL8F
	zGjO5m2j5gw/1pb0vyo+JeJOGVXRAvVvLqx2/3ZYfteuCsESo86ojjVskIIOhxLjBHXdsvJ9PtH6a
	qDwPJG7uCwsgW6VjWv0kdnoQP03PExf8+M2FTMX7H1tQ7e9AMYFnYgt+rjwJ6WK83vgb/pXm5Lebh
	C62Mrzah4hIVABOljA8jvtVNLZ64qiawcnIO8XVXlRb0cdbihPFDfsfN7VpIzCFOQoHyxyaTmSr2u
	Gzoc7KTZ+77qFE0nygTMLjKQaoxS8qUG4+aEPIEO/0d47dhtRCycdiFOydPEgJA68YGpwg0bx7rN6
	V+6JRHY7Cx1F1Wp0L3Ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaTzI-0003lm-On; Fri, 21 Dec 2018 23:13:48 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaTzC-0003ke-UG
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 23:13:45 +0000
Received: by mail-pl1-x642.google.com with SMTP id a14so3108319plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 15:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=abNvcfy0ctwrO6xXPJ7uMEdhM3z3GEhCvmRhA5UceKM=;
 b=tcHZIDOAf8qwEnDqgyFQBCg2PO+jkbmB4Snxs25toGXyH/Sl/kyhbjY9Y0LYxo6L/A
 YNbAamxPkJXABrQ88ylxJf3kkLc7ft4A1k4TC+CAqGuILo3j4RQYTIu0DKwkZtcw70ye
 ZZidxKoy80WEg57BgkP9+kPTiVizhKokElImOSdq4s896SU3CSSXsYoymcZE51GObqin
 sjQjBQdk16XRBVjixHc6aMlWQa3hiRaV0J2nP6FP5be0Pg7NDK70DwCNEHgNi59QAfTt
 Dv0sGTGVQZ5EH+nXyOzP557rRER+BDabVJV84AGduDh8j7e/JQKemwE/4C1Xcv+O+Zul
 zHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=abNvcfy0ctwrO6xXPJ7uMEdhM3z3GEhCvmRhA5UceKM=;
 b=ato0qcxFzabh74R/g4iJqWIqCRONcJxjTnf78mcfqEtqk66hsH+roJa/tAcVUc6GKi
 +KwItrloLmntuUblnJlkeRLD0jQEu767MCFzUYIAInHI2wugR2pCIYkavIQVtqSrH7f0
 aRqREi2gm6tu9BEqGa4IAJ+Zy8rNIwPqQcP1Edrr1RKZEGB9nn29Aqp6fIXBySPweca2
 ItD7bdJo52o+ueYNQr3rT6DgKxGFgu1mV+sjeKbuXxuqw6jKH2nHpYx2iZL0LlTery8l
 pIkBuMsu5e4RlRtbKVqwx0wZNUG4Sahdt3WMi7XkMIdgCrnWQjWk/IAa4f7U4NV0EOeG
 tlWg==
X-Gm-Message-State: AJcUukcKttDKWwatGBSbkt6tQW1VQJn6gw6U1HY0sq+L0o/8l9xXycN+
 O65F65ONp9PTZ17v92QJv+AqEg==
X-Google-Smtp-Source: ALg8bN496KpvbHJMgz+XL8XdPMKdcOPCPMKCswFD4JaPDzF+m6Hjcd+GX0wSq9e7l221G9l9sqB5YQ==
X-Received: by 2002:a17:902:7044:: with SMTP id
 h4mr4378935plt.35.1545434011051; 
 Fri, 21 Dec 2018 15:13:31 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:4dea:8076:74d1:94e1])
 by smtp.googlemail.com with ESMTPSA id 84sm51968092pfa.115.2018.12.21.15.13.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 15:13:30 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Chris Moore <moore@free.fr>, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: add amediatech x96-max
 bindings
In-Reply-To: <dc14926f-4433-fa7b-311f-cb275a7e7aee@free.fr>
References: <20181219233519.35287-1-khilman@baylibre.com>
 <dc14926f-4433-fa7b-311f-cb275a7e7aee@free.fr>
Date: Fri, 21 Dec 2018 15:13:29 -0800
Message-ID: <7hr2eaqxra.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_151343_270735_3E613744 
X-CRM114-Status: GOOD (  11.58  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Q2hyaXMgTW9vcmUgPG1vb3JlQGZyZWUuZnI+IHdyaXRlczoKCj4gSGksCj4KPiBTb3JyeSBmb3Ig
dGhlIHJlcGVhdCA6IEkgcmVwbGllZCBwcmV2aW91c2x5IHRvIHYxIGFzIEkgaGFkbid0IG5vdGlj
ZWQgCj4gdGhhdCB0aGVyZSB3YXMgYWxyZWFkeSBhIHYyLgo+Cj4gTGUgMjAvMTIvMjAxOCDDoCAw
MDozNSwgS2V2aW4gSGlsbWFuIGEgw6ljcml0wqA6Cj4+IEFkZCBuZXcgdmVuZG9yIGZvciBhbWVk
aWF0ZWNoLCBhbmQgaW5pdGlhbCBib2FyZDogeDk2LW1heAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBL
ZXZpbiBIaWxtYW4gPGtoaWxtYW5AYmF5bGlicmUuY29tPgo+PiAtLS0KPj4gICBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FtbG9naWMudHh0ICAgICB8IDEgKwo+PiAgIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0IHwgMSAr
Cj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYW1sb2dpYy50eHQgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FtbG9naWMudHh0Cj4+IGluZGV4IDhk
YmMyNTkwODFlNC4uYzUwYjA4NGI2YzU5IDEwMDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2FtbG9naWMudHh0Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYW1sb2dpYy50eHQKPj4gQEAgLTk5LDYgKzk5LDcgQEAg
Qm9hcmQgY29tcGF0aWJsZSB2YWx1ZXMgKGFscGhhYmV0aWNhbGx5LCBncm91cGVkIGJ5IFNvQyk6
Cj4+ICAgICAtICJhbWxvZ2ljLHAyODEiIChNZXNvbiBneGwgczkwNXcpCj4+ICAgICAtICJvcmFu
dGgsdHgzLW1pbmkiIChNZXNvbiBneGwgczkwNXcpCj4+ICAgCj4+ICsgIC0gImFtZWRpYXRlY2gs
eDk2LW1heCIgKE1lc29uIGd4bSBzOTEyKQo+Cj4gU2hvdWxkbid0IHRoYXQgYmUgTWVzb24gZzEy
YSBzOTA1eDIgPwoKVWdoLCB5ZXMuICBMYXp5IGNvcHkvcGFzdGUgYnVnLiAgV2lsbCBmaXggdGhh
dCBpbiBhIHYzIG5leHQgeWVhci4gOikKClRoYW5rcyBmb3IgdGhlIHJldmlldywKCktldmluCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==

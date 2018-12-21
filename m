Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8687C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:15:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E4C21906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F+y8t0Eo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TM13oeX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E4C21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RYqdNfvhRg/wcIeIxYtl0asMMx7M5+bj6o4gxwUL4sE=; b=F+y8t0Eocqq7kJ
	x0Fylha3ksVx7yAizRzN0qVe8EoVuaRTg99wBRHxKMTczyhayZmgkrxKFIoEaBD3Lx4jFMJ2JuOAq
	zzysIvPe/G9/9Ldz13hebgytf/IRkdXr8IOb+p+o9/NfUznZJk1i6GK6vRvAP1IS91DCbvOe5LwOw
	Ry+ARFEk+qVbZPrUUiPPDE8OeMCUm2FN2ZcZw/sorcDdsQDMwcdQqo54rVU7HKwVFtyK9juQIEcmU
	QTJkkOwZzHgYO9AT0imcwJ+qYxX5m4Jvx5ABmw1gioSj/MhHG7/hknMfH39UqMa+j9sR51cxkqT6u
	g90643M/VK/iC+q/N/ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaF1n-0006T2-IC; Fri, 21 Dec 2018 07:15:23 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaF1k-0006Bc-Cq
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:15:21 +0000
Received: by mail-wr1-x441.google.com with SMTP id v13so4105749wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6Y999tZFT4KVowGELbP8C8GTRfZSF77FOo8O93TvjWE=;
 b=TM13oeX8/ojpm0DGwVB+zJTWSYmX0uEuJpuKlsjuJREnP4QSE4knUu4USgNhfA7fuO
 JH6mN7ibY1CqyIkFeAle0XMQNOC+eKClAi5+3mqI8CqRQU6foK6Gsg5uGJVywklPnzhU
 ZKW8k4a4Uvr9XWJuxMs3PrEmBGL7N1s4DslNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6Y999tZFT4KVowGELbP8C8GTRfZSF77FOo8O93TvjWE=;
 b=Dkfjkvj5x/Lsh8r3a/UD6mP155GsZB6KM02/wg+08Vln8Chapmb7cwff7HFM/wGPOT
 19fgyi+CQUH9S3ufmuK95kqP+EXFWE+jHroFpPZKNm0C94zRkYzlsEa62YAYWlMPkgOj
 5JNThm3LDId1nwJxMCwE04TZmcdNp5rJkec8Qy1PX+sAWM61rD99bS819Wju9t/DS31q
 3okt1wfNvyxGGxnKqYXr/Ly6tZwH0wheuHuLmzEFJAQTfaBUNOvua29E5kLhjSYgRcOM
 vtohVVFNdTwphJgauOq2oI+puS3dgmzG05J0s42iAcARoYUPebScYDMpgXlWzJDEATQU
 As7Q==
X-Gm-Message-State: AJcUukfZI1JurK+2xpZIIbLfdjVo2wSh4803WN27KFblE45ti9Q+G6OX
 3Wq4IUhezOC8Mc+0i6FDD4bLSA==
X-Google-Smtp-Source: ALg8bN7TBdc1qH89yzLvwkAJgAemjrA3k7EQ/vErm4YNlhVkQxgp0RyXuKg6BXnY2IygHHMp7JkxuQ==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr1238879wrv.121.1545376508086; 
 Thu, 20 Dec 2018 23:15:08 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id a1sm13838089wrw.76.2018.12.20.23.15.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 23:15:07 -0800 (PST)
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM
 domains
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org>
 <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
 <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com>
 <c5587b35-734c-5c1d-a433-ce78c8583ef1@linaro.org>
 <CAPDyKFqdeSm56hVB+9dwJekNhZU10DE+-WaWa4m=wdUmjAdAdw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <66f0871e-fd1d-2f9a-13ce-1164c04e65ca@linaro.org>
Date: Fri, 21 Dec 2018 08:15:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqdeSm56hVB+9dwJekNhZU10DE+-WaWa4m=wdUmjAdAdw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_231520_439525_8C33C699 
X-CRM114-Status: GOOD (  19.93  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAvMTIvMjAxOCAyMjozNywgVWxmIEhhbnNzb24gd3JvdGU6Cj4gT24gVGh1LCAyMCBEZWMg
MjAxOCBhdCAxOTowNiwgRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+
IHdyb3RlOgo+Pgo+PiBPbiAyMC8xMi8yMDE4IDE2OjQ5LCBVbGYgSGFuc3NvbiB3cm90ZToKPj4K
Pj4gWyAuLi4gXQo+Pgo+Pj4+PiArI2lmZGVmIENPTkZJR19DUFVfSURMRQo+Pj4+Cj4+Pj4gSXQg
d291bGQgYmUgbmljZXIgaWYgeW91IGNhbiByZW1vdmUgdGhlIENPTkZJR19DUFVfSURMRSBieSBy
ZXBsYWNpbmcgaXQKPj4+PiB3aXRoIGEgc3BlY2lmaWMgb25lIChlZy4gQ09ORklHX1BTQ0lfSURM
RSkgYW5kIG1ha2UgaXQgZGVwZW5kIG9uCj4+Pj4gQ09ORklHX0NQVV9JRExFLCBzbyB0aGUgY29u
ZmlnIG9wdGlvbnMgc3RheSBjb250YWluZWQgaW4gdGhlaXIKPj4+PiByZXNwZWN0aXZlIHN1YnN5
c3RlbXMgZGlyZWN0b3J5Lgo+Pj4KPj4+IEkgYW0gYWxsIGZvciBzaW1wbGlmeWluZyB0aGUgS2Nv
bmZpZyBvcHRpb25zIGluIGhlcmUsIGFzIGluZGVlZCBpdCdzCj4+PiByYXRoZXIgbWVzc3kuIEhv
d2V2ZXIsIEkgd291bGQgcmF0aGVyIGF2b2lkIGZvbGRpbmcgaW4gYWRkaXRpb25hbAo+Pj4gY2xl
YW51cCBjaGFuZ2VzIHRvIHRoaXMgc2VyaWVzLCBpcyBhbHJlYWR5IGV4dGVuc2l2ZSBlbm91Z2gu
Cj4+Pgo+Pj4gV291bGQgeW91IGJlIG9rYXkgaWYgd2UgZGVhbCB3aXRoIHRoYXQgb24gdG9wPwo+
Pgo+PiBJTU8sIHRoZXJlIGFyZSBwYXRjaGVzIGluIHRoaXMgc2VyaWVzIHdoaWNoIGNhbiBiZSBn
cm91cGVkIGludG8gYQo+PiBjbGVhbnVwICsgc2V0IHRoZSBzY2VuZSBwYXRjaHNldCBhbmQgbWVy
Z2VkIGltbWVkaWF0ZWx5LiBBbiBvcHRpb24KPj4gc2ltaWxhciB0byBBUk1fU0NNSV9QT1dFUl9E
T01BSU4gY2FuIGJlIHBhcnQgb2YgaXQuCj4gCj4gSSBjZXJ0YWlubHkgYWdyZWUgdG8gdGhhdC4g
VGhlIHRyaWNreSBpcywgdG8ga25vdyB3aGF0IHBpZWNlcyBwZW9wbGUKPiBhcmUgaGFwcHkgd2l0
aCB0byBnbyBpbi4gOi0pCj4gCj4gRWFybGllciwgaW4gdjkgSSB0cmllZCB5b3VyIHN1Z2dlc3Rl
ZCBhcHByb2FjaCAoa2luZCBvZiksIGJ1dCB0aGVuCj4gTG9yZW56byBzdGF0ZWQgdGhhdCBpdCdz
IGtpbmQgb2YgYWxsIG9yIG5vdGhpbmcuIE1heWJlIHdlIGNhbiBicmluZyB1cAo+IHRoYXQgZGlz
Y3Vzc2lvbiBhZ2FpbiB3aXRoIGhpbSBhbmQgc2VlIHdoYXQgd2UgY2FuIGZpZ3VyZSBvdXQuCj4g
Cj4+Cj4+IEhvd2V2ZXIsIGlmIHlvdSBzd2VhciB5b3Ugd2lsbCBkbyB0aGUgY2hhbmdlIGFmdGVy
IGFuZCBzaWduIHdpdGggeW91cgo+PiBibG9vZCwgSSdtIGZpbmUgd2l0aCB0aGF0IDA6KQo+Pgo+
IAo+IFdoYXRldmVyIGl0IHRha2VzIQo+IAo+IEFueXdheSwgYXMgc3RhdGVkLCB0aGUgcmVhc29u
IHdoeSBJIHdhbnQgdG8gdGFja2xlIHRoYXQgb24gdG9wLCBpcwo+IHRoYXQgSSBkb24ndCB3YW50
IHRvIG1ha2UgdGhlIHNlcmllcyBtb3JlIGV4dGVuc2l2ZSB0aGFuIGl0IGFscmVhZHkKPiBpcy4K
PiAKPiBBZ3JlZT8KClllcwoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9y
ZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAg
PGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDov
L3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5v
cmcvbGluYXJvLWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

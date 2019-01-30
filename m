Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F35C282D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:44:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A8820869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gSwhKE71";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MF08K1N/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A8820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OpvxFM5Y+06xU76Gq3Q2ByDl9ChlauLUdxqWBf5KcaU=; b=gSwhKE71S31omd
	Ws+D4g7ZWryVvTeGj9XMLPeXG2B/1Wj3txYDKrdzPwS/sYmRXbyKzLm8fShdlJZApORk8wOCNxfUx
	qDiimJZrAkAH06ZJAxJ9ra8akLt/x1WBKeD8EfbXX5XDIyua4XUI3oKVoJv7Q2iPBP/fMRjTkAYPB
	USAc+Z7gTt2axa3Gj2PI2H5o8QdIQ2NifdFDaRZIeJYj21SYXR2cskMDvRjPBzGKfHp4csAhSXBSk
	lUBwMRZC7jtci+t1Vzl6aTNGGk65aIE6+Jf/DOmZySDQOIrp+pmwTh2JmfE0QsfLDpbsrmYzF/4Gb
	xkVbrOc8eDKgQV+H6p0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gokY8-0005QL-4V; Wed, 30 Jan 2019 07:44:44 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gokY3-0005P3-T7
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 07:44:41 +0000
Received: by mail-wr1-x442.google.com with SMTP id s12so24857302wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 23:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X4QCf+1aoDy366tLdrMDAEPagCHQZQgMBcUSlcgghUw=;
 b=MF08K1N/yysxuch0gDLytcVb4nyipvQoeLO0UEoO7ZgkE6iICkQlj1PVmsYMRRKISh
 4u7NMtuiJAX05C+FeNzFdu5NtQEICje2nF3CeBqE0Qjoc/YPNJ2ssbb52oPp/M8vkPGl
 yeo9NwGD6DwCo1MB/+kD27xOEbQ1yNSmt6gjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X4QCf+1aoDy366tLdrMDAEPagCHQZQgMBcUSlcgghUw=;
 b=U4IvEr2ezIrcuoRml2TQ/+WBcaHxgNBHbsrsK3zjvJbSJkc2OoJhRs1WV4gnNcfMvk
 KLx+Vwzr/nonZDuu5A4anpG+E5lGfKb3P1WuhcU0UJGPuoLvriMT2HpV1u8GsJN6OfIK
 ndfnS4wuvC6bAF07laPpmSPm6E8r/YUYhKY5GiTaBcbOx6o8nfraVLeOFl+JGwO431I9
 MLVhlTwc/YWi4GucniI2ttxLikueC5vmmVOUiCfP20r9C/xYZEiIfSxtBkZvXtz2H1tU
 9cvcOCit9mit7lhR1Lwaud+zplEnOX9ngsliXmIwpaY1ybUDicrPhJqE0NnBZ6z4ID/j
 LdOg==
X-Gm-Message-State: AHQUAuaknbJpbDe32XGK5WNonh+I2aJleYU1wcmdww29Fyo0K4N0bk/y
 Z9o9bWJ4zSuV4tOUD8ouavteUA==
X-Google-Smtp-Source: AHgI3Iakylj+iVzhLALJzuTReayxq9BWnMAXiIZ+C1YZnsmExAcA9nwkLX8acKZQ1Wwxx3AybZ6iVw==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr7013843wru.245.1548834273590; 
 Tue, 29 Jan 2019 23:44:33 -0800 (PST)
Received: from [192.168.0.41] (164.30.95.92.rev.sfr.net. [92.95.30.164])
 by smtp.googlemail.com with ESMTPSA id f191sm1034950wmg.12.2019.01.29.23.44.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 23:44:32 -0800 (PST)
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
To: Peter Shih <pihsun@chromium.org>
References: <20190109055724.184692-1-pihsun@chromium.org>
 <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
Date: Wed, 30 Jan 2019 08:44:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_234439_947889_09AAD236 
X-CRM114-Status: GOOD (  15.92  )
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
Cc: "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Michael.Kao@mediatek.com,
 Eduardo Valentin <edubezval@gmail.com>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMzAvMDEvMjAxOSAwNzowNCwgUGV0ZXIgU2hpaCB3cm90ZToKPiBBZGRpbmcgTWljaGFlbCBL
YW8gdG8gY2MgbGlzdC4KPiAKPiBPbiBXZWQsIEphbiA5LCAyMDE5IGF0IDE6NTcgUE0gUGktSHN1
biBTaGloIDxwaWhzdW5AY2hyb21pdW0ub3JnPiB3cm90ZToKPj4KPj4gVGhlIG10a190aGVybWFs
IHN0cnVjdCBjb250YWlucyBhICdzdHJ1Y3QgbXRrX3RoZXJtYWxfYmFuayBiYW5rc1tdOycsCj4+
IGJ1dCB0aGUgYWxsb2NhdGlvbiBvbmx5IGFsbG9jYXRlcyBzaXplb2Yoc3RydWN0IG10a190aGVy
bWFsKSBieXRlcywKPj4gd2hpY2ggY2F1c2Ugb3V0IG9mIGJvdW5kIGFjY2VzcyB3aXRoIHRoZSAt
PmJhbmtzW10gbWVtYmVyLiBDaGFuZ2UgaXQgdG8KPj4gYSBmaXhlZCBzaXplIGFycmF5IGluc3Rl
YWQuCgpFdmVuIGlmIHRoZSBmaXggaXMgY29ycmVjdCwgaXQgcHVzaGVzIGJhY2sgdGhlIGJ1ZyBs
YXRlciBpbiB0aW1lIGlmIGEKbmV3IGJvYXJkIGNvbnRhaW5pbmcgbW9yZSB0aGFuIE1BWF9OVU1f
Wk9ORVMgaXMgaW50cm9kdWNlZC4gSSBzdWdnZXN0IHRvCmR5bmFtaWNhbGx5IGFsbG9jYXRlIHRo
ZSBhcnJheSB3aXRoIHRoZSAnbnVtX2JhbmtzJyB2YWx1ZS4KCgo+PiBTaWduZWQtb2ZmLWJ5OiBQ
aS1Ic3VuIFNoaWggPHBpaHN1bkBjaHJvbWl1bS5vcmc+Cj4+IC0tLQo+PiAgZHJpdmVycy90aGVy
bWFsL210a190aGVybWFsLmMgfCA3ICsrKysrLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJt
YWwvbXRrX3RoZXJtYWwuYyBiL2RyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jCj4+IGluZGV4
IDA2OTFmMjYwZjZlYWJlLi5lYTExZWRiM2ZjY2VkNiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy90
aGVybWFsL210a190aGVybWFsLmMKPj4gKysrIGIvZHJpdmVycy90aGVybWFsL210a190aGVybWFs
LmMKPj4gQEAgLTE1OSw2ICsxNTksOSBAQAo+PiAgI2RlZmluZSBNVDc2MjJfTlVNX1NFTlNPUlNf
UEVSX1pPTkUgICAgMQo+PiAgI2RlZmluZSBNVDc2MjJfVFMxICAgICAwCj4+Cj4+ICsvKiBUaGUg
bWF4aW11bSBudW1iZXIgb2YgYmFua3MgKi8KPj4gKyNkZWZpbmUgTUFYX05VTV9aT05FUyAgICAg
ICAgICA4Cj4+ICsKPj4gIHN0cnVjdCBtdGtfdGhlcm1hbDsKPj4KPj4gIHN0cnVjdCB0aGVybWFs
X2JhbmtfY2ZnIHsKPj4gQEAgLTE3OCw3ICsxODEsNyBAQCBzdHJ1Y3QgbXRrX3RoZXJtYWxfZGF0
YSB7Cj4+ICAgICAgICAgY29uc3QgaW50ICpzZW5zb3JfbXV4X3ZhbHVlczsKPj4gICAgICAgICBj
b25zdCBpbnQgKm1zcjsKPj4gICAgICAgICBjb25zdCBpbnQgKmFkY3BucDsKPj4gLSAgICAgICBz
dHJ1Y3QgdGhlcm1hbF9iYW5rX2NmZyBiYW5rX2RhdGFbXTsKPj4gKyAgICAgICBzdHJ1Y3QgdGhl
cm1hbF9iYW5rX2NmZyBiYW5rX2RhdGFbTUFYX05VTV9aT05FU107Cj4+ICB9Owo+Pgo+PiAgc3Ry
dWN0IG10a190aGVybWFsIHsKPj4gQEAgLTE5Nyw3ICsyMDAsNyBAQCBzdHJ1Y3QgbXRrX3RoZXJt
YWwgewo+PiAgICAgICAgIHMzMiB2dHNbTVQ4MTczX05VTV9TRU5TT1JTXTsKPj4KPj4gICAgICAg
ICBjb25zdCBzdHJ1Y3QgbXRrX3RoZXJtYWxfZGF0YSAqY29uZjsKPj4gLSAgICAgICBzdHJ1Y3Qg
bXRrX3RoZXJtYWxfYmFuayBiYW5rc1tdOwo+PiArICAgICAgIHN0cnVjdCBtdGtfdGhlcm1hbF9i
YW5rIGJhbmtzW01BWF9OVU1fWk9ORVNdOwo+PiAgfTsKPj4KPj4gIC8qIE1UODE3MyB0aGVybWFs
IHNlbnNvciBkYXRhICovCj4+IC0tCj4+IDIuMjAuMS45Ny5nODExODhkOTNjMy1nb29nCj4+CgoK
LS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ug
c29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJv
b2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xp
bmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBC
bG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=

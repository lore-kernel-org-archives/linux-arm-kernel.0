Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E0CC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:27:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6D1217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lxRUXaLJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyYTUUKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6D1217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=itJwYApav1rR0+aAxoC1L/nJXBcw04tZbM0P07pQX+c=; b=lxRUXaLJIdi7In
	qzXsfW0WRUFQxFUxtmDh51QnjXgLi5K+i0lcYq0i+0jaPDxCDOgWa8XV81TaxuezEez4MkCaKZiyB
	eXt7XUcNvJ6uGIkYTZXTCNgE5B0hj7Nbl8QbJepMymdee0ed1/y/f1pMK+T01yia6ZZfBxKXVKnwX
	Wwq9OM/sgi1PZ/uYmULbNDXKUfuNKvDq9n/+22muwdODiZPF7yes5HZB17ITp/Kfxcu3qrF0xSgbq
	JAieFUqg9SLDcE0GksgtcFHlX5o2GPdLVLnANzTUL5cvyDluDHPSgh/sAt5RJkkXnzLa6Ncyk7fzf
	7JtxauNZTInBrMmev4CA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn78T-00077S-J4; Fri, 25 Jan 2019 19:27:29 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn78P-00076Z-8D
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 19:27:26 +0000
Received: by mail-wr1-x441.google.com with SMTP id s12so11501547wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 11:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yHXGCxDmjbrZsSgdWNb7w5Zvyp3Ii2htqo9X6kZVmSM=;
 b=fyYTUUKUIj256RFYH23wz7CgW3/X/N3F8IO+Wk62vT3YdZ0v5ydfait3ctp6AzY0cg
 SZKav9nTorDnpgiNiPDzZiPIYzkTtJUwcLjdme+s098u/Ts5KUu3KVy4q/+O+B0nj567
 zrCShL5a8WXAQXdAOOtE/09rqO9MX/F/vkUS0ksIgH2fWOat0Tr/v23nagiAe9ci4qwt
 jxQ2MJOY1iiipUHc2hc+aJDN3R2mjw1bSxhr4V93gV+tBURds+LC0lPGwsjNgp1jcqMh
 oYkE2yY7zdZPy5mTgoudLN7ew2En9yH1VTWGHk2BmQGChQft4fcWtCUSd7BsA3A2WHLR
 4zFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yHXGCxDmjbrZsSgdWNb7w5Zvyp3Ii2htqo9X6kZVmSM=;
 b=oXWIwzLbR3F77FLKF2F/MvtCoLxfoF3TtpoS8P1vW+ZpYt3bO7C+yxpvvDq4haflBw
 laYOx0DtVZHAoecVQfZyboFxGMsUNc8sBHtFxLq10zjMeaExLjr0Ulpf/sKW4sb3gcBp
 GWxOdiYimyK2QAWbIZFK89CBSbt0XrfuGNLj1o42ZsLAtpX4WmxqC9I2vmJbu9Z6rZ10
 LSwiyWA6lWEqJ8j9yxtvDrmm98miUVM8BeA1Rhnu2oDkGdxA83RMg1oKLk77LDBI2ADs
 va+vCwqJD07DuZ1AwbnxTmw3PnUmioR39KGtORgl/3fbBNWqYZ+INXy5U3U0sX6LFJ1N
 nKvw==
X-Gm-Message-State: AJcUukdJSlCF8F0UCtj9opaZbkdMtDUKheUc2KoK5xNPErCQm8NX8MS7
 WzzEs1AJ3/WOxvoJFjjGxxo=
X-Google-Smtp-Source: ALg8bN5uImpfe9d88vJ1aJWTu/orHWFXt75V8tanHMfLf3SOe2mRikJ5LHCtibgujMNy2t3wqDjlVQ==
X-Received: by 2002:adf:a14d:: with SMTP id r13mr12231732wrr.169.1548444443082; 
 Fri, 25 Jan 2019 11:27:23 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:fc07:c732:1a36:65ad?
 (p200300EA8BF1E200FC07C7321A3665AD.dip0.t-ipconnect.de.
 [2003:ea:8bf1:e200:fc07:c732:1a36:65ad])
 by smtp.googlemail.com with ESMTPSA id m21sm46013283wmi.43.2019.01.25.11.27.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 11:27:22 -0800 (PST)
Subject: Re: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
References: <20190125125513.23656-1-ccaione@baylibre.com>
 <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
 <20190125184330.dm3kaoewvbwddacy@xps>
 <a8b8e82f-2b68-ed9d-6106-0542dddc1181@gmail.com>
 <20190125191947.um4w4e5jpsv2kcxc@e5254000004ec.dyn.armlinux.org.uk>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <3e09ef54-f817-2659-4e9e-74a88a80cbcc@gmail.com>
Date: Fri, 25 Jan 2019 20:27:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125191947.um4w4e5jpsv2kcxc@e5254000004ec.dyn.armlinux.org.uk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_112725_291327_7A263FD6 
X-CRM114-Status: GOOD (  20.39  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
 devicetree@vger.kernel.org, s.hauer@pengutronix.de,
 Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, abailon@baylibre.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
 aisheng.dong@nxp.com, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjUuMDEuMjAxOSAyMDoxOSwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IGFkbWluIHdyb3Rl
Ogo+IE9uIEZyaSwgSmFuIDI1LCAyMDE5IGF0IDA4OjA3OjU2UE0gKzAxMDAsIEhlaW5lciBLYWxs
d2VpdCB3cm90ZToKPj4gT24gMjUuMDEuMjAxOSAxOTo0OCwgQ2FybG8gQ2Fpb25lIHdyb3RlOgo+
Pj4gT24gMjUvMDEvMTkgMTM6MDYsIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCBhZG1pbiB3cm90
ZToKPj4+PiBPbiBGcmksIEphbiAyNSwgMjAxOSBhdCAxMjo1NToxMFBNICswMDAwLCBDYXJsbyBD
YWlvbmUgd3JvdGU6Cj4+Pj4+IFNtYXJ0RUVFLCBjb21wYXRpYmxlIHdpdGggSUVFRTgwMi4zYXog
c3RhbmRhcmQsIGlzIGRlc2lnbmVkIHRvIGluY2x1ZGUKPj4+Pj4gbGVnYWN5IE1BQyB3aXRob3V0
IEVFRSBjYXBhYmlsaXR5IGludG8gdGhlIHBvd2VyIHNhdmluZyBzeXN0ZW0uIFNtYXJ0RUVFCj4+
Pj4+IGlzIGVuYWJsZWQgYnkgZGVmYXVsdCBjb25maWd1cmF0aW9uIG9uIEFSODAzMSBhZnRlciBw
b3dlci1vbiBvciBoYXJkd2FyZQo+Pj4+PiByZXNldC4KPj4+Pj4KPj4+Pj4gVW5mb3J0dW5hdGVs
eSB0aGlzIGlzIHByb3ZlZCBjYXVzaW5nIGlzc3VlcyBmb3IgY2VydGFpbiBodwo+Pj4+PiBjb25m
aWd1cmF0aW9ucy7CoCBXZSBhZGQgYSBxdWlyayB0byBvcHRpb25hbGx5IGRpc2FibGUgU21hcnRF
RUUuCj4+Pj4KPj4+PiBJdCBtYXkgYmUgYSBnb29kIGlkZWEgdG8gZGV0YWlsIHdoYXQgImNlcnRh
aW4gaHcgY29uZmlndXJhdGlvbnMiIGFyZQo+Pj4+IGFuZC9vciB3aGF0IHRoZSAiaXNzdWVzIiBh
cmUsIHNvIGl0J3MgZWFzaWVyIHRvIGZpbmQgdGhpcyBpZi93aGVuCj4+Pj4gb3RoZXJzIGVuY291
bnRlciB0aGUgc2FtZSBpc3N1ZS4KPj4+Cj4+PiBUaGlzIGZpeCB3YXMgdXBzdHJlYW1lZCBmcm9t
IHRoZSBpbXggZG93bnN0cmVhbSBrZXJuZWwgc28gSSBkbyBub3QgaGF2ZSBtdWNoIGluZm9ybWF0
aW9ucyBvbiB0aGF0IGJ1dCBzb21ldGhpbmcgaXMgcmVwb3J0ZWQgaW4gdGhlIFUtQm9vdCBmaXgg
Zm9yIHRoZSBzYW1lIHByb2JsZW0gYXQgWzBdIHNvIEknbGwgYWRkIG1vcmUgaW5mbyBpbiB0aGUg
bmV4dCByZXZpc2lvbi4KPj4+Cj4+PiBDaGVlcnMsCj4+Pgo+Pj4gWzBdIGh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcGF0Y2gvMTAxNTc4My8KPj4+Cj4+IFRoYW5rcyBmb3IgdGhlIGxpbmsu
IEFjY29yZGluZyB0byB0aGUgZGVzY3JpcHRpb24gU21hcnRFRUUgd29ya3Mgb25seSBpZgo+PiBi
b3RoIGxpbmsgcGFydG5lcnMgc3VwcG9ydCBpdCAoaGVuY2UgYXJlIEF0aGVyb3MgUEhZJ3MpLiBJ
IHdvdWxkIGFzc3VtZQo+PiB0aGF0IHRoaXMgdXN1YWxseSBpc24ndCB0aGUgY2FzZSwgc2hvdWxk
bid0IHRoZSBmZWF0dXJlIGJlIGFuIG9wdC1pbgo+PiB0aGVyZWZvcmU/Cj4gCj4gSSdtIG5vdCBj
b252aW5jZWQgYWJvdXQgdGhhdCAtIEkndmUgYmVlbiB1c2luZyBBdGhlck9TIFNtYXJ0RUVFIHdp
dGgKPiBpLk1YNiBmb3IgcXVpdGUgc29tZSB0aW1lIChJIGhhdmUgcGF0Y2hlcyB3aGljaCBhbGxv
dyBtZSB0byByZWFkIG91dAo+IHRoZSBzdGF0cyB2aWEgZXRodG9vbCwgYW5kIGNvbmZpZ3VyZSBp
dCAtIHRoZXkncmUgc3BlY2lmaWMgdG8gdGhlCj4gRkVDIGRyaXZlciB0aG91Z2guKSAgU21hcnRF
RUUgd29ya3MganVzdCBsaWtlIEVFRSBmb3IgbWUsIGFuZCBJCj4gbm90aWNlIG5vIHByb2JsZW1z
Lgo+IAo+IEkgaGF2ZSBpLk1YNiBib2FyZHMgY29ubmVjdGVkIHRvIE5ldGdlYXIgR1MxMTYgYW5k
IHNpbWlsYXIgc3dpdGNoZXMsCj4gYW5kIGFsc28gTWFydmVsbCBEU0Egc3dpdGNoZXMgb24gb3Ro
ZXIgcGxhdGZvcm1zLgo+IAo+IFRoaXMgaXMgd2h5IEkgc2FpZCBhYm92ZSBhYm91dCAibW9yZSBk
ZXRhaWwiLiAgVGhlbiBtYXliZSBmb2xrIHdvdWxkCj4ga25vdyB3aGF0IHRvIGxvb2sgZm9yIHRv
IHNlZSB3aGV0aGVyIHRoZXJlIGlzIGEgcHJvYmxlbS4KPiAKT0ssIHRoZW4gdGhlIGRlc2NyaXB0
aW9uIG9mIHRoZSByZWZlcmVuY2VkIHBhdGNoIGlzbid0IGZ1bGx5IGNvcnJlY3QKYW5kIFNtYXJ0
RUVFIGFuZCBFRUUgYXJlIHBhcnRpYWxseSBjb21wYXRpYmxlLCBhbmQgdGhlIHByb2JsZW0gaXMK
anVzdCB0aGF0IHdlIGRvbid0IGtub3cgZXhhY3RseSB0byB3aGljaCBleHRlbnQuCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

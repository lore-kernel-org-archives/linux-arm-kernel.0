Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9154C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:07:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3BB218E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K9QmOHDO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDH2s/TQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3BB218E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/UICjzE86ODGXMwg70H5CZVce8T6v44ZlrtZGyitXlU=; b=K9QmOHDORm1c+Y
	a8jocfJDOH5wfM4PboYtkqYXeD/Of99uLqWrfz383Sfu04Do+HNeVty3zjdXk9oyYogNyHsZoL4Pp
	jpSpjyWdka0CsFuNhhZmhoB5hUlQJcpgxmAqZ+TZ5hFyxFySb8MA/79feEVGRdicxfHe46d1qtmoI
	d7uTiSdVcVttJ7qzV3TwiCTVZK1HzzH4XkM2gHFHpMb6Hcl4uYyMLb5ndUyVqU2/OUMDJn1+B3Vh6
	frUDAyU0PjSq7lRyw5ho3QZv/Ka9SqbierpoFQ5U6kzcCDZiJScNhxcR2HEkWQAdduizCVclbzfIO
	kwXtUVmwDNT39/SBP3NQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga2il-0001FA-OY; Thu, 20 Dec 2018 18:06:55 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga2ig-00016E-76
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 18:06:53 +0000
Received: by mail-wr1-x441.google.com with SMTP id l9so2694584wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 10:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rOmuocn43JbtxF3XCjVijJD6+dvHI36G0VecIvd2WLo=;
 b=fDH2s/TQTgFcY+zbGO/WgAKUGEdGaRjNBwFwBanEa2SCgi6HUQacEgOv5RJkTAzx5F
 u93JziiqKbp50xl9bConDlBZCUglPr71IqlsKeV9prfMpTUG7g6/b9c/7nDwmHjLTTYM
 y/BqHu7Ox9HJoLaBNFR3nii23MmrsdokQSk7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rOmuocn43JbtxF3XCjVijJD6+dvHI36G0VecIvd2WLo=;
 b=bXKzAif3KU1FeN7JHtb7AbSioo8U1H4QXM6LGq3VW9QOa0qkR+lKDPyOgYEzdH5RIB
 eKhPFiqyC8ZYid9IZPCvdyj/g/Nv1bpFzHyR/KgIMAnpbhU3GThvixNQ3wvQcQKuhse/
 7/y5LzvtYZuXGAr1ZDE6d5353SN3m5tPICQ9Rc6XDE/BRFa4vO1XjDHs19UgqrcKBlsB
 J7nEkfo0b/OUa5nrzxLcj+0YzHP7LVwERNvGRWWzT35ASM2GeaetHbkWsuVSFKyzhqYt
 SJE4h65aSJGUeVkP+VsjZTJQeXDEinxWt4CByZ6D33JC+G2VwPs9DfyyTHEAMt1RKJQ3
 u9GQ==
X-Gm-Message-State: AA+aEWaZaU9nar/mvZIy667Mo5YDAGnvYo6k2DDKkxB3+64AtgN3qRrR
 EDi81lgO2wrKAmJvBWkp3dKi1A==
X-Google-Smtp-Source: AFSGD/WjmWkkjc+OFpkV+G4Oir6OxO8qV/smNJb3b76SKsfvNfkM8YKSQHdvnpYu7B5wNz+G4XZbxQ==
X-Received: by 2002:adf:f703:: with SMTP id r3mr23092752wrp.93.1545329198335; 
 Thu, 20 Dec 2018 10:06:38 -0800 (PST)
Received: from [192.168.0.40] (55.183.88.92.rev.sfr.net. [92.88.183.55])
 by smtp.googlemail.com with ESMTPSA id h2sm15476841wrv.87.2018.12.20.10.06.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 10:06:37 -0800 (PST)
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM
 domains
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org>
 <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
 <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c5587b35-734c-5c1d-a433-ce78c8583ef1@linaro.org>
Date: Thu, 20 Dec 2018 19:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_100650_265114_843B0860 
X-CRM114-Status: GOOD (  16.78  )
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

T24gMjAvMTIvMjAxOCAxNjo0OSwgVWxmIEhhbnNzb24gd3JvdGU6CgpbIC4uLiBdCgo+Pj4gKyNp
ZmRlZiBDT05GSUdfQ1BVX0lETEUKPj4KPj4gSXQgd291bGQgYmUgbmljZXIgaWYgeW91IGNhbiBy
ZW1vdmUgdGhlIENPTkZJR19DUFVfSURMRSBieSByZXBsYWNpbmcgaXQKPj4gd2l0aCBhIHNwZWNp
ZmljIG9uZSAoZWcuIENPTkZJR19QU0NJX0lETEUpIGFuZCBtYWtlIGl0IGRlcGVuZCBvbgo+PiBD
T05GSUdfQ1BVX0lETEUsIHNvIHRoZSBjb25maWcgb3B0aW9ucyBzdGF5IGNvbnRhaW5lZCBpbiB0
aGVpcgo+PiByZXNwZWN0aXZlIHN1YnN5c3RlbXMgZGlyZWN0b3J5Lgo+IAo+IEkgYW0gYWxsIGZv
ciBzaW1wbGlmeWluZyB0aGUgS2NvbmZpZyBvcHRpb25zIGluIGhlcmUsIGFzIGluZGVlZCBpdCdz
Cj4gcmF0aGVyIG1lc3N5LiBIb3dldmVyLCBJIHdvdWxkIHJhdGhlciBhdm9pZCBmb2xkaW5nIGlu
IGFkZGl0aW9uYWwKPiBjbGVhbnVwIGNoYW5nZXMgdG8gdGhpcyBzZXJpZXMsIGlzIGFscmVhZHkg
ZXh0ZW5zaXZlIGVub3VnaC4KPiAKPiBXb3VsZCB5b3UgYmUgb2theSBpZiB3ZSBkZWFsIHdpdGgg
dGhhdCBvbiB0b3A/CgpJTU8sIHRoZXJlIGFyZSBwYXRjaGVzIGluIHRoaXMgc2VyaWVzIHdoaWNo
IGNhbiBiZSBncm91cGVkIGludG8gYQpjbGVhbnVwICsgc2V0IHRoZSBzY2VuZSBwYXRjaHNldCBh
bmQgbWVyZ2VkIGltbWVkaWF0ZWx5LiBBbiBvcHRpb24Kc2ltaWxhciB0byBBUk1fU0NNSV9QT1dF
Ul9ET01BSU4gY2FuIGJlIHBhcnQgb2YgaXQuCgpIb3dldmVyLCBpZiB5b3Ugc3dlYXIgeW91IHdp
bGwgZG8gdGhlIGNoYW5nZSBhZnRlciBhbmQgc2lnbiB3aXRoIHlvdXIKYmxvb2QsIEknbSBmaW5l
IHdpdGggdGhhdCAwOikKCgotLSAKIDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3Jn
IOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86ICA8
aHR0cDovL3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8CjxodHRwOi8v
dHdpdHRlci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0dHA6Ly93d3cubGluYXJvLm9y
Zy9saW5hcm8tYmxvZy8+IEJsb2cKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

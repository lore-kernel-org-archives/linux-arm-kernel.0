Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7C5C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:05:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393992184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O8jVq12q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UphX7E/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393992184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cluehLPB5S3fCj0DB3magVBs0P78vl1zuqEz7lZ2wwY=; b=O8jVq12qdka/4m
	3ahwpeCS79ByohvxavaCnB23kyXfFGkqZ6DN2TjcFA7UVGynNj26igh6+UPHOmpfueNM4PHNf57q1
	1ifGkq8QAa1Md3tzg2dRSiluHAtKi7i52IzNtilQK9epRFtir37usluW706iiYxn6ZFjIbXFJ0B08
	SPjIGMdsA3S/lEC4y3seuzJtfJmnPCfyKlTeK0cpHXLYh/HFNk/Ckoed+J6eHZVTn4s0xxaRRFfOA
	g8Yh4pQ0Mpd8aZ5PY3FKL2afkcYUZDiMCQfCSO4zvfzo+ZcVHzYrEKM1wPwZjXxyNzQHIoDYP2mCV
	7Uq0/fGDy3kAY3F6FGVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gomjw-0002JA-TF; Wed, 30 Jan 2019 10:05:04 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gomjr-0002Br-5J
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 10:05:01 +0000
Received: by mail-wm1-x343.google.com with SMTP id y8so20862097wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 02:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oo1kQyMUGCUjislYa6LlOze0vrMNQ5FaLTM41ZieqG8=;
 b=UphX7E/quzi2ltMApn41JSicUG4t2G10B5oXDGv4/PHrDm+nYV12oO/oa6khUAqite
 YpGzHx2Ddj+hSrUuhGj4aUwnqwXHUUZnAGHP0ESuZt6W8AMo5FRxejjMTq2Q+I/yFbA/
 RAQqYclkyy+3PyjN7lBbU4UoWD8p6Sg2NguHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oo1kQyMUGCUjislYa6LlOze0vrMNQ5FaLTM41ZieqG8=;
 b=kt341gN2UOz/GgzfgyOd5QghqrSDCgGYjhhmC2GRdDbAC7SYJ7BejrnKsHydWIP1lF
 L7+H8FY5cNst3Xa7LGB84fwUVTTiYacE0g6qNQIbgMJZWORikrPe0hOwNTQ9Mo4mC1Zv
 dCNPj6LetVgYdbebJlT3tGNQ0WAOcGbheXcEZHp40NM5wYivQNJB3wb/vUtBSITNJZuJ
 3/wBxGSvLB36DiMZgIawi/h9lXVUemc1mf22GHS9CBjfO21k+LivDnvPMJaEuV8mLWkC
 FMhkHFkNQ4s14LKo1YNseC7LsYz4icLCnK9BKT+dIPAUDdJUXQIjfNGHUcXYMKRXXEMt
 3mFA==
X-Gm-Message-State: AJcUukeUysrFRcFtzYvWETk7CCJyjelGLxus+B8KSnB0ub8NS4kUMgxv
 buGiQ0x5FY3nmRly8egQ/4YNGw==
X-Google-Smtp-Source: ALg8bN5VdDVfSK3jkpzTR7ScNQNvZQWNx+b8Vq5n67G0YQrVb9MhxKbQlqlECx9+AZSGNsAQ5TGH3g==
X-Received: by 2002:a1c:968a:: with SMTP id
 y132mr24391391wmd.107.1548842695839; 
 Wed, 30 Jan 2019 02:04:55 -0800 (PST)
Received: from [192.168.0.41] (164.30.95.92.rev.sfr.net. [92.95.30.164])
 by smtp.googlemail.com with ESMTPSA id a1sm978712wrw.76.2019.01.30.02.04.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 02:04:55 -0800 (PST)
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
To: Pi-Hsun Shih <pihsun@chromium.org>
References: <20190109055724.184692-1-pihsun@chromium.org>
 <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
 <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
 <CANdKZ0eDwTgKoFsAOboCz=q+nsUWepecXA7wmR=jGhkWEzLvnA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <49dbd0af-975e-cafb-d1b9-4e491a6c9383@linaro.org>
Date: Wed, 30 Jan 2019 11:04:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANdKZ0eDwTgKoFsAOboCz=q+nsUWepecXA7wmR=jGhkWEzLvnA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_020459_241442_7A784E0B 
X-CRM114-Status: GOOD (  16.03  )
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

T24gMzAvMDEvMjAxOSAxMDoyNSwgUGktSHN1biBTaGloIHdyb3RlOgo+IE9uIFdlZCwgSmFuIDMw
LCAyMDE5IGF0IDM6NDQgUE0gRGFuaWVsIExlemNhbm8KPiA8ZGFuaWVsLmxlemNhbm9AbGluYXJv
Lm9yZz4gd3JvdGU6Cj4+Cj4+IE9uIDMwLzAxLzIwMTkgMDc6MDQsIFBldGVyIFNoaWggd3JvdGU6
Cj4+PiBBZGRpbmcgTWljaGFlbCBLYW8gdG8gY2MgbGlzdC4KPj4+Cj4+PiBPbiBXZWQsIEphbiA5
LCAyMDE5IGF0IDE6NTcgUE0gUGktSHN1biBTaGloIDxwaWhzdW5AY2hyb21pdW0ub3JnPiB3cm90
ZToKPj4+Pgo+Pj4+IFRoZSBtdGtfdGhlcm1hbCBzdHJ1Y3QgY29udGFpbnMgYSAnc3RydWN0IG10
a190aGVybWFsX2JhbmsgYmFua3NbXTsnLAo+Pj4+IGJ1dCB0aGUgYWxsb2NhdGlvbiBvbmx5IGFs
bG9jYXRlcyBzaXplb2Yoc3RydWN0IG10a190aGVybWFsKSBieXRlcywKPj4+PiB3aGljaCBjYXVz
ZSBvdXQgb2YgYm91bmQgYWNjZXNzIHdpdGggdGhlIC0+YmFua3NbXSBtZW1iZXIuIENoYW5nZSBp
dCB0bwo+Pj4+IGEgZml4ZWQgc2l6ZSBhcnJheSBpbnN0ZWFkLgo+Pgo+PiBFdmVuIGlmIHRoZSBm
aXggaXMgY29ycmVjdCwgaXQgcHVzaGVzIGJhY2sgdGhlIGJ1ZyBsYXRlciBpbiB0aW1lIGlmIGEK
Pj4gbmV3IGJvYXJkIGNvbnRhaW5pbmcgbW9yZSB0aGFuIE1BWF9OVU1fWk9ORVMgaXMgaW50cm9k
dWNlZC4gSSBzdWdnZXN0IHRvCj4+IGR5bmFtaWNhbGx5IGFsbG9jYXRlIHRoZSBhcnJheSB3aXRo
IHRoZSAnbnVtX2JhbmtzJyB2YWx1ZS4KPj4KPiAKPiBGb3IgdGhlIGN1cnJlbnQgY29kZSBzdHJ1
Y3R1cmUsIHRob3NlIG10a190aGVybWFsX2RhdGEgYXJlIHN0YXRpY2FsbHkgZGVjbGFyZWQsCj4g
c28gaWYgdGhlcmUncyBuZXcgYm9hcmQgY29udGFpbmluZyBtb3JlIHRoYW4gTUFYX05VTV9aT05F
UyBvZiBiYW5rX2RhdGEsIGl0Cj4gd291bGQgYWN0dWFsbHkgYmUgYSBjb21waWxlIGVycm9yLgo+
IAo+IEknbSBmaW5lIHdpdGggZWl0aGVyIHdheSwgYnV0IGZlZWwgbGlrZSB0aGF0IHRoaXMgaXMg
c2ltcGxlciB0aGFuIG1hbnVhbGx5Cj4gY2FsY3VsYXRpbmcgdGhlIHNpemUgbmVlZGVkIGZvciBh
bGxvY2F0aW9uLgoKUmlnaHQsIEkgbWlzc2VkIGl0IGNhbiBiZSBjYXVnaHQgYXQgY29tcGlsZSB0
aW1lLgoKUmV2aWV3ZWQtYnk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8u
b3JnPgoKCgotLSAKIDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3JnIOKUgiBPcGVu
IHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86ICA8aHR0cDovL3d3
dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8CjxodHRwOi8vdHdpdHRlci5j
b20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8t
YmxvZy8+IEJsb2cKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==

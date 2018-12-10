Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16463C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:37:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29B32082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YbvCIKOP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mj/tubEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29B32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/vhaSklWXxGQFOCuFk6uHIvA7aem/mSkkRaQB3u0hpY=; b=YbvCIKOPei/yhSd2kZo4KpP32
	0HLUp64F7AO5MZkla6v6cJop9uTAZaVtlOW+j8iMfI3TbygchzFgEiQRZlG/rg2ntkemOTabl44Su
	fjG9Q07R94sviX2uJIaT07ZTniF39/DoiA1Rxkp7q/SW2Wu1leUiMcfjJF6CbkbMIJUq8Q/KYATCw
	DUXC2+fSdt5S24UTVcrmN4rUI5J2nTleegPq3+bvkzuUqJnS52jXYCt3UKkvF4bnxRj4Qa0rQkJda
	xp8GJChXt9wxKJi9Fpx9MEth4YSSeyzcdOulI3R1cbP94Z2t85IVIjQ+vFCUPM41v0lPV7Uib3rOf
	YYmvOwhag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTEh-00085E-9c; Mon, 10 Dec 2018 21:37:07 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTEd-0007xJ-0o
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:37:04 +0000
Received: by mail-wm1-x342.google.com with SMTP id f81so151649wmd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 13:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zIQjiS4QCt4AkoDN+Y9dTrrxkvV6/u+IfiXkC0gUyBg=;
 b=Mj/tubEBwQdrt0/+vE/YdBpflj5r3F2Nc4s1CgotndK/33d9LnAH3D4BuY6Cyrf+6U
 A+nQrPDvK3Jcw3PEv0JNkE02qFMl9TDw2hDbmCTLr+JG2WYpqVWIoZS66wg82TLbwRPK
 WveVklOg4cQqe5A9EMJBRylRWHMt99VUyVtxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zIQjiS4QCt4AkoDN+Y9dTrrxkvV6/u+IfiXkC0gUyBg=;
 b=UNDa11F6ulTNqGCB2suZfy4nxj/G4xoJieSQ+rjF+enqJpqv1InIEqKdhQXVScNJKP
 A++kAU6m5Cz6/Oht7RuKVx1eKML7W29XnvBseqkx4pIUsWaZUByQqdOPyX2sXPkiUICP
 gKK4oFU6ppVAn73bVakUtmttk4DtC2QYOTDnshSxoNA/2xZUP03yZ7XkkLnVCYUqLgGP
 KhPGQZ+WIEUWTaXN31pWjDuLKDMc2IuAu1TplieeO3p1u3O64ydRsqgSVz85G+rfcBWf
 CKl8/34JHun1Md2V2q0SmTSiOBZQtouAZhD3PlHAhsV7Sdsx11XDwt72yagDNAuWtDCp
 vQug==
X-Gm-Message-State: AA+aEWam4OxEjUET1VdCK9ycPVo/TSPzbkvitcG34JzKIwFX9KQFKULy
 kJzlQHsDlUE4FS8qW+Idh2H/fQ==
X-Google-Smtp-Source: AFSGD/Wtg8Ru7N+irRF39jEpwysxPX9IcjyxT5sNrl2UYL7DEQUcU5tjvAtObaagmWl0YnaJxnKbTg==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr73744wmd.36.1544477811099;
 Mon, 10 Dec 2018 13:36:51 -0800 (PST)
Received: from [192.168.1.8] (hst-221-5.medicom.bg. [84.238.221.5])
 by smtp.googlemail.com with ESMTPSA id a1sm8494192wrw.76.2018.12.10.13.36.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 13:36:50 -0800 (PST)
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.21 - Part 2
To: Andy Gross <andy.gross@linaro.org>
References: <1544245994-4228-1-git-send-email-andy.gross@linaro.org>
 <1544245994-4228-2-git-send-email-andy.gross@linaro.org>
 <c575fb97-4b19-5143-66f8-3a4874aa7c17@linaro.org>
 <20181210190513.GA25288@hector.attlocal.net>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <84d1b299-2898-2df3-8b78-f9510f7bc229@linaro.org>
Date: Mon, 10 Dec 2018 23:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210190513.GA25288@hector.attlocal.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_133703_076396_C85D35C2 
X-CRM114-Status: GOOD (  15.76  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 arm@kernel.org, Kevin Hilman <khilman@baylibre.com>,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CgpPbiAxMC4xMi4xOCDQsy4gMjE6MDUg0YcuLCBBbmR5IEdyb3NzIHdyb3RlOgo+IE9uIE1vbiwg
RGVjIDEwLCAyMDE4IGF0IDAyOjIwOjQ3UE0gKzAyMDAsIFN0YW5pbWlyIFZhcmJhbm92IHdyb3Rl
Ogo+PiBIaSBBbmR5LAo+Pgo+PiBPbiAxMi84LzE4IDc6MTMgQU0sIEFuZHkgR3Jvc3Mgd3JvdGU6
Cj4+PiBUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGI2MDFmNzMxMzBhMzc1Yzkx
MmQ5ZjJlYzkzYzVmM2NlYTVkNmEzZGE6Cj4+Pgo+Pj4gICAgZHJtOiBtc206IENoZWNrIGNtZF9k
Yl9yZWFkX2F1eF9kYXRhKCkgZm9yIGZhaWx1cmUgKDIwMTgtMTEtMjkgMTc6NDE6NTMgLTA2MDAp
Cj4+Pgo+Pj4gYXJlIGF2YWlsYWJsZSBpbiB0aGUgZ2l0IHJlcG9zaXRvcnkgYXQ6Cj4+Pgo+Pj4g
ICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Fncm9zcy9s
aW51eC5naXQgdGFncy9xY29tLWRyaXZlcnMtZm9yLTQuMjEtMgo+Pj4KPj4+IGZvciB5b3UgdG8g
ZmV0Y2ggY2hhbmdlcyB1cCB0byA5MmRlZjA0YmQ3YjQ2ZjViMTg2Zjk4NWQ1YzlkMzgwNDg1OGMz
YzJmOgo+Pj4KPj4+ICAgIE1BSU5UQUlORVJTOiBDaGFuZ2UgVG9kb3IgVG9tb3YncyBlbWFpbCBh
ZGRyZXNzICgyMDE4LTEyLTA1IDE2OjQ1OjM0IC0wNjAwKQo+Pj4KPj4+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+IFF1
YWxjb21tIEFSTSBCYXNlZCBEcml2ZXIgVXBkYXRlcyBmb3IgdjQuMjEgUGFydCAyCj4+Pgo+Pj4g
KiBGaXggTUFJTlRBSU5FUlMgZW1haWwgYWRkcmVzcyBmb3IgVG9kb3IKPj4+ICogRml4IFNDTSBj
b21waWxhdGlvbiBlcnJvcgo+Pj4KPj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+IEpvbmF0aGFuIE1hcmVrICgxKToK
Pj4+ICAgICAgICBmaXJtd2FyZTogcWNvbTogc2NtOiBmaXggY29tcGlsYXRpb24gZXJyb3Igd2hl
biBkaXNhYmxlZAo+Pj4KPj4+IFRvZG9yIFRvbW92ICgxKToKPj4+ICAgICAgICBNQUlOVEFJTkVS
UzogQ2hhbmdlIFRvZG9yIFRvbW92J3MgZW1haWwgYWRkcmVzcwo+Pgo+PiBJIHNhdyB0aGlzIHBh
dGNoIGlzIGFwcGxpZWQgYWxzbyBpbiBtZWRpYV90cmVlLmdpdCwgbm90IHN1cmUgdGhhdCBpcwo+
PiBwcm9ibGVtIHRob3VnaC4KPiAKPiBXaGljaCBvbmU/ICBUaGUgbWFpbnRhaW5lciBvciB0aGUg
c2NtPwoKdGhlIG1haW50YWluZXIgb25lLgoKcmVnYXJkcywKU3RhbgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

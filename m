Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB38C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:36:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640AF208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 07:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A1rQhAsv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9xpN1lY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640AF208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WkpQ4HT4wOFNll/EDp+l6HwUgFGnAjKesCqkFDESDAE=; b=A1rQhAsv764iZJwLLin0OhKtP
	FkBrlCd+RSf05XMdigRU+rNL3PB14NOLLY2RUlUg5owIq+Stj/TzoIfedgEF8L5PcrGN/J/OMA4h9
	Y/pz1DvngGHZNxGEbZhS1DH7k9lNCzioLiSqDVcGsVZfRtL5KO5L/yzRZNb0u9fFjqHQLhfqZxqn2
	OSE5fcTJNcWYdSw5xfBT61l5SRxkeKDaScECR35JDDrxR9N/1/SeBxFJpEt6B2PhSWdtNqv5eTRo3
	V2HKaoq5qNVhlFLENqMZZRgDeNJthIP7YlufWCoQqAycLw6ePfWjRh51EmROSFnahICOk59DTiKUn
	klt/Ph+8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfgVg-0000Zj-T9; Sat, 05 Jan 2019 07:36:44 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfgVc-0000ZF-9P; Sat, 05 Jan 2019 07:36:42 +0000
Received: by mail-wr1-x443.google.com with SMTP id p4so38424119wrt.7;
 Fri, 04 Jan 2019 23:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3zIzCd9FLMIPQDxVpJpe04QlX8YVQiLj5UEU4B+o1K8=;
 b=E9xpN1lYnKPO5j6HZ4eyt0Fn2bqXfe4/rJ5fpqvp4NFh+6rEkZq3s3+Uf08HOztiKs
 sH8jPMr5+nFRweftd+iMIusFfIjnpuyE+lXAkyT7+nzCBirmX5IA5XapTN9sZS7oSIWX
 +seuolWjEaoCYwwltxrprM/ydVEVdneCLuq6dW2DlnwYYczCZjtimHxy5B2o+mSxCyh5
 rSPV4tYhh59t3SI1eM1UWZDJdvA4Ivze4xy9JZ9TIRLb0+JEVVVNsZEtrQFW0Z3yKGix
 rRjd0epkS4TdsoDuGECqwPZr9uUjmUTE24SVeSnjRUAB2yprGni+LgAIJvnm+HUfG0Im
 rCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3zIzCd9FLMIPQDxVpJpe04QlX8YVQiLj5UEU4B+o1K8=;
 b=QFTGxHoA/KP6F7FPhGR2BsjWYVCCM7AWv3SqH1QR+uT9QfY5XneXQ3Y2Wnfke/aQCI
 CbnuGanCBoN7jBC2qq01L3UfWuRqeMobMn77FoONgikyTbEU2SNDwrUBkA6R7G76hua0
 b2SLVb4eKAeTJgny/I45Ybt2bNvSX72fRq3NTEYtJ0LRwmEyeqUyoh6XT2kwW8rrTkwh
 pFWcatA9VpcttMZGIN7xkZCD49QrhKMUVUczYMs2WZwDy3wZE24IqfIOCDhthMMUablb
 9pNgz3gfXUn0E91rdg0YQImWkwQfzR4bRNT0dCu4tIWWBHt+qyGaFiXnMNi08PgQz03d
 wu+Q==
X-Gm-Message-State: AJcUukddbMwOCDFK/aUcNrodNb3IyyPqAXIMlccFfYglXQHPFY5e8P7Q
 L0fvSpUeRSHUQZ+mH8Qd0+xfWcivLy2xCd4g
X-Google-Smtp-Source: ALg8bN5ghhSisNrdrmlvHCvf7653eV43E3e4kvsLv3x4yOKvb5W7w83NdPP4UQMOinzh/OOqztnmGg==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr47511835wrj.118.1546673798087; 
 Fri, 04 Jan 2019 23:36:38 -0800 (PST)
Received: from [10.8.8.190] ([89.238.186.237])
 by smtp.gmail.com with ESMTPSA id o5sm3784958wmg.25.2019.01.04.23.36.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jan 2019 23:36:37 -0800 (PST)
Subject: Re: [PATCH RFC lora-next 1/4] net: lora: sx125x sx1301: correct style
 warnings
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
References: <20181219155616.9547-1-ben.whitten@lairdtech.com>
 <20181219155616.9547-2-ben.whitten@lairdtech.com>
 <62a3e030-98eb-3e63-d193-092b319bd4b1@suse.de>
From: Ben Whitten <ben.whitten@gmail.com>
Message-ID: <60a4e44a-fc63-4434-0986-1d63111623d1@gmail.com>
Date: Sat, 5 Jan 2019 16:36:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <62a3e030-98eb-3e63-d193-092b319bd4b1@suse.de>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_233640_362983_7EB127A9 
X-CRM114-Status: GOOD (  16.94  )
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
Cc: jiri@resnulli.us, Ben Whitten <ben.whitten@lairdtech.com>,
 netdev@vger.kernel.org, linux-lpwan@lists.infradead.org,
 linux-kernel@vger.kernel.org, starnight@g.ncu.edu.tw,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQW5kcmVhcywKCk9uIDI5LzEyLzIwMTggMDk6MDUsIEFuZHJlYXMgRsOkcmJlciB3cm90ZToK
PiBIaSBCZW4sCj4gCj4gQW0gMTkuMTIuMTggdW0gMTY6NTYgc2NocmllYiBCZW4gV2hpdHRlbjoK
Pj4gQ2hlY2twYXRjaCBoaWdobGlnaHRzIHNvbWUgc3R5bGUgaXNzdWVzIHdoaWNoIG5lZWQgdG8g
YmUgYWRkcmVzc2VkLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBCZW4gV2hpdHRlbiA8YmVuLndoaXR0
ZW5AbGFpcmR0ZWNoLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9uZXQvbG9yYS9zeDEyNXguYyB8
IDIwICsrKysrKysrKy0tLS0tLQo+PiAgIGRyaXZlcnMvbmV0L2xvcmEvc3gxMzAxLmMgfCA1MiAr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KPj4gICBkcml2ZXJzL25ldC9s
b3JhL3N4MTMwMS5oIHwgIDcgKysrLS0tCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0NSBpbnNlcnRp
b25zKCspLCAzNCBkZWxldGlvbnMoLSkKPiAKPiBUaGFua3MgZm9yIHNwbGl0dGluZyB0aGlzIG9m
ZiBmcm9tIHRoZSBmdW5jdGlvbmFsIGNoYW5nZXMuIFRoaXMgd2lsbAo+IG5lZWQgc29tZSBtb3Jl
IGV4cGxhbmF0aW9ucyBhbmQgZGlzY3Vzc2lvbi4gSW4gcGFydGljdWxhciB0aGUgY29tbWVudAo+
IGNoYW5nZXMgbG9vayB3cm9uZyB0byBtZS4gQWxzbyBwbGVhc2UgZG9uJ3QgYnV0Y2hlciBjb2Rl
IGp1c3QgYmVjYXVzZQo+IGNoZWNrcGF0Y2gucGwgbWF5IHdhcm4gYWJvdXQgbGluZSBsZW5ndGgg
YXQgdGhpcyBlYXJseSBzdGFnZS4KClllaCB0aGV5IHNlZW1lZCBvZGQgYnV0IGNoZWNrcGF0Y2gg
ZG9lc24ndCBsaWtlIGEgLyogb24gYSBsaW5lIGJ5IGl0cyAKc2VsZiBpdCBzZWVtcy4KCj4gCj4g
QSBnb29kIGNhdGNoIGluIHRoZXJlIHdhcyB0aGUgdW5zaWduZWQgY2FzdHMsIHdoaWNoIGFyZSBu
byBsb25nZXIKPiBuZWNlc3Nhcnkgc2luY2UgdGhlIHJlZ21hcCBjb252ZXJzaW9uLCBzbyB3ZSBz
aG91bGQganVzdCBzcXVhc2ggdGhhdAo+IGludG8gdGhlIGVhcmxpZXIgY29tbWl0cy4KPiAKPiBO
b3RlIHRoYXQgSSB1c2VkIHRvIHJ1biBjaGVja3BhdGNoLnBsIGFzIGdpdCBjb21taXQgaG9vazoK
PiBodHRwOi8vYmxvZy52bXNwbGljZS5uZXQvMjAxMS8wMy9ob3ctdG8tYXV0b21hdGljYWxseS1y
dW4tY2hlY2twYXRjaHBsLmh0bWwKPiBCdXQgc2luY2Ugc29tZSBnaXQgdXBkYXRlIHRoYXQgc3Rh
cnRlZCB0byBicmVhayBnaXQgcmViYXNlIC1pIGluIGNhc2Ugb2YKPiBmYWxzZSBwb3NpdGl2ZXMg
KHdpdGggcmViYXNlIHN0b3BwaW5nIGFuZCBvbiB0cnlpbmcgdG8gY29udGludWUgY29tbWl0cwo+
IHVuaW50ZW50aW9uYWxseSBnZXR0aW5nIHNxdWFzaGVkKSwgc28gSSBkZWFjdGl2YXRlZCBpdCBh
Z2FpbiBhbmQgZG9uJ3QKPiBtYW51YWxseSBjaGVjayBlYWNoIGNvbW1pdCBJIHN0YWdlIGFueW1v
cmUsIGluIGZhdm9yIG9mIHNsb3dseQo+IGNvbXBsZXRpbmcgaW1wbGVtZW50YXRpb25zIHRvIGEg
d29ya2luZyBwb2ludC4KCkdvb2QgdG8ga25vdywgSSdsbCBhdm9pZCBydW5uaW5nIGl0IGZvciB0
aGUgdGltZSBhbmQgZHJvcCB0aGlzIGZyb20gdGhlIHYyCgpUaGFua3MhCkJlbiBXaGl0dGVuCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==

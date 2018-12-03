Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDA1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:56:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD14B20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GmtjbFYS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlVZZo3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD14B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JKis0kywyADaUSzLpZEL4HQsFwI+DTezElTAtt5J6Dw=; b=GmtjbFYSMgNSQY
	okISsk4KRKFq9OUQiyurGftYiOgT/MBT+DqiYgYUDQDa+zafQWCvJMzfU8BycRY0Zx64SUbOqILtf
	/expjjwwFoxIDe0jFemHI1TATjl8OkXGVcGzXUhoyldve2FRDbHjtKb2o6VGclSM+0FcaqcNeuaGr
	h28/02SavEPpJxHrzQM/jnJDw1IdxSuaIg0CXXTC41ppvHGBzR/+EuLLNI32e9V65ugs9c4qlroqr
	1E4P+uQh9ewRtJ/umSAyvWqPMs6lo8aWkd+GXtHjTi1oMePasDpjMgGcbkXXl3yDyH4VuZYYFUusk
	dyypJOWSOXAE7+pHbT4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnm1-0007yz-49; Mon, 03 Dec 2018 12:56:29 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnlx-0007xc-Pq
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:56:27 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so12052818wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 04:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=9KBrBoOrO+XfJILgtl4j7qnaWuKkBcCyWQk1f6mH+Ns=;
 b=PlVZZo3c2gO9uLCfUZVVJpr16CniYdmelENBbOOWAlPNiC+/UN/G4hRbnNrnAedrZS
 1PImzadWgPPbLyxc/EpgdqP8AlagbZpOyK8c3Huzt8wv3X4BYVgVwMspZ4UQu6tbP3CB
 jisR0EmVStHYJUr1BfUmWN6FYjDWBLg3qt8Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=9KBrBoOrO+XfJILgtl4j7qnaWuKkBcCyWQk1f6mH+Ns=;
 b=EhVMoRwYKF3vlYmhtEiq2lOI+fgAqWFdtfwtO86t2T7B6THcSsRyJtwXwnyI3IZ3d1
 w/oOBgdl6J5Wy3v0uHs0ET7ocoFujF+B4SMgMuIPkvw43Pq85gsGZvR/PlX5Gg3dFF+k
 21+ra/FA4UYXpGROu9wQitYykB35b+6bZ/2HotW/UKa5Qb+KuCBT2Dio/j0E3oqnGHe7
 w+nnu9JlpHx9EbKFnFprSh+5dLMcYPjYubLo8wslXK+k75AiIIgQKW9RergRNuFJsWu6
 9pCMFzRe7q8cD2twvyD+i92h5kzXnioQBXWvRwtx4WKs82DRr/M1ZCpo1eRf4FdET875
 Mu9Q==
X-Gm-Message-State: AA+aEWb3rlZAXzUL7AIaLDdo/7Y1ZN/pL9A5tFJz0U6nD3T5PneF5A+X
 qf7i8Jg3TExexVrQnM2utw7jtg==
X-Google-Smtp-Source: AFSGD/Uq6JtGohyQ33oJfLxSqhdxAMWAtzz5RfNgfzCyq4KUoPhWt7h9nG/xmPBcWDabsL90f8d69g==
X-Received: by 2002:a05:6000:10d1:: with SMTP id
 b17mr13881949wrx.306.1543841773676; 
 Mon, 03 Dec 2018 04:56:13 -0800 (PST)
Received: from dell ([2.31.167.218])
 by smtp.gmail.com with ESMTPSA id c10sm9814882wrw.49.2018.12.03.04.56.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 04:56:12 -0800 (PST)
Date: Mon, 3 Dec 2018 12:56:11 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v5 0/9] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <20181203125611.GQ26661@dell>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
 <20181203121951.GP26661@dell>
 <20181203123558.GD15388@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181203123558.GD15388@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_045625_840617_23777CE6 
X-CRM114-Status: GOOD (  14.90  )
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
Cc: david.brown@linaro.org, rafael.j.wysocki@intel.com,
 linux-clk@vger.kernel.org, b.zolnierkie@samsung.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 mazziesaccount@gmail.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, andrew.smirnov@gmail.com, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAwMyBEZWMgMjAxOCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOgoKPiAKPiBIaSBkZSBI
byBMZWUsCj4gCj4gT24gTW9uLCBEZWMgMDMsIDIwMTggYXQgMTI6MTk6NTFQTSArMDAwMCwgTGVl
IEpvbmVzIHdyb3RlOgo+ID4gPiBTZXJpZXMgYWRkIGJkNzE4MzcvYmQ3MTgzNyBQTUlDIGNsb2Nr
IHN1cHBvcnQgKyBtYW5hZ2VkIGludGVyZmFjZXMKPiA+IAo+ID4gWW91J3ZlIHNlbmQgbWUgYSBj
b3ZlciBsZXR0ZXIgYW5kIG5vIHBhdGNoZXMuCj4gPiAKPiBJIGFtIGFmcmFpZCB0aGUgcGF0Y2hl
cyBtYXkgYmUgc3RpbGwgb24gdGhlaXIgd2F5Li4uIEkgYWRkZWQgcmVjaXBpZW50cwo+IHRvIGdp
dCBmb3JtYXQtcGF0Y2ggdmlhIGNvbW1hbmQtbGluZSBzbyB5b3UgYXJlIHByb2JhYmx5IGluY2x1
ZGVkIGFsc28KPiBpbiBwYXRjaCBtYWlscyA6KAoKQWggSSBzZWUuICBZZXMsIEkgc2VlIHRoYXQg
dGhleSBoYXZlIHN0YXJ0ZWQgdG8gY29tZSB0aHJvdWdoLgoKPiA+IEkgc3VnZ2VzdCB0aGF0IEkg
c2hvdWxkIG5vdCBiZSBvbiB0aGUgYWRkcmVzc2VlIGxpc3QgYXQgYWxsIGZvciB0aGlzLgo+IAo+
IEknbSB0ZXJyaWJseSBzb3JyeSBmb3Igc3BhbW1pbmchIEkgbXVzdCd2ZSBkb25lIHNvbWUgbWlz
dGFrZSB3aXRoIHRoZQo+IGdldF9tYWludGFpbmVyLnBsIGFzIEkgY29waWVkIHRoZSByZWNpcGll
bnRzIGZyb20gdGhhdCBvdXRwdXQuIEkgbWF5Cj4gaGF2ZSBhY2NpZGVudGFsbHkgaW5jbHVkZWQg
c29tZSBvbGQgcGF0Y2ggdG8gbWFpbnRhaW5lciBxdWVyeS4KCk5vIHByb2JsZW0uICBJZiB5b3Ug
Y291bGQgcmVtb3ZlIG1lIGZyb20gZnV0dXJlIG1haWxzIHRob3VnaCwgdGhhdAp3b3VsZCBiZSBh
cHByZWNpYXRlZC4gIFRoZSB0b3JyZW50IGl0IGZpZXJjZSBlbm91Z2ggd2l0aG91dCByZWNlaXZp
bmcKY29ycmVzcG9uZGVuY2UgdGhhdCBpcyBub3QgcmVsZXZhbnQgdG8gbWUuICBUaGFua3MuCgot
LSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dCkxpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZApM
aW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExp
bmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

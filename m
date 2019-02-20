Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E95EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:57:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46C32146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s3qU3wpV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Aczi3LRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46C32146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cJ4TuKS+ree0SPjEWYyykdJW/bWzdz2QPDYuN08e/ts=; b=s3qU3wpVfP9rD+
	TStuVO4BVba2D3McYTlLJz9TsHPEQfsrz/YNOC2U12/+m1wSwvn0S2VBfjpBF672g4/QJUNRruTh7
	SO5MHiKkX8ow9jkv7daKMOrgwVEKCK+4MjKTZi6gtl10gSINNkh8c6gW3nZvNfUZxKJosCxQx3/Ti
	HoYiMRDMHHsOqkcysDwGfqaDIfualID0ftxdlyaxelmKgRe7N3wnXTfFgYE9hbaePNJBMnzLAXtxT
	4MT4Mxgd3vVvJv++DgPQyP2JVi9PQYWCo/AJSxvEqR0+vogCV/bFWCH3Dt5f5eTLYQcb9+umlcJqy
	VkyRTXeVGqk0GYJ7Gu/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwVBD-0007a9-3U; Wed, 20 Feb 2019 16:57:07 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwVB7-0007Zl-O3
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 16:57:05 +0000
Received: by mail-it1-x141.google.com with SMTP id x131so16902352itc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 08:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LeQ0DmMp98l1/pRBYPEj1zz83XVQaNxvOO6tFP0UkCY=;
 b=Aczi3LRy+N1IzoV6SkEQBcdmkScMqjwxFPHCtqDsoFG2hjXyStIXcUxlLnTWy7MKTw
 wY8uE6beiZsm4eaW1TtkzY65DhN0KwPEpWoT0XFmleqNAcSHTwIBBRXiAkFnMzIrb7kg
 Tup4mb95VGKv57gRKxasJ/tDic4phd9daD5h8eRgreRj4UMMfSbu6WbFwG+62gi/ddfp
 49bqd20dcgmoIbivNFOC0n4rUn/vO1u6hPPj0XHB+g0BfobVM+J4fE7LM6eYnZg/Brpm
 Y5vRfRXDWBHSzwB4y/xPLNRnS3v4a8qzFz9dsqhYlla2Yn12FjZup+AWMbyJILfNM9OE
 FFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LeQ0DmMp98l1/pRBYPEj1zz83XVQaNxvOO6tFP0UkCY=;
 b=jqUL4WQwXQsRRzc9FI0RiIpLzTcMIL9hNO00+AqINqCqPj6nS4C1+N45gqBcyf/ctW
 R1kzkLFs5I/uf5PSQdCRXPAPftdnkvduX0FAeh7tLUqaIRMB7mt775XTiXby+8mmQ+eK
 rmEvMIFdkcC/JkIsHMWwFpmqP+qh9Wk5AQiYmoYCd8cf24SnfRcoKl16JXP1Vj7sNvRF
 BcH9lPlWX+oQs8lSh/DuFY8L0IrujNn68It/kSd2htu4ciP8dOM/+TJI4ormnuSNIhxy
 WqMVAOk3fmD80UUwACz2y80M76fMUnFmhxG5hgnOe17CEZWbWqPiohuZg8M9SS8FbfUE
 ZyJQ==
X-Gm-Message-State: AHQUAuaV+wsiGf/TxgZemIuLz5corwD+aE11atWjfiKfNZCRNtoP/oeA
 NZQ2T3hPUMF0GUDrLl94vxliRKsW82yzASD/CnH6UA==
X-Google-Smtp-Source: AHgI3IaLakZOHfgKF2qHArTsOKMc+9GIUbeE+SjklhcVxOtTz6kTlFbORaXS3BKbe1Khe3Kq0r1oocRkegAxTrBuIk0=
X-Received: by 2002:a02:1185:: with SMTP id 127mr11523158jaf.136.1550681820342; 
 Wed, 20 Feb 2019 08:57:00 -0800 (PST)
MIME-Version: 1.0
References: <ccdb73e4-e4eb-2552-b62f-6cf57929dfee@acn-group.ch>
 <20190220154658.GP15711@atomide.com>
 <CAHCN7xK4PjCfNgJeQ97kQGOJfjJ927igFELWniu6kuzgJ-Hgiw@mail.gmail.com>
In-Reply-To: <CAHCN7xK4PjCfNgJeQ97kQGOJfjJ927igFELWniu6kuzgJ-Hgiw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 20 Feb 2019 17:56:49 +0100
Message-ID: <CAMRc=Mc0MDyRfAXFTmsPCU5kjBHxiM4i0Ns8BUWhdsRh0bpHWA@mail.gmail.com>
Subject: Re: da850 dt cpufreq support
To: Adam Ford <aford173@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_085701_831328_A61EA06A 
X-CRM114-Status: GOOD (  15.45  )
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
Cc: David Lechner <david@lechnology.com>, Tony Lindgren <tony@atomide.com>,
 Sekhar Nori <nsekhar@ti.com>,
 Christophe Aeschlimann <c.aeschlimann@acn-group.ch>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

xZtyLiwgMjAgbHV0IDIwMTkgbyAxNjo1OSBBZGFtIEZvcmQgPGFmb3JkMTczQGdtYWlsLmNvbT4g
bmFwaXNhxYIoYSk6Cj4KPiBPbiBXZWQsIEZlYiAyMCwgMjAxOSBhdCA5OjQ3IEFNIFRvbnkgTGlu
ZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+IHdyb3RlOgo+ID4KPiA+IEhpLAo+ID4KPiA+IEFkZGlu
ZyBCYXJ0b3N6LCBEYXZpZCBhbmQgU2VraGFyIHRvIENjLgo+ID4KPiA+ICogQ2hyaXN0b3BoZSBB
ZXNjaGxpbWFubiA8Yy5hZXNjaGxpbWFubkBhY24tZ3JvdXAuY2g+IFsxOTAyMjAgMTU6MzRdOgo+
ID4gPiBIaSwKPiA+ID4KPiA+ID4gSSB1bmRlcnN0YW5kIHRoYXQgdG9kYXkgdGhlIGRhODUwLWV2
bSBpcyBzdXBwb3J0ZWQgaW4gdHdvIHdheXMgaW4gdGhlCj4gPiA+IEtlcm5lbCwgdXNpbmcgYm9h
cmQgZmlsZSwgYWthICJsZWdhY3kiIGFuZCBkZXZpY2UtdHJlZS4KPiA+ID4KPiA+ID4gQW0gSSBy
aWdodCB0byBzYXkgdGhhdCB3aGVuIHVzaW5nIHRoZSBkZXZpY2UtdHJlZSB0aGVyZSBpcyBubyBz
dXBwb3J0IGZvcgo+ID4gPiBjcHVmcmVxIGF2YWlsYWJsZSA/Cj4gPiA+Cj4gPiA+IFRoZSAidGkt
Y3B1ZnJlcSIgZHJpdmVyIGRvZXNuJ3QgdGFyZ2V0IHRoZSBkYTg1MCBTb0MgYW5kIHRoZQo+ID4g
PiAiZGF2aW5jaS1jcHVmcmVxIiBkcml2ZXIgZG9lc24ndCBtYWtlIHVzZSBvZiB0aGUgZGV2aWNl
LXRyZWUgYmluZGluZ3MuCj4gPiA+Cj4gPiA+IENvdWxkIHRoZSBnZW5lcmljICJjcHVmcmVxLWR0
IiBkcml2ZXIgYmUgdXNlZCA/Cj4KPiBBIHdoaWxlIGFnbywgRGF2aWQgTCBwb3N0ZWQgYSBtZXNz
YWdlIG9uIHRoZSBtYWlsaW5nIGxpc3QgcG9pbnRpbmcgdG8KPiBhIGdpdCByZXBvIHRoYXQgaGF0
IHNvbWUgcGF0Y2hlcyB0aGF0IHdlcmVuJ3QgbWFpbmxpbmVkLgo+Cj4gaHR0cHM6Ly9naXRodWIu
Y29tL2RsZWNoL2xpbnV4L3RyZWUvZGE4NTAtZHQtY3B1ZnJlcQo+Cj4gSSB3YXMgZ29pbmcgdG8g
dHJ5IGFuZCB0ZXN0IHRoZW0sIGJ1dCBJIG5ldmVyIGdvdCBhcm91bmQgdG8gaXQgZHVlIHRvCj4g
b3RoZXIgd29yayBwcm9qZWN0cy4KPgoKQWN0dWFsbHkgRGF2aWQncyBqdXN0IHB1c2hlZCBhbiB1
cGRhdGVkIHZlcnNpb24gd2l0aCBoaXMgU2lnbmVkLW9mZi1ieQp0YWcgdGhhdCB3YXMgbWlzc2lu
ZyBwcmV2aW91c2x5IGFuZCBJJ20gYWJvdXQgdG8gY29udGludWUgaGlzIHdvcmsuCkknbGwgcG9z
dCBwYXRjaGVzIHNob3J0bHkuCgpCZXN0IHJlZ2FyZHMsCkJhcnRvc3ogR29sYXN6ZXdza2kKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK

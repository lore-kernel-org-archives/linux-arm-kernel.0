Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5126AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:09:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB002086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WtVu0Cqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB002086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WMu28vW29sakKntIdHRkYbuSdwI/SOvd2YoHn0DHlI0=; b=WtVu0Cqv5Zqwjp
	4xwZ+O4HEfRnUf/VdDbXOzVEA+alJ++sh7JDfJBlcSOeUA14VOXZhyaFRzJcnkeSuoimKrnKDsLt0
	C8Qpc/C7HRHu1lzsbD8oiPt2k9+jx8eiAHvU6px0edZfVjgorhQrrdCoS+ozLKDtc86SFQgXW+vfy
	g4Sg4CCaREUuim0IIgMAlc1OyZL2rkGIIN0ft4ui2Zg+qRI6kxRven0Pf2LY/s9ncEpuKq7zkK5yt
	BIbeKYchHZVXMWiqFybyM4r009Ks92tjF+FKgqMvHzIUtfupUhyWmfDJhLk9LZscc1Zyu3/AxPi8D
	lO/DG8JUHu8pqNDJ9vjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTVL-0007j8-EN; Wed, 20 Feb 2019 15:09:47 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTVH-0007iS-UQ
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:09:45 +0000
Received: by mail-qt1-f195.google.com with SMTP id v10so27525217qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 07:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q5WgV/d8eTVUXZ+eKsYqwx5yF1ibfzWrdaZEomSF1M4=;
 b=OgpC7yz6GXrmWkrXGzzgCgXSWLeoCvw5qgBb10uP96F4NiQmYXAkTnPrjwbpWMzRFZ
 T+53eC1YXG1KU2zShUCTc9mKbfMroFBn62QiUQiFB2RL+prZxs/7CbJ4Wx28oCG3EWNR
 P5CsUE2zz0cIzG7wypxk/YeXn3WDXxhwhTdnJrwOu4yvB/02iMYpl/j5yXHEwexmShA6
 EicUkjmlNaXiZaW2IAStg06TS9nHfiQDQWXZii8fhrEdT8w3DG5Xyf9GYmsuDAT1m45H
 c47khnfoHgIAC2sO01RjcoTrPrEZiRKcRoqiG9ULD5i/smU17T8WadKN3czlBxIj5sZn
 GOUg==
X-Gm-Message-State: AHQUAuYqYIx3PR75bs269KhGHPCB0Sb0DbHT5+ShWXXvR1U/0KGsREW7
 A01rNrewGv3fgiLLoH6N9CHVx5HwTdhTf/dSohI=
X-Google-Smtp-Source: AHgI3Ib+3B02wSZ1ewe8ZomH44wJj/nIfJB8g42juyusE+56bWISG6omwiNu4mxsBfNC/0+pkDhQ6h59y+Q+PDKysfQ=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr27103021qtn.212.1550675382619; 
 Wed, 20 Feb 2019 07:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20190211110919.10388-1-thierry.reding@gmail.com>
 <20190211204452.Horde.-B4_UgJoWHc85yxQZVtc9wu@_> <20190218151357.GA21562@ulmo>
In-Reply-To: <20190218151357.GA21562@ulmo>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Feb 2019 16:09:23 +0100
Message-ID: <CAK8P3a1YG-R_vUpQm6Dik1Tak_YQKck1jSTkd_7GL63tLw4pRA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: tegra: Restore DT ABI on Tegra124 Chromebooks
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_070943_982412_F9EC535A 
X-CRM114-Status: GOOD (  13.01  )
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
Cc: "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 Tristan Bastian <tristan-c.bastian@gmx.de>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgNDoxNCBQTSBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5y
ZWRpbmdAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgRmViIDExLCAyMDE5IGF0IDA4OjQ0
OjUyUE0gKzAwMDAsIFRyaXN0YW4gQmFzdGlhbiB3cm90ZToKPiA+IFRoaWVycnkgUmVkaW5nIOKA
kyBNb24sIDExLiBGZWJydWFyeSAyMDE5IDEyOjA5Cj4gPiA+IEZyb206IFRoaWVycnkgUmVkaW5n
IDx0cmVkaW5nQG52aWRpYS5jb20+Cgo+ID4gVGVzdGVkLWJ5OiBUcmlzdGFuIEJhc3RpYW4gPHRy
aXN0YW4tYy5iYXN0aWFuQGdteC5kZT4KPgo+IEhpIEFSTSBTb0MgbWFpbnRhaW5lcnMsCj4KPiBJ
IGhhZCBhbG1vc3QgZm9yZ290dGVuIGFib3V0IHRoaXMuIElkZWFsbHkgSSdkIGxpa2UgdGhpcyB0
byBnbyBpbnRvIHY1LjAKPiBzaW5jZSBpdCBmaXhlcyBhIHJlZ3Jlc3Npb24gaW50cm9kdWNlZCBp
biB2NC4xOSwgc28gd2UnZCBrZWVwIHRoZSBudW1iZXIKPiBvZiB2ZXJzaW9ucyB0aGF0IGl0IG5l
ZWRzIHRvIGdldCBiYWNrcG9ydGVkIHRvIGZhaXJseSBsb3cuCj4KPiBUaGUgcGF0Y2h3b3JrIGxp
bmsgaXMgaGVyZToKPgo+ICAgICAgICAgaHR0cDovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNo
LzEwMzk3NDMvCj4KPiBJIGRvbid0IGhhdmUgYW55IG90aGVyIGZpeGVzIGZvciB2NS4wLCBzbyBJ
IGRvbid0IHRoaW5rIHNlbmRpbmcgYSBwdWxsCj4gcmVxdWVzdCB3b3VsZCBoZWxwIHlvdSB2ZXJ5
IG11Y2gsIGJ1dCBJIGNhbiBwcmVwYXJlIG9uZSBpZiB5b3UgcHJlZmVyLgoKQXBwbGllZCB0byB0
aGUgZml4ZXMgYnJhbmNoLCB0aGFua3MhCgogICAgIEFybmQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

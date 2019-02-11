Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA586C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:11:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB462218D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kWOlx9Ov";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kgyLyJLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB462218D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UHWWMwEVAcFv1w/GqvJ5xqasfEYvgr8EScYzCEiHqS0=; b=kWOlx9OvXQBXIM
	CzY6MOLb0J+CrZK8Lifx+Uw+U8WErduACBsmW+0jZbQXeU1EKp/brmerEOzRC94V9P8j622c2Ej8f
	0Tmy3ZjxAUaSHXKkIDVMlfT594arRHu3RhsErVNG72sE8VCCPctnIz1llokPZ39l1jVN2eFshkz4T
	Ttn/rLRDJK8L6ehVikSOmYyXvck2Jx/+s4jLmAASdFNhVtjjm8gPzE1JlWwdHP15MStsUx0lPTqOi
	T+GOON+Y1M5EJYAVWJoLcXYVAg2RS/c7Tk+iOpWefCmxFkUgYxA08y45nSZs4PLNtAJZSjVQ9EoaU
	NmY4KnJqXeh4qSATHRUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAQp-0006iK-Bj; Mon, 11 Feb 2019 12:11:27 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAQl-0006hr-Er
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:11:25 +0000
Received: by mail-ot1-x344.google.com with SMTP id m1so5284694otf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KC8LXiCQQI99XcUi6fwU9wUEtaVFh0/UTHlyNNxO9Mw=;
 b=kgyLyJLrMuAmA4gRztU+a6frP99l+jEVRu6XZkc+mmGb5hGMj+Fru4SrE+5Zrc2JKB
 exV3XCzWUyLt0clgZIvwsLo7QTo5ZIPuwdPtsRzJF/HraLVbZNvLpsmeFVuOuU8yUrYx
 jfvMV0IO5kThmEupWBu3w0TPCKs56HW7Q9mT00iWVQKFfXY0ASIeOy5reDd5nRjJawCo
 6ICYAlpkfTrF+NEw4CUdgAAn6Md1n2ooljJzDE4l72wMBhDueyX3E285wu6oMfwmrJEl
 H/o5MwWDe3mLAZm127dzFHKHF/CWH5GAFLOEh0oyY3b1KLJcMdA2nuJS8qFjRyYano8n
 H+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KC8LXiCQQI99XcUi6fwU9wUEtaVFh0/UTHlyNNxO9Mw=;
 b=s9/pn7h0Gup6BF2eEhdkTyhossPZv6FRsBf2KeVy+Dn02xxd9nmZazCSYMEAJdpQiX
 4YWhMzizEcJAkfX917ZorcY7e9PyfTJfiCqeK/XuBZbGz2Js44zwChjmurFnadUgd9Ek
 dkgFkCu7RxvwjSV7pgnZZfSpWJyxGJmmW+Sbsdt8/LO+qv20wHEYDmgQgCiEMUJctDa1
 jq9uOSRhYtxcq+H+ifbyqjnkWKwFlXPOWvMiI4iBmxgs6uJOWtvg/9bQy9fl+3/SAV+o
 pFoAdjXptUh0aBjXMkcnGt22RcJe4aY0/fR3xdpIJuK3TA4Rd6lechwRtTtcp7l9jihq
 UEDQ==
X-Gm-Message-State: AHQUAuZoxxGCIxGEKnKfeA5bH+3AchOA0mURBMlnL83m3AUZs0L3Td2A
 QAnP2/gufcGZqEEA7g8dWm4H99F1mNBvYzlAVCfVig==
X-Google-Smtp-Source: AHgI3Ia1HjxvXShN20b9umX/+fo76bxp8cVITE8fngptLKa+cLPQSR1zsPoNl8LykasNpStTlif+dI6OY2wWt+99MBI=
X-Received: by 2002:a9d:76c5:: with SMTP id p5mr26621538otl.108.1549887082094; 
 Mon, 11 Feb 2019 04:11:22 -0800 (PST)
MIME-Version: 1.0
References: <20190208173458.4801-1-brgl@bgdev.pl>
 <50671542-c055-1796-c58e-276ba3d414d0@ti.com>
In-Reply-To: <50671542-c055-1796-c58e-276ba3d414d0@ti.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 11 Feb 2019 13:11:11 +0100
Message-ID: <CAMpxmJV34X=C4HMGNiAUxoVkPP+1nY3186QHOisqQtwT9pNtyg@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] ARM: davinci: modernize the irq support
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_041123_549978_440BE991 
X-CRM114-Status: GOOD (  18.30  )
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
 linux-devicetree <devicetree@vger.kernel.org>,
 David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 arm-soc <linux-arm-kernel@lists.infradead.org>,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cG9uLiwgMTEgbHV0IDIwMTkgbyAxMjo1NCBTZWtoYXIgTm9yaSA8bnNla2hhckB0aS5jb20+IG5h
cGlzYcWCKGEpOgo+Cj4gKyBKYXNvbiwgTWFyYwo+Cj4gVGhvbWFzLCBKYXNvbiwgTWFyYywKPgo+
IE9uIDA4LzAyLzE5IDExOjA0IFBNLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdyb3RlOgo+ID4gRnJv
bTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4KPiA+Cj4g
PiBUaGlzIHNlcmllcyBwb3J0cyB0aGUgZGF2aW5jaSBwbGF0Zm9ybSB0byB1c2luZyBTUEFSU0Vf
SVJRLCBjbGVhbnMgdXAKPiA+IHRoZSBpcnFjaGlwIGRyaXZlcnMgYW5kIG1vdmVzIHRoZW0gb3Zl
ciB0byBkcml2ZXJzL2lycWNoaXAuCj4gPgo+ID4gVGhlIHNlcmllcyBjYW4gYmUgbG9naWNhbGx5
IHNwbGl0IGludG8gZm91ciBwYXJ0cy4gVGhlIGZpcnN0ICgxLTgpIGFpbXMKPiA+IGF0IGludHJv
ZHVjaW5nIHN1cHBvcnQgZm9yIFNQQVJTRV9JUlEuIEl0IGNvbnRhaW5zIGEgY291cGxlIGNoYW5n
ZXMKPiA+IHJlcXVpcmVkIGZvciB0aGF0IGZ1bmN0aW9uYWxpdHkgYW5kIHRoZSBmaW5hbCBwYXRj
aCBhY3R1YWxseSBzZWxlY3RpbmcKPiA+IGl0Lgo+ID4KPiA+IFNlY29uZCBwYXJ0ICg5LTE5KSBt
YWtlcyB0aGUgYWludGMgZHJpdmVyIHN1aXRhYmxlIGZvciBkcml2ZXJzL2lycWNoaXAKPiA+IGFu
ZCBldmVudHVhbGx5IG1vdmVzIGl0IG92ZXIgdGhlcmUuCj4gPgo+ID4gUGFydCAzICgyMC0zMikg
ZG9lcyB0aGUgc2FtZSBmb3IgdGhlIGNwLWludGMgZHJpdmVyLgo+ID4KPiA+IExhc3QgcGF0Y2gg
cmVtb3ZlcyB1bm5lY2Vzc2FyeSBjb2RlLgo+ID4KPiA+IFRoZSBzZXJpZXMgaGFzIGJlZW4gdGVz
dGVkIG9uIGRhODUwLWxjZGsgKGZvciBjcC1pbnRjKSBhbmQKPiA+IGRtMzY1LWV2bSAoZm9yIGFp
bnRjKS4KPgo+IFdpdGggeW91ciBhY2ssIEkgd291bGQgbGlrZSB0byB0cnkgZ2V0IGl0IG1lcmdl
ZCB0byB2NS4xIHZpYSBBUk0gU29DIHRyZWUuCj4KPiBCYXJ0b3N6LCBJIG5vdGljZWQgdGhhdCBK
YXNvbiBhbmQgTWFyYyB3ZXJlIG5vdCBvcmlnaW5hbGx5IENDZWQuIFlvdSBtYXkKPiBoYXZlIHRv
IHJlc2VuZCBpZiB0aGV5IGRvbid0IGhhdmUgdGhlIHNlcmllcyBpbiB0aGVpciBpbmJveC4KPgo+
IFRoYW5rcywKPiBTZWtoYXIKClNvcnJ5IGZvciB0aGF0LCBJJ20gbm90IHN1cmUgaG93IHRoaXMg
aGFwcGVuZWQsIHNpbmNlIHRoZXkgZG8gcG9wIHVwCmluIGdldF9tYWludGFpbmVyLnBsIG91dHB1
dCBmb3IgdGhhdCBzZXJpZXMuCgpJJ2xsIHJlc2VuZCBpdC4KCkJhcnQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E803C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:48:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DECE820857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sWmxEYx7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ieGfk5dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECE820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I+GNuzXP9R7V9dBMmnETyY/RE5rA82NI7mWYjRR9/O0=; b=sWmxEYx7ca4JcX
	mmc+MIMSZ/bDD3HC7xuAdGt/pQ8ZcQFesMQqtEFITlmsHcX80udPBQutwp6gkbzoktFewH3b6iCxs
	XOGjz7qn8b/bZWv998UCdW4jX6F8FJm0ZVMzOQfnZ7dt7XsgeYQ8/FPRdl56/BESQEPMxZk9niOta
	Gy/BOo/5UqsEb2PsTLBg/E5QLHvLLwikLdXPRiuTryKq2/2F7CUEQ083/eTzSRX38Nzmh+9sA+leP
	iMPbX0bzvMn6k4E8krc67xXaJNyNcwjpxPxK/mM1o4URwIzn5qNbqloaQRzPCLq1rJmstvPf78pBY
	TW4JWWGulrKU4//j8OFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs5Zj-0005nM-86; Fri, 08 Feb 2019 12:48:11 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs5Zf-0005n3-VW
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 12:48:09 +0000
Received: by mail-ot1-x344.google.com with SMTP id u16so5567732otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 04:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JWzV0M0DRGDSHP1/88xQPKP0xbprssAo28cl+Ap6wNM=;
 b=ieGfk5dQ4O40tNc6NnZ4JeBT1H0kM6WLPymOjxvvkInUU1szdAv052OyksGLlVaeTj
 hDJFRn+9OHbhXfIWpx0q//LKyMAn1B7TkEBe7lZh1I42nOf8ToYTxr9a3YQ4jVMoJEM6
 6ZUa+yc8DStA524HuJ6zwZu93BWXvXetlgqMdANDJtnUdZScdvGbIN+lPUWfeyEVjAEk
 RHLFA+S4CPkJpsHrmRYGvYjeT7v4CQKJfxHLwCLiV8oMPL/FR2ABQ+2JVmM2nEB3KGdJ
 NjhyC8Cq3Fq+Q91eVmAb8jJen/YhWtJHpR0q5OrqHF+X5cIgnzHuU7NrrJ45mYDe98MM
 qBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JWzV0M0DRGDSHP1/88xQPKP0xbprssAo28cl+Ap6wNM=;
 b=VawHO6hPwbKjvBIWR5spDErFOKqMwqw33SVNDN5IWqL+1PlbywHXNaKZ3EydHeYEo3
 XdNpTmaLMdMqlwtXs8O4tMNm6toeujCI0oBnScaTHoCAs1tmo/z+lkiuskBN7nMzKD2T
 JjmY/poCke6g6MPF+KM9uVlXT948ZZfjI8bzhmZ91ZnAVv/MutoBmiiBX2z12SseLxf5
 2XO4dFO99t1ZGX7Jgkk9YSAPyQfzir6YT/QZtT07inmhF8gWATbs7FJ9VB9vK2FgY9yG
 e/l2zgcbTnpi4LxzttslJV7lHzw5msyy6zvhGm1n6kDe3k8K/DSFNtiLtZbTIZV8o2Du
 GKnA==
X-Gm-Message-State: AHQUAuYvoByoBSU1bbx0L1NWlUxo5aAY35j3bYNgTDglD9GNAvhD4Q1g
 RSOGOE91b9lVe6uZeeEwonSDDywmgC0Zq2QpgzIcxVTSTA0=
X-Google-Smtp-Source: AHgI3Ial+h5E9Y271MzSd0t0lZHzB/vXzwxcYRl1ZDWcV0xgScVWDgDusw+8T2RGaYgTewepPiemzptpCz2QRltdDe0=
X-Received: by 2002:a9d:4595:: with SMTP id x21mr4070807ote.234.1549630087103; 
 Fri, 08 Feb 2019 04:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-6-brgl@bgdev.pl>
 <9d423e18-8c85-731b-388a-1843067db242@ti.com>
 <CAMpxmJW0qMi0BmiK2SOwdagw2-t8+1g20XJR418mWb8f1dwxtQ@mail.gmail.com>
 <acd3f8ca-8ed7-f86a-9bdf-24e4e6e9a6a4@ti.com>
In-Reply-To: <acd3f8ca-8ed7-f86a-9bdf-24e4e6e9a6a4@ti.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 8 Feb 2019 13:47:56 +0100
Message-ID: <CAMpxmJUXuxEp+424Z_YtAq02XvBzcDAj73LgOBnXE-T0fhmCTQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] ARM: davinci: da850: switch to using the
 clocksource driver
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_044808_010911_081DC3B3 
X-CRM114-Status: GOOD (  14.51  )
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
 Kevin Hilman <khilman@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cHQuLCA4IGx1dCAyMDE5IG8gMTM6MzcgU2VraGFyIE5vcmkgPG5zZWtoYXJAdGkuY29tPiBuYXBp
c2HFgihhKToKPgo+IE9uIDA4LzAyLzE5IDY6MDQgUE0sIEJhcnRvc3ogR29sYXN6ZXdza2kgd3Jv
dGU6Cj4gPiBwdC4sIDggbHV0IDIwMTkgbyAxMzowNiBTZWtoYXIgTm9yaSA8bnNla2hhckB0aS5j
b20+IG5hcGlzYcWCKGEpOgo+ID4+Cj4gPj4gT24gMDQvMDIvMTkgMTA6NDcgUE0sIEJhcnRvc3og
R29sYXN6ZXdza2kgd3JvdGU6Cj4gPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRhdmluY2lfdGlt
ZXJfY2ZnIGRhODUwX3RpbWVyX2NmZyA9IHsKPiA+Pj4gKyAgICAgLnJlZyA9IHsKPiA+Pj4gKyAg
ICAgICAgICAgICAuc3RhcnQgICAgICAgICAgPSBEQThYWF9USU1FUjY0UDBfQkFTRSwKPiA+Pj4g
KyAgICAgICAgICAgICAuZW5kICAgICAgICAgICAgPSBEQThYWF9USU1FUjY0UDBfQkFTRSArIFNa
XzRLLAo+ID4+Cj4gPj4gU1pfNEsgLSAxCj4gPj4KPiA+PiBUaGlzIHNob3VsZCBoYXZlIHByZXZl
bnRlZCB3YXRjaGRvZyB0aW1lciBmcm9tIGdldHRpbmcgcmVnaXN0ZXJlZC4KPiA+Pgo+ID4+IFRo
YW5rcywKPiA+PiBTZWtoYXIKPiA+Cj4gPiBNeSBjbG9ja3NvdXJjZSBkcml2ZXIgZG9lc24ndCBj
YWxsIHJlcXVlc3RfcmVnaW9uKCkgc28gYSBzdWJzZXF1ZW50Cj4gPiBkZXZtX2lvcmVtYXBfcmVz
b3VyY2UoKSBpbiB0aGUgd2F0Y2hkb2cgZHJpdmVyIHdvdWxkIHN0aWxsIHN1Y2NlZWQuIEkKPiA+
IG5vdyBmaXhlZCBib3RoIHRoZSBtaXNzaW5nIGNhbGwgYW5kIHRoZSB2YWx1ZSBoZXJlLgo+Cj4g
QWgsIGdvdCBpdC4gUGVyaGFwcyBhIGNhbGwgdG8gcmVxdWVzdF9yZWdpb24oKSBzaG91bGQgYmUg
YWRkZWQgdG8gY2F0Y2gKPiBpc3N1ZXM/Cj4KClllcywgdGhhdCdzIHdoYXQgSSBtZWFudCBieSAi
Zml4aW5nIHRoZSBtaXNzaW5nIGNhbGwiLiBJdCB3aWxsIGJlCnRoZXJlIGluIHYzLiBBY3R1YWxs
eSB0aGUga2VybmVsIHNlZW1zIHRvIGJlIG1pc3NpbmcgYSBub24tbWFuYWdlZAppb3JlbWFwX3Jl
c291cmNlKCkgaGVscGVyLiBNYXliZSBJIHNob3VsZCBhZGQgaXQgYXMgd2VsbC4KCkJhcnQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK

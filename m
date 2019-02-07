Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2924BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:58:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E551620811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l8L8sb2C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CBqA5Wrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E551620811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R+E+kflinN+zlTgSN8zHqv56fqkwg3yKEBfKsP71XkA=; b=l8L8sb2CjyziM/
	T2pzTW7Dg1bYp0iOPzXsT4VJD3pW/II+9zo0WCUzJZLU2jotMsBFWUtaPw6pXewzU8Jl2nnZlSwOq
	2PSqkTnYXhcmheN8lx5AjvhGT7OHFSj2Y/ZPms/EdnS7lF794SKJhU7X8BbBCzFM99VP4KPR+37m3
	/y0JxLKK0UN1r4/56qHP4b4KZTzoWrGltNhcxmK7fty2N6u+bzE3iRNEus96okMV11PLveN9TTczw
	YKPy9xJ25n+npDZlfeNBN70BFRa+Rf/0tLncmGgdYNOV9QLK5QUzpbtft0NydgbasaKDfy4oX4cwp
	CX0+vytrjjJB5qm/qBxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grapG-00059f-Aq; Thu, 07 Feb 2019 03:58:10 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grapC-00058x-QC
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 03:58:08 +0000
Received: by mail-pf1-x444.google.com with SMTP id j3so2028624pfi.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 19:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=4vE9BU00uVWm07pHSl9XmaBqTKJTzMk4dRaKirmkAwg=;
 b=CBqA5Wrr5nQY0/io8LQVu2pwnh/AIGUtm3+pmy7XdGF2oStq4rizz1j9etGI1NO1Zn
 XURTlghKfEjPqbAnIqd0hKGTfRW+xUZkz8k7qrY4KtEDxMTb+Vr3LcTu4TESmgHD4WO7
 B8A5knEHG7wGmXGSBYchv80nJEPyX3aEen/9nb6AZRzBm0Ji3t42niAONu1H8MPo3BN5
 nDh4lD+hhOLwCwzBctqmNUOv2Dh8JtJQq2XlHKZsWOw96fIeHxlJ1BDSCcBN8YPigmAr
 BzpHDevJ1BPrAKUfbZjxz2j7n2AR8cBC2mbfKPXw4Yoei3/ahP60xJvYpJvwyiBtcgcC
 irlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4vE9BU00uVWm07pHSl9XmaBqTKJTzMk4dRaKirmkAwg=;
 b=cuBfMB3P4LMkK+v+eZKg47JILe6KGvpn9ErvO5nBcJpohRCuifw3jgDkNNtkont+Zr
 O0uW8NlQkMcQB5riSONVeTO7WRy/RP+ixFyWwNuVE8bsBet1Ncz/I2KceOgL/sbHeWsT
 7Qv1cO1aJVKdhfK+7OG8t4Nijwkqi74rAir1P/++kTHejcVXIywJyZlSLJuzDdicUo7U
 yd44dD6hCc3uk4k3VUeZtwFMRPo8kjJRM+bJ5RgHLny633VAQpR/SNxIv6XFD1/udOpI
 WAv23eQMGV0dRbEfhTuATabvscLyx+OM4WnR1SHrNbgq8sfHziqZoZ26+BfIttIC68sr
 yqig==
X-Gm-Message-State: AHQUAub1VGIVsRhHNn5uhTAG9UfKB7Hmr76vkQKZukg8n3KcW+4Daugd
 Xph9BqOlVkkjmR2QWzWpr5CIgQ==
X-Google-Smtp-Source: AHgI3IaFp5sgEjJOCrn46BYjHmUjilzFj3AdOVe9WGP1fBe+lpzmN8tIosQ11mVSNyJcFcSb5SlsPQ==
X-Received: by 2002:a65:4784:: with SMTP id e4mr3129018pgs.12.1549511886237;
 Wed, 06 Feb 2019 19:58:06 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
 by smtp.googlemail.com with ESMTPSA id d3sm9706256pgl.64.2019.02.06.19.58.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 19:58:05 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v6 0/4] clk: meson-g12a: Add EE clock controller driver
In-Reply-To: <5C55CDCE.9030502@baylibre.com>
References: <20190201145345.6795-1-jbrunet@baylibre.com>
 <5C55CDCE.9030502@baylibre.com>
Date: Wed, 06 Feb 2019 19:58:04 -0800
Message-ID: <7hbm3ogshf.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_195806_853016_9D06CA13 
X-CRM114-Status: UNSURE (   9.12  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-amlogic@lists.infradead.org, Jian Hu <jian.hu@amlogic.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TmVpbCBBcm1zdHJvbmcgPG5hcm1zdHJvbmdAYmF5bGlicmUuY29tPiB3cml0ZXM6Cgo+IExlIDAx
LzAyLzIwMTkgMTU6NTMsIEplcm9tZSBCcnVuZXQgYSDDqWNyaXQgOgo+PiBUaGlzIHB1cnBvc2Ug
b2YgdGhpcyBwYXRjaHNldCBpcyB0byB0aGUgbWFpbiBjbG9jayBjb250cm9sbGVyIG9mIHRoZQo+
PiBnMTJhIFNvQyBmYW1pbHkKPj4gCj4+IFRoaXMgcGF0Y2hzZXQgZGVwZW5kcyBvbiB0aGUgcmVj
ZW50IHJld29yayB0aGUgbWVzb24gY2xvY2sgZGlyZWN0b3J5IFs3XS4KClsuLi5dCgo+IFJldmll
d2VkLWJ5OiBOZWlsIEFybXN0cm9uZyA8bmFybXN0cm9uZ0BiYXlsaWJyZS5jb20+Cj4KPiBJJ20g
YXBwbHlpbmcgdGhlc2UgdG8gbmV4dC9kcml2ZXJzIGZvciBMaW51eCA1LjEtcmMxLCBpcyBpdCBu
ZWNlc3NhcnkgdG8KPiBoYXZlIGEgdGFnIGZvciB0aGUgaGVhZGVycyA/CgpPbmx5IGlmIHdlIGhh
dmUgc29tZSB1c2VycyB0aGF0IHdlIHdhbnQgdG8gbWVyZ2UgaW4gdGhlIHY1LjEgY3ljbGUKKHdo
aWNoIEkgaGF2ZW4ndCBzZWVuIHlldC4pCgpLZXZpbgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

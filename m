Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9375AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:33:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6483D20872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W3tiBKyg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqwXG5kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6483D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pLFylnMDzYOXAQYtsfL5P7XTv/z5FWxNDdMeW9Pc8qg=; b=W3tiBKygCIgrG8
	0H01/v/xA3UT1DqMn0VbrMS3xnsOnEq4jfA7JX9/lzkncxoWh4onuqxl/4Hxgeh58Yu3+Zilm2yp3
	10SHx4giq9BM7IRSmpi4u7c9p0b8QB+SO1fBnrRzFQ4eOZcJUn7mYyCXVYCPEudOZ26k59avxf4y+
	sGbVYEW8o6RPZsWJZcWakknYGT8fzz6/STtnUP2pagI09ngM4PETSIH28yZcHxZwPutB0DvJcB6fM
	kwi7F+PCs+c194NTPlhwGyQ/9RFoFUFwqE0IPGtl6Ny80jXoeEYkUq/Yz+tqZuQxYbSNq6omm6/IE
	jGbleSTVDFci/CoPXqNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghsG3-0000Ub-Q2; Fri, 11 Jan 2019 08:33:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghsG0-0000Ts-6k
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 08:33:37 +0000
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8D83B20874
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 08:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547195615;
 bh=ilLtGkj2iHcA72skp8sL+/oebdvbxBzki0Mfg4V7sQI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=uqwXG5kjsroGEKIcDR9jxWvYGd8iPm1WmET5Rlvdm1Q247rEud05hSOnjWw6emuLT
 /7VMMTFr8HIIqWzaR9h+5UDe8v9D+YsGguGjYCTZe/PYTeKnQYNclb8JjWjF+9T2+n
 tIH3mXsEYUOtrwdEJSkDEm/5Lx+/O203GQII4NCM=
Received: by mail-lj1-f177.google.com with SMTP id x85-v6so12199748ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 00:33:35 -0800 (PST)
X-Gm-Message-State: AJcUukeLEnQg3IZgjLhOXrYDP29fRqyqYQdgXUpH1UYLaSgCR0fyG6N4
 0bksUFrRNh/3UmGaTi71UHQeP4eamTdL6Y6wxHM=
X-Google-Smtp-Source: ALg8bN61FeAJnmMyFF4fv6DchkQp0LOEUzuDw1AZ0u8t2tz4kJ1AmTMiy0J6L/wz+LKsFWNXzNR9Yv5Daj/s3Mp7VpU=
X-Received: by 2002:a2e:551:: with SMTP id 78-v6mr7473508ljf.82.1547195613753; 
 Fri, 11 Jan 2019 00:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108165601.25708-2-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190108165601.25708-2-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 11 Jan 2019 09:33:22 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd6NpAoSKuBHCzV2U3Z_cOT9ctf=0nYbYhzRj9opJd9EA@mail.gmail.com>
Message-ID: <CAJKOXPd6NpAoSKuBHCzV2U3Z_cOT9ctf=0nYbYhzRj9opJd9EA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: s5pv210: aries: Add reserved memory for
 mfc
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_003336_260227_949757AC 
X-CRM114-Status: GOOD (  11.33  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 xc-racer2@live.ca, linux@armlinux.org.uk, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, kgene@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCA4IEphbiAyMDE5IGF0IDE3OjU2LCBQYXdlxYIgQ2htaWVsCjxwYXdlbC5taWtvbGFq
LmNobWllbEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gVEhpcyBjb21taXQgYWRkcyBtZW1vcnkgcmVz
ZXJ2YXRpb24gcmVxdWlyZWQgYnkgTUZDIHRvIHJ1bi4KPiBPbiBTNVBWMjEwIGJvdGggcmVnaW9u
cyBuZWVkcyB0byBiZSBvbiBzZXBhcmF0ZSBtZW1vcnkgYmFua3MuCj4gU2l6ZSBvZiBib3RoIHJl
Z2lvbnMgaXMgdGFrZW4gZnJvbSBzdG9jayBzb3VyY2VzLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGF3
ZcWCIENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPgo+IC0tLQo+IENoYW5n
ZXMgZnJvbSB2MToKPiAgICAtIEZpeGVkIG5hbWUgb2Ygbm9kZXMgdG8gYmUgbW9yZSBnZW5lcmlj
Cj4gLS0tCgpUaGFua3MsIGFwcGxpZWQuCgpCZXN0IHJlZ2FyZHMsCktyenlzenRvZgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

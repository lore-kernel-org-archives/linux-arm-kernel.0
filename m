Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86253C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:54:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F06214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I8cKOTlQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nrS9kGV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F06214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mx5xnPZ4h31p+iWrOTSeN58P0Qce6qgENyw7bgOLJfQ=; b=I8cKOTlQWJaKkSulfWkjkWWxa
	1b9XZQqY4vXGQK2GZiuhPuJ/FB2EZdztW7vBGifLMhXK2dmCcZ0l3CdRN/DrnobPiKJLamwPNXN7u
	jFBh8/ty9Qk8Z4E6HYo2BrbyBarppCSwtqWJ2Jjl7PvfLUAtcNBXObtCWmdyAcVQ9lWWquOwhCy8D
	T4pV+mAw76YoqLnN7QVlYzUySyfR8CAMBcFh9uJM+CxprpmtFksLUboR7uLPVN/y4C7i7DyKuOgSS
	BbGGjkHs/r8c0V4U3s26YGYnmR8J2vhp6ECBIlJ/XtJfh2SGUT7XXxJA+9hdP0SqOwoc6JmzDPkdW
	zra/mYHWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWeg-0005kM-GG; Tue, 29 Jan 2019 16:54:34 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWeb-0005jr-Ui
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:54:31 +0000
Received: by mail-wm1-x343.google.com with SMTP id d15so18636734wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 08:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=GpjzAP2LneAS56U0Ij5DEejwXoLkhYaLiAsMKIF9cBg=;
 b=nrS9kGV3iieSKEWQy3vpNtD1iSiItJUUJocks44Ef268HQYy+Zi9HUcQuA5myI8L0y
 nEh8tIuow7trVe8OVZjKFUsNN1eUZDSv1AzZIbpaDWjH/lFbXJdMRBGoPsBZK+t1m8EH
 KUPJUc8T8aGduCjFOvy74M/iwfY85GHLCrZNV/fCBLyqrpdqWsLGyuwZlsEU5rdSz0+A
 QKMqnWiV1X5EMs81VnDX/q3f8xmzXaP+/ttp7xub+AX7fYccE7Do+ettjJhGOxk1TAZ2
 5yC7KwmavyOTH2MVHtKQ2XJ49CySz/ZjdDegiUogKAqIJIJ3ww60cZ2z4Owd5CY4qC74
 mqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GpjzAP2LneAS56U0Ij5DEejwXoLkhYaLiAsMKIF9cBg=;
 b=SVocM1M0dyhsNHu83F0ZT0ra1WH5wRQgjc/KA/dGQawScRlYBYXUv0iDLcNvLLVC4H
 3boeUHiJ3MeRh1Qron6xdRdg0jj8HRF/ksjR1xu0yqlvrEbrIehrLjiQ0p49OX/6xjET
 xBq6CfpmcyQY3UFTwRuxNMRmweLqW/7rlJKnJ/GPHszxLLH60GzbfBZ0gEkVUfQ9Kchm
 wvwoUf8nSkIW76zu6m75Tx5jDMDHfFPltXdPURi65+DZsWRt0AfFW7Ar3w0hsaWXQ6QO
 nJj4QZ9wGS3XfVg8YgTAAy8NXpxHI+FIJCc/wCyIf6nINP5iMyKwDJYwQIm5BmGaF1aN
 Va9Q==
X-Gm-Message-State: AJcUukc8foYKw+lilvfug9wFKsK31jXygXE5pLWPidcYQUx3GmaxyJh1
 YmL7ipHczoizCHo9zJ+J7oY5SFxrtDQ=
X-Google-Smtp-Source: ALg8bN4CZ43Egv+x1+ddmWriJMcsdFztyM47ZW/0kR9nGfI4tsSxa/V0jIMlDjJJi3pf6Ph5WlipPA==
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr21211268wmf.125.1548780867969; 
 Tue, 29 Jan 2019 08:54:27 -0800 (PST)
Received: from ?IPv6:2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6?
 ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id k128sm5055416wmd.37.2019.01.29.08.54.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 08:54:25 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: imx8mq: Add QuadSPI controller
To: Lucas Stach <l.stach@pengutronix.de>, robh+dt@kernel.org,
 mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190129163457.7107-1-ccaione@baylibre.com>
 <1548780179.6869.9.camel@pengutronix.de>
From: Carlo Caione <ccaione@baylibre.com>
Message-ID: <3ff2f0d6-07d2-9ed4-878f-011406f09da3@baylibre.com>
Date: Tue, 29 Jan 2019 16:54:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548780179.6869.9.camel@pengutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_085429_990288_1C8AD96D 
X-CRM114-Status: GOOD (  15.57  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjkvMDEvMjAxOSAxNjo0MiwgTHVjYXMgU3RhY2ggd3JvdGU6Cj4gSGkgQ2FybG8sCgpIaSBM
dWNhcywKCj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNp
Cj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4+IEBA
IC01MTYsNiArNTE2LDE5IEBACj4+PiAgwqAJCQl9Owo+Pj4gIMKgCQl9Owo+PiAgIAo+PiArCQlz
cGkwOiBzcGlAMzBiYjAwMDAgewo+IAo+IDMwYmIwMDAwIGlzIHBhcnQgb2YgdGhlIEFJUFMzIGJ1
cyBhZGRyZXNzIHNwYWNlLCBzbyBwbGVhc2UgbW92ZSB0aGlzIHRvCj4gdGhlIGNvcnJlY3QgbG9j
YXRpb24gd2l0aGluIHRoaXMgYnVzIG5vZGUuCgpUaGUgcHJvYmxlbSBpcyB0aGF0IHRoZSAiUXVh
ZFNQSS1tZW1vcnkiIHJlZ2lvbiBkb2Vzbid0IGZhbGwgd2l0aGluIHRoZSAKbWVtb3J5IHJhbmdl
IG9mIHRoZSBBSVBTMyBidXMsIHNvIHRoZSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UgaXMgZmFpbGlu
ZyAKd2hlbiBtb3ZpbmcgdGhlIG5vZGUgdGhlcmUuCgo+PiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8
MT47Cj4+PiArCQkJI3NpemUtY2VsbHMgPSA8MD47Cj4+ICsJCQljb21wYXRpYmxlID0gImZzbCxp
bXg3ZC1xc3BpIjsKPiAKPiBQbGVhc2UgYWRkIGEgImZzbCxpbXg4bXEtcXNwaSIgY29tcGF0aWJs
ZSBoZXJlLCBhcyB3YXMgZG9uZSB3aXRoIGFsbAo+IHRoZSBvdGhlciBub2RlcyBpbiB0aGlzIGZp
bGUsIHNvIHdlIGNhbiBtYXRjaCB0aGlzIGluIHRoZSBkcml2ZXIgc2hvdWxkCj4gdGhlIG5lZWQg
YXJpc2UuCgpUaGlzIGlzIG9kZCBzaW5jZSBhdCBsZWFzdCBmb3IgdGhlIEFtTG9naWMgU29DcyB3
ZSBhcmUgZ29pbmcgZXhhY3RseSBpbiAKdGhlIG9wcG9zaXRlIGRpcmVjdGlvbiB3aGVyZSB3ZSBh
dm9pZCB0byBhZGQgdW5uZWNlc3NhcnkgY29tcGF0aWJsZXMgaWYgCnRoYXQncyBub3Qgc3RyaWN0
bHkgcmVxdWlyZWQuCgo+PiArCQkJcmVnID0gPDB4MzBiYjAwMDAgMHgxMDAwMD4sIDwweDA4MDAw
MDAwIDB4MTAwMDAwMDA+Owo+Pj4gKwkJCXJlZy1uYW1lcyA9ICJRdWFkU1BJIiwgIlF1YWRTUEkt
bWVtb3J5IjsKPj4+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTA3IElSUV9UWVBFX0xFVkVM
X0hJR0g+Owo+Pj4gKwkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfUVNQSV9ST09UPiwKPj4g
KwkJCTwmY2xrIElNWDhNUV9DTEtfUVNQSV9ST09UPjsKPiAKPiBQbGVhc2UgYWxpZ24gdGhlIHNl
Y29uZCBjbG9jayByZWZlcmVuY2UsIGFzIGlzIGRvbmUgZm9yIGFsbCBvdGhlcgo+IHBlcmlwaGVy
YWwgbm9kZXMgaW4gdGhpcyBmaWxlLgoKSSdsbCBkby4KCkNoZWVycywKCi0tCkNhcmxvIENhaW9u
ZQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK

Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EE3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:21:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5192820842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L0ii89+P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWN/Ll5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5192820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DCdQGkliVf7B9cgyLXuUkNGR146c2ILQR8xIqvZ3j40=; b=L0ii89+P+FytFo
	7ko32mnmgQyR/2WVXXok8+Yjl5BAUGk/EJfuoP7f8MrwG12otTDhzSod6tzvz85YPFoZ0S6IgHVjM
	Nrrb6SMZC52aYQwXJDPoZgglKPnEI+sAEYV6w3iEC6SV1xgP84lBbpo54JqZkc7fUKOrtHhREl9Ch
	8XxBca2rlRZmCx+WsZMbB5ZMEjmPWx2ZgBdsT5HZjyuefUIyDscBbO1L3qjHn1FQp4QIEtGgZce90
	+P57JOVyG4cMQwy2Sh/dS/onUd0rDyUfy7ZB1NfHEzVR0K9bj0Jwjkts2+iVSHs4XRXQBhZolTn8I
	5kWIzuRNuDk7Z9TjwBYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gy8i4-000566-AJ; Mon, 25 Feb 2019 05:21:48 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gy8i1-00055e-3Y
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 05:21:46 +0000
Received: by mail-lf1-x143.google.com with SMTP id n15so5867545lfe.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 24 Feb 2019 21:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fZIN9RloOx6e5QAEgcOLDVZsWmKB21qkK6oSo5r4EGI=;
 b=pWN/Ll5i7UtGwHXFTG8Y4DVvyuN9omCXa787jLSAEnpfbE9kOLAG/SV9mGAoca7BKh
 HsFpc36dFfaii/GrrUSJG1u3R8M5phm0R66Gn5YLYPlxGiOfeGtX8xmSeXdbRJkBpdaH
 pNQ2aFfuY4eLJbvvyJXzhLb0Hqc/v1rHpoLLi4QNapHVQGJbqlBNCvrvewWaEcaS/IXK
 zarw46OQzldicLok789WIxJDBYSxDnI3O9HhuwBr5qOvuZA3i4f7SQ9ebi9F04CcM9Xo
 x3xamlinSaBn/G7ab6YzoGwwZcCVslxcbq5m+D0tetBPUq0ZCN8rBG29ogQdiZ27o3Pf
 c6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fZIN9RloOx6e5QAEgcOLDVZsWmKB21qkK6oSo5r4EGI=;
 b=U6eyUMB4sq1JIQfx9zz03FM09v/eVU8St54rKHLH79z1njcBiNl5H0Jd+kxzX0GDhE
 I3IlzB1LAP5ZPI4BtjXjrI3P+83koY/YPGIBjvqXhslyczCIvOb/FMyiCIpU0EZ/8/Dj
 D/qSuc1sQltJ+baYsQtlqZhL386WP/Og8NSOHrf2Xg+P9oCDWgoa7aTfB5A6n7X/y+dS
 7Ax36SO9bRgs03LgMRKKQ+tMgdAC5QfBZtk5ZhNIysQmnDRbXpaBtObIqyVFhmZn0XBi
 RtaTr1RmMqIa3eXEUG+yI62lSqVtvypzYlkUUT117gOgSCa3neFJrjHDgYLj9hrZQSTn
 c4Sw==
X-Gm-Message-State: AHQUAuZyqWh1cmBuEGR/vTaCJwTQhcLnh+2Mc39OGVz1tDZ1+5HVSv/r
 rcXKf30eulByqkmprMN5E0o=
X-Google-Smtp-Source: AHgI3IZr/4s48smsDa6hQnyGfl0DGQexq5NoVCL2+/7laQoNbc9HKHfg4uy8dsO3UWnkL10Eoze6zw==
X-Received: by 2002:a19:c6cd:: with SMTP id w196mr8482779lff.127.1551072101345; 
 Sun, 24 Feb 2019 21:21:41 -0800 (PST)
Received: from dimatab (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id a23sm492487ljd.20.2019.02.24.21.21.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 24 Feb 2019 21:21:41 -0800 (PST)
Date: Mon, 25 Feb 2019 08:21:55 +0300
From: Dmitry Osipenko <digetx@gmail.com>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Robert
 Yang <decatf@gmail.com>
Subject: Re: [PATCH v6 0/7] Support Trusted Foundations firmware on Tegra30
Message-ID: <20190225082155.1163ed85@dimatab>
In-Reply-To: <20190225040232.GA2242@qmqm.qmqm.pl>
References: <20190222193426.10747-1-digetx@gmail.com>
 <20190225040232.GA2242@qmqm.qmqm.pl>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_212145_173143_490D946C 
X-CRM114-Status: GOOD (  14.32  )
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
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

0JIgTW9uLCAyNSBGZWIgMjAxOSAwNTowMjozMyArMDEwMApNaWNoYcWCIE1pcm9zxYJhdyA8bWly
cS1saW51eEByZXJlLnFtcW0ucGw+INC/0LjRiNC10YI6Cgo+IE9uIEZyaSwgRmViIDIyLCAyMDE5
IGF0IDEwOjM0OjE5UE0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiA+IEhlbGxvLAo+
ID4gCj4gPiBUaGlzIHBhdGNoc2V0IGFkZHMgc3VwcG9ydCBmb3IgdGhlIFRydXN0ZWQgRm91bmRh
dGlvbnMgZmlybXdhcmUgb24KPiA+IE5WSURJQSBUZWdyYTMwLiBQcmV0dHkgbXVjaCBhbGwgb2Yg
VGVncmEzMCBjb25zdW1lciBkZXZpY2VzIGhhdmUKPiA+IHRoYXQgZmlybXdhcmUgYW5kIHVwc3Ry
ZWFtIGtlcm5lbCBjYW4ndCBib290IG9uIHRob3NlIGRldmljZXMKPiA+IHdpdGhvdXQgdGhlIGZp
cm13YXJlIHN1cHBvcnQuICAKPiAKPiBIaSBEbWl0cnkKPiAKPiBJJ3ZlIGFwcGxpZWQgYW5kIHRl
c3RlZCB0aGlzIHBhdGNoc2V0IG9uIG15IFRGMzAwVC4gQm9vdHMgYW5kCj4gc3VzcGVuZHMvd2Fr
ZXMgdXNpbmcgJ3J0Y3dha2UgLW0gbWVtIC1zIDEgLWQgL2Rldi9ydGMxJyBhcyB0aGUgdGVzdC4K
PiBkbWVzZyBhdHRhY2hlZC4KPiAKPiBUaGUgZXhhY3QgdHJlZSB1c2VkOgo+IAlnaXQ6Ly9yZXJl
LnFtcW0ucGwvbGludXggdGYzMDB0Cj4gCj4gRmVlbCBmcmVlIHRvIGFkZCBteSBUZXN0ZWQtYnkg
YW5kIFNpZ25lZC1vZmYtYnkgb24gdGhlIHBhdGNoZXMgd2hlcmUKPiBhcHJvcHJpYXRlLCBhbmQg
dGhhbmtzIGZvciB5b3VyIHdvcmshCgpBd2Vzb21lLCB0aGFuayB5b3UgdmVyeSBtdWNoIQoKUm9i
ZXJ0LCBjb3VsZCB5b3UgcGxlYXNlIGNvbmZpcm0gdGhhdCB2NiB3b3JrcyBmb3IgeW91IHRvbz8K
CkknbGwgcHJvYmFibHkgbWFrZSBhIHY3IHdpdGggYW4gZXh0cmEgbWlub3IgY2xlYW4gdXAgYW5k
IHRoZW4gd2lsbCBhZGQKYWxsIHRoZSBhcHByb3ByaWF0ZSB0YWdzIHRvIHRoZSBwYXRjaGVzLgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=

Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ED3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:48:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05ACE20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nnvfqnag";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="jY4zAGqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05ACE20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t2zFP5C1rWShaLqCqyzMXl9+2HX0Yh4RGml0WR9fuxY=; b=Nnvfqnagq4M6lN
	zXutMmPwhAF/wDdNJE6t0sDn3ufiWaNGDOts5x2NJ2nQI5oRhjvE8uf7Gts7xnDB1vqwL6oWMsUlL
	J9VcK2BjUIqSsUwtIjPuxv1opsO0cB+09Vi77p/hTb62dFb15Nwyw8jf1boMADug3hrlLHDg5cwe0
	t28s50a2cRWOiU58CA6pG55Xs07xvMlO3VBHT7uWtsKuOq6gKq13N/ooUKHhHvZOE7mWL43qOXs2u
	t2nwMEA8CNC/yf1CJW+IvRHVWalmgTgWabaFLtPBQq3fXTdKOSyCAYM/7xtGPM6fESq2SJcqYnCPv
	u9+lxB/TFWFlQNpXw3YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjxjg-0000lU-Du; Thu, 17 Jan 2019 02:48:52 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjxjd-0000l6-6d
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 02:48:50 +0000
Received: by mail-qk1-x742.google.com with SMTP id o125so5180732qkf.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 18:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9li+6dKy82nfP6IXQsUZqEUGFFE4s5Pj00jdazTthFk=;
 b=jY4zAGqe8y8lpCsiqm9m/KgiUQIb1k1LqXm1c1HZwSetLbw3QaLuNxhzvmDtYUikhH
 78ZiNXtzSwVMj5I27BCu4Og6AyvZzw8VHn6R604WuRv1/KwuVye1fws4SAOZ2Do5vobR
 kP6lT2gRCVsplGc/JmboPjzSqK76BiScRtMq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9li+6dKy82nfP6IXQsUZqEUGFFE4s5Pj00jdazTthFk=;
 b=qKBUO///gco8IasTfG+5xn8uJmSdjqrOCzf8hMaALOn50JdGMoDR2ATuzpbh5cVC3j
 81he6MXAZVJjb0LOFc+Zb3yRX1DOahNpBeIomFgxOZhhGjwSbLD74e8i0ovQU6vO3hqK
 s54XFlQrn4iut/7+w2CpXhWXH0lQDsMd8dW7O1a/nr15O0zn6dlaStVgnl3YcNlyNiwR
 ic4fE5s3uFNEI+7VuENmwDCPlXiGWRccJZ1ua8WOi+texJQz5/DMWaRRJByHarBc93EZ
 Bl4wpCJ3dWrIjcWiPlfHMUkGz3VsN0PI0dPgGQMPB2TVDgC/Od7OkDifKBWtF7w6w3QM
 cBZg==
X-Gm-Message-State: AJcUukfRODu6dktvl+f0jqA9YIyq+OT1RrKI3Yj9JN1VFr4zQA9ajaax
 a/1j6PwzEEOvfa6rN+zgfWdN8mSLQqBOH5ngW00dc2i4AH8=
X-Google-Smtp-Source: ALg8bN6S0ZkkQqCqSM52W9OpcMUcZwXcTDuxo85athkDUTfOiowTNeCMIfLjqWY72yeyKjpfjJU/S5kXnmbQZeQpeek=
X-Received: by 2002:a37:61cd:: with SMTP id v196mr9332441qkb.25.1547693327920; 
 Wed, 16 Jan 2019 18:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20181217200405.2904551-1-vijaykhemka@fb.com>
 <20181217200405.2904551-4-vijaykhemka@fb.com>
 <F23E6426-F6FE-4F10-A88A-D5862D5407B4@fb.com>
In-Reply-To: <F23E6426-F6FE-4F10-A88A-D5862D5407B4@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Jan 2019 13:48:36 +1100
Message-ID: <CACPK8Xfn_iNWe+iWash2MV2e+Uz_0mV9Hwz_PdgNzfYpmrLvcw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: aspeed: Add lpc ctrl for Facebook
To: Vijay Khemka <vijaykhemka@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_184849_238175_A881E615 
X-CRM114-Status: UNSURE (   9.68  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 Andrew Jeffery <andrew@aj.id.au>,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMSBEZWMgMjAxOCBhdCAwNTowNiwgVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBm
Yi5jb20+IHdyb3RlOgo+Cj4g77u/T24gMTIvMTcvMTgsIDEyOjA0IFBNLCAiVmlqYXkgS2hlbWth
IiA8dmlqYXlraGVta2FAZmIuY29tPiB3cm90ZToKPgo+ICAgICBBZGRlZCBscGMgY3RybCBkZXZp
Y2UgdG8gZW5hYmxlIExQQyBjbG9jayBpbiBGYWNlYm9vawo+ICAgICBUaW9nYXBhc3MgZGV2aWNl
IHRyZWUuCj4KPiAgICAgU2lnbmVkLW9mZi1ieTogVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBm
Yi5jb20+Cj4KPiBKb2VsLCBDYW4geW91IHBsZWFzZSB0YWtlIGNhcmUgb2YgdGhlc2UgcGF0Y2hl
cyBtZXJnZS4KCkkgZGlkIG5vdCBhcHBseSB0aGlzIG9uZSBhcyBJIHRoaW5rIHRoZSBkZXNjcmlw
dGlvbiB3aWxsIGNoYW5nZSBvbmNlCndlJ3ZlIG1lcmdlZCB5b3VyIGFzcGVlZC1scGMtY3RybCBw
YXRjaC4KCkNoZWVycywKCkpvZWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

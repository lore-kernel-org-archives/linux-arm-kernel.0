Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C53C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:18:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 907CC20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aKQgv1XP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EG1NxRkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907CC20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g/wTq+X6ai0i/A+S0rUaF1XHCIMWn6S4bav5kEaBBiQ=; b=aKQgv1XPLd6f1A
	tGQVBHhY/i221fBB6NSJozqUihHc5fWxs8Mw00TgVSOfsjv8NVpMySECarchNPBPttmMPw8bRyTbB
	zlmkvR1twJyOdoUYGe03UFnvk9hC/aQ4sJTuMcYNE97AVCkG7olkx4un6pJxw4Ce7Ujls8oZ3bERA
	ZKygm60wDSqV47I/TZ0EjpQtJgrs3P3Mf8K2pDWIAEGCl7kNKpCMqW6u33p69OTKZSiAqoxyvOMjV
	L8YylTpvu18CwmYAvSts1gQyC6402uRwAHM0vaD3xg4azDqpF2QZouutC4eMLe1QdzrZZtnX8GlPy
	crjMW82MMTTk4Nb6j0ZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWyn3-0006f5-Ae; Wed, 12 Dec 2018 07:18:41 +0000
Received: from mail-it1-x131.google.com ([2607:f8b0:4864:20::131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWyn0-0006T5-Js
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 07:18:40 +0000
Received: by mail-it1-x131.google.com with SMTP id x124so12905566itd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 23:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=01K55LrWg8mDPy7y63vQLyWuIChpu/tCj0N/PUDMUnI=;
 b=EG1NxRkL+Rr5lycXUTwJ5kFYdnZ4OyyqWvd8F3mz07SONknsUW/CLfaZCqqnDS2jJl
 pDIilqdcjg8Vdo35RO/kz8wCIbLrxx3AtpJn4qYltdKXm2YnNEqwKCrNzCswCPiNWhhc
 2lqh4mtmyiZb6nrpbswmYuW4oqbaAbJ+iWJj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=01K55LrWg8mDPy7y63vQLyWuIChpu/tCj0N/PUDMUnI=;
 b=S80JCSg8JRJpsMmo9mntC/9QrwCvhvu+7p3Trr4ssmr/Gwh605oYxLEhMYZ2KTmYMT
 bEtv0BH8rd90Mi50zJULpbegMl/DjMd9xoZZOS5AmPhYfJO4Z5zlzO/R2XBM0lxe8cnR
 q4YuujXBKvoJq5AM3J/Xn/U7jbxl/x1rLxoF28az2IZTzAbhPml8Jjk2rEpBa9kB8uCk
 /vV8wucbLXKYa5WDLFimDF9Fz+BpOQDQ/Iw/1acbYNKLrGDhb7qyTySXUhlBhfoHXm1N
 xPLgJq9k3ZSrd2/0+pDwnxyKAxKZr6nWtJe6u93a9IuqMpKiLa2QjFQoX2BdODV6zmSC
 +psA==
X-Gm-Message-State: AA+aEWYhC78HkXmGDlyp91SR036GWna5106dcFS6qLBC84OLVEUyIBpr
 v6vLCFda+UQ57BA11eyxIUW/uRgghkqWHuxTh8LX/A==
X-Google-Smtp-Source: AFSGD/UpS9OjypGWzYbGFN6AepyV8iZZYPv7CaHaV3nxqQ+kEfjC6IDqQQJqxv5aRocGQfbCYfSY3X+TqRpdyacIg6g=
X-Received: by 2002:a02:734b:: with SMTP id a11mr17160139jae.62.1544599107235; 
 Tue, 11 Dec 2018 23:18:27 -0800 (PST)
MIME-Version: 1.0
References: <BE9C50D9-738C-4EAD-9BBC-5D1CE6BC077E@kylinos.cn>
In-Reply-To: <BE9C50D9-738C-4EAD-9BBC-5D1CE6BC077E@kylinos.cn>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 12 Dec 2018 08:18:15 +0100
Message-ID: <CAKv+Gu-OWVd_oq-Zb49Kgsswr99oZ5pUOoTN5pkYPFmRDDWoOA@mail.gmail.com>
Subject: Re: Built a neon version copy_page/clear_page is correct?
To: liuyun01 <liuyun01@kylinos.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_231838_660320_C2D30384 
X-CRM114-Status: GOOD (  10.52  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Andrew Pinski <apinski@cavium.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCAxMiBEZWMgMjAxOCBhdCAwNzowMSwgSmFja2llTGl1IDxsaXV5dW4wMUBreWxpbm9z
LmNuPiB3cm90ZToKPgo+IEhlbGxvLCBNYWludGFpbmVyLgo+Cj4gSSB3YW50IHVzZSBuZW9uLWlu
dHJpbnNpY3MgdG8gYnVpbHQgYSBuZW9uIHZlcnNpb24gY29weV9wYWdlL2NsZWFyX3BhZ2UKPiBm
dW5jdGlvbi4gYnV0IEkgZG9u4oCZdCBrbm93IHdoeSBvdGhlciBwbGF0Zm9ybSBoYXZlbuKAmXQg
ZG8gdGhpcyBiZWZvcmUuIHNvCj4gSSBzZW5kIHRoaXMgZW1haWwgdG8gYXNrIGlzIHRoYXQgY29y
cmVjdD8KPgoKY2xlYXJfcGFnZSgpIHVzZXMgREMgWlZBIGluc3RydWN0aW9ucywgc28gSSBkb3Vi
dCB5b3UnZCBiZSBhYmxlIHRvCmltcHJvdmUgb24gdGhhdCB3aXRoIE5FT04gc3RvcmVzLgoKQXMg
Zm9yIGNvcHlfcGFnZSgpLCBwbGVhc2UgZGVzY3JpYmUgYSB1c2UgY2FzZSB3aGVyZSBpdCBpcyBh
CmJvdHRsZW5lY2ssIGFuZCByZWFzb24gYWJvdXQgaG93IG11Y2ggeW91IGNvdWxkIGltcHJvdmUg
cGVyZm9ybWFuY2UgaW4KdGhhdCBjYXNlIGJ5IGltcHJvdmluZyB0aGUgc3BlZWQgb2YgY29weV9w
YWdlKCkgaXRzZWxmLiBPdGhlcndpc2UsCndlJ3JlIGp1c3QgYWRkaW5nIE5FT04gcm91dGluZXMg
Zm9yIHRoZSBzYWtlIGlmIGl0LCB3aGljaCBpcyBhIGJhZAppZGVhIGltby4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

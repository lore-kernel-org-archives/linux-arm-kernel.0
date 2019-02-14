Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655E0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:42:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3439F222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y+0RKWA7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7YSI7RT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3439F222A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AEAB8vXAyR9IrpoLBgDX3cS/UBUMNfdCGkn9WG8RsTM=; b=Y+0RKWA7VstocX
	O+t0mISkNYeuWhnZWgwacGxePy80rZj8DYx6KlCmbaG7OBl4Wpg4hsaBsFuTzprJN2f1uV9G2dEqA
	HA/6Q/MUq/N9fj1j/YF2nwveKWWCWHXaTTHDsNPItQtboFnMVd/92MTmUd8aQOjjQn/STgLIejRwo
	5S9coY0goho7sVaT2UksWnMFKflNWQzUmEbJurCmN5LCFrfpmT5dxZUGOhhr33JQNhoT6tPORCMqM
	MfTtscEHzwl1gQIKMr3LNkscx/0DRWI1+bGOenRiqsePeH6bb1G+ceDMeDqv4Z6QcYW5K8ROga1KV
	eFYCrhoqj98onqEmljxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guD86-0003kO-FP; Thu, 14 Feb 2019 09:16:26 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guD82-0003ic-Fk
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 09:16:23 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so5597410wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 01:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=AChgX3u3Rli6twGz1yDeQumcH7RThDK+xOVT4nhaEk0=;
 b=S7YSI7RT+QeFtmoWOc0H9M+zv+kJMxO0dN/OJefKd/4MAkbxvYwZ2mUHN0/pqOITzO
 /6PJkViy215KipNT9sPTsNr1Fu3jd55tockcdaxQXZ9bC4ctH2zmHNiB4doYUt9AsOrA
 SP9L24p19/ASbgn2eQkFAfn/3H4aUqWlSB7hDuvbDR37M4UNBc5KopNRYBhMErIpWO/H
 pVWgNuuHKEV7Z2NmBCxrhFaaH4WEh0fERz+V/TsXFC4JY9Y0Y34ZobgaMUbUtMqJrNDA
 FPrKfexQsN0bFoqBy4BK4XaDkiZfTPM6J8cJsFapSHoN10/s4YbbTXpeR+KXTvcfh4k0
 16MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=AChgX3u3Rli6twGz1yDeQumcH7RThDK+xOVT4nhaEk0=;
 b=t1NoB3+yJ6wC5Cu/Fw0nxd6BaDjsdDDDWweE8GjbXcFk/KY1btYY50R3qVPxJ3KoyC
 +kHpICtjV99GLbobZ/0yhmrVoLUQkiFAwuQ7pplBiWFs+HupyqQjn3mpCpIKD/KPhGOx
 2JESPu4NgWbQqv/stTJi9juuHhjzPp+2MJtNygu1yXTuBZQMPfRcD/hEPy+fWw6D6f80
 RV0iYom03Ns4vlkmsuLXwkPcoeY9MaKC4AtqXDOsaC8zmkLXhOAYBQ40CDpqxLNqJYh1
 3J5xw1GoChKmK4qa80okPMKFYAzXySwJgbDevT1TeZL19RxFTOuIz6yRP1PCZuidiDRY
 jTBQ==
X-Gm-Message-State: AHQUAubKTVqWmcZSnMjvXjFm/WMR/naYnwpn2Vdoj/gdvX3ClyuBp/Z7
 UVgSKg9Epf1RPXhoToGcBVmRRw==
X-Google-Smtp-Source: AHgI3IYlx/M/oeBxbZiwZg7WFni1Q+g76oFfBJrj8fS3lwhC4EFx9lrwu3PXz7bRyMyHY0vk8Tbtxg==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr2078906wrs.2.1550135780206;
 Thu, 14 Feb 2019 01:16:20 -0800 (PST)
Received: from dell ([2a01:4c8:c:28c9:4c60:37da:d7a:230])
 by smtp.gmail.com with ESMTPSA id h1sm2264525wmb.0.2019.02.14.01.16.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Feb 2019 01:16:19 -0800 (PST)
Date: Thu, 14 Feb 2019 09:16:17 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] mfd: mxs-lradc: Mark expected switch fall-through
Message-ID: <20190214091617.GC13737@dell>
References: <20190211224827.GA28902@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211224827.GA28902@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_011622_523951_9391F261 
X-CRM114-Status: GOOD (  14.60  )
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
Cc: Kees Cook <keescook@chromium.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAxMSBGZWIgMjAxOSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToKCj4gSW4gcHJl
cGFyYXRpb24gdG8gZW5hYmxpbmcgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaCwgbWFyayBzd2l0Y2gK
PiBjYXNlcyB3aGVyZSB3ZSBhcmUgZXhwZWN0aW5nIHRvIGZhbGwgdGhyb3VnaC4KPiAKPiBUaGlz
IHBhdGNoIGZpeGVzIHRoZSBmb2xsb3dpbmcgd2FybmluZzoKPiAKPiBkcml2ZXJzL21mZC9teHMt
bHJhZGMuYzogSW4gZnVuY3Rpb24g4oCYbXhzX2xyYWRjX3Byb2Jl4oCZOgo+IGRyaXZlcnMvbWZk
L214cy1scmFkYy5jOjE3OTo3OiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJv
dWdoIFstV2ltcGxpY2l0LWZhbGx0aHJvdWdoPV0KPiAgICAgaWYgKGxyYWRjLT5zb2MgPT0gSU1Y
MjhfTFJBREMpIHsKPiAgICAgICAgXgo+IGRyaXZlcnMvbWZkL214cy1scmFkYy5jOjE4NTozOiBu
b3RlOiBoZXJlCj4gICAgZGVmYXVsdDoKPiAgICBefn5+fn5+Cj4gCj4gV2FybmluZyBsZXZlbCAz
IHdhcyB1c2VkOiAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTMKPiAKPiBOb3RpY2UgdGhhdCwgaW4g
dGhpcyBwYXJ0aWN1bGFyIGNhc2UsIHRoZSBjb2RlIGNvbW1lbnQgaXMgbW9kaWZpZWQKPiBpbiBh
Y2NvcmRhbmNlIHdpdGggd2hhdCBHQ0MgaXMgZXhwZWN0aW5nIHRvIGZpbmQuCj4gCj4gVGhpcyBw
YXRjaCBpcyBwYXJ0IG9mIHRoZSBvbmdvaW5nIGVmZm9ydHMgdG8gZW5hYmxlCj4gLVdpbXBsaWNp
dC1mYWxsdGhyb3VnaC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBHdXN0YXZvIEEuIFIuIFNpbHZhIDxn
dXN0YXZvQGVtYmVkZGVkb3IuY29tPgo+IC0tLQo+ICBkcml2ZXJzL21mZC9teHMtbHJhZGMuYyB8
IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpB
cHBsaWVkLCB0aGFua3MuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dCkxpbmFybyBTZXJ2aWNl
cyBUZWNobmljYWwgTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3Ig
QVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

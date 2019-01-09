Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621FDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:27:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC6220651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r+Yl8gKY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttPHatCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC6220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0vTuRyE0x4ILrbKwEQ5mKMlmSucY2JSETK9G8cH3pHI=; b=r+Yl8gKYk/2Ezk
	M9gCe1AKAb0yMIYlacme5a3dwPrQ7WnKDMM6KXMkhJhVhKaEz0va+LQhyNgwiaP6hgjnKThPMGUTe
	C5Y/cGV6sT8JTcVOxaJPsPSxvg/C9RuQ4TjmraQOAUfgeBHJPcKCIuBWj3Gz3pT/8FmnAvqdM1bKM
	teMN/Udn4bpJIZKQxsylkd+tsYLTLBzCyxDiR/5f6ZuX2FKkzMJvpesY0WMGqfRSUqvCe10cTGaZ6
	cTs1pHQbDBnUFCDzIwGsw+HWJtXa+KJZpXpE8ili40ub2TH8hzqCmzgyYzciL3qS0A1YvfQBJy7qK
	BY+Uj4O9JK2VrTEQQcAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghB54-0005nO-Oj; Wed, 09 Jan 2019 10:27:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghB52-0005md-9t
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 10:27:25 +0000
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 488C521773
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  9 Jan 2019 10:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547029641;
 bh=6UdRO6Tf7AMjF5v9Te1XpTI0EujpWzfpznZJgcjJ7UA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ttPHatCC2PW+Ga2hQYbNCH731y2SaP4mHMBsIs4UYwszIWFbyacwcnTGjht4Ijsc3
 el2i648hbpX2nf27bdCFSyXFsS59PePxMHohHHLtTEiVR8viwRmXJBRhP8T80z8iRK
 S9LVJT6/Ad/eOH4fUNqmbwWOxSgoDcrVcECF9vBU=
Received: by mail-lj1-f171.google.com with SMTP id v15-v6so5986651ljh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 02:27:21 -0800 (PST)
X-Gm-Message-State: AJcUukcLJhvCH8+RMYn9TLq6eU/dqPJ8VsqKydu99R8hsaX8GHXBjwxV
 cdH4wzJbmvvTKS4WKgnLMSGJKcd6JNsmqLUl45I=
X-Google-Smtp-Source: ALg8bN4dTJCF2aqcXfn0A9E7z4KPjzNDUsO5E4Z7d89fZt0kVfzOjlQEgynwFkU4xzjPtQp7CEtO1vX0QB/t1XOW9mk=
X-Received: by 2002:a2e:551:: with SMTP id 78-v6mr2920278ljf.82.1547029639411; 
 Wed, 09 Jan 2019 02:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-3-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190108200509.30494-3-pawel.mikolaj.chmiel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 9 Jan 2019 11:27:08 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcqcyimyUBD5ka60FZCeehqkE=GNH8YYYkgQpJ4=yQ3nw@mail.gmail.com>
Message-ID: <CAJKOXPcqcyimyUBD5ka60FZCeehqkE=GNH8YYYkgQpJ4=yQ3nw@mail.gmail.com>
Subject: Re: [PATCH 2/4] cpufreq: s5pv210: Don't flood kernel log after
 cpufreq change
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_022724_362519_1DFF93D0 
X-CRM114-Status: GOOD (  11.00  )
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
 linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net,
 linux@armlinux.org.uk, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
 kgene@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCA4IEphbiAyMDE5IGF0IDIxOjA1LCBQYXdlxYIgQ2htaWVsCjxwYXdlbC5taWtvbGFq
LmNobWllbEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBjb21taXQgcmVwbGFjZXMgcHJpbnRr
IHdpdGggcHJfZGVidWcsIHNvIHdlIGRvbid0IGZsb29kIGtlcm5lbCBsb2cuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5jb20+Cj4g
LS0tCj4gIGRyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYyB8IDIgKy0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpBY2tlZC1ieTogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPgoKQmVzdCByZWdhcmRzLApLcnp5c3p0b2YK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK

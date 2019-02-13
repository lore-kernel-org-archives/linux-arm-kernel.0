Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC69C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:29:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6B7222BE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l7BMVGvX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKu2VKHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6B7222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KzvvrxxkWdsSSfi5h71W4flqUfSZfGH6tdSzTC/dXCA=; b=l7BMVGvXUuEU9L
	ogzx89TymXy9EheeAXmDk2kPlJunz36bYlp2FcFFjpDzMPXM3UMSNdxVa3wnEbtX7tvhm2INkilCK
	25p9usdiUt0dycnfDcB0k2JdLVwfKq+FiyLZUK9nNHP3Tyoo2aV40NOtNLGXQCVNYflhHTloZh4CT
	J+gZ2sYSUZJmQoFUOxZfhJTj0RjPpbEJTpq3uKA6SiH+8OgWw4G6hnjENsZO64ffC9BJH/8btNlHt
	9z8YsMV8X1o1P9+o/b+qkQXHzwma2Y2JgV6BPEOufN2qGOIwmeDvPR20vyzcqhQgmp3BlW+i4rfvR
	4Pe/W/7u1vcuXXDXrERg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtozD-0004CB-Ch; Wed, 13 Feb 2019 07:29:39 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoz9-0004Au-JZ
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 07:29:37 +0000
Received: by mail-wr1-x441.google.com with SMTP id i12so1300962wrw.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 23:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=p1ubNWXGHPnF8cNyX5xYmowXhYPVRyQWPlZNKdwfTas=;
 b=hKu2VKHT8ANYSMZfbVUfV7u6JKn6aZ8519m5/Q+ilXS/t8uBxsgQi92Uvx0cchs0k6
 0GS0R8muSud7PJBYF6mhzHEBfe9kHAnBnFfxPan9BeHGfzI//T9ez9hqA3oo816RRmZW
 wpYHbtKPgeW+Ifb3dvO/LCCJgnFyIF4Rj5sXrvmMVbgCDp3Cd5JuqWaO5h2+dhhJag22
 rf+lcITHUlTRnVPG0zKzo+0KtAz8LJKbeIrmRs8fVe5sfktMNzOu0VCf0FAn+CSFdDBx
 KCnYic2FHcgfPwIGxWieKHFvujUmy2bI44eRBnrSvNtkc+swOHwWm7gkl9cWoGDlDU6G
 LxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=p1ubNWXGHPnF8cNyX5xYmowXhYPVRyQWPlZNKdwfTas=;
 b=DHWBJL2/lRqrwZAB3/DYs8Y9zWZn9KKP2wY7rYYDR9IyRAmELRpgfbLTRvPXJCNO93
 vvVFoduhWq/TnylI7sLA0VJd3Auj2142AcSL6WodKS6PGUB7ra45RG4OuBHh2oAQIt1R
 9q3Zj1Y/60nWDRvASE+qplrUfXWZ3QFNYofaGwPFHBXabcsveZZV449ktmGzcohS4tWe
 g3ZCewmqqgXEwaImE2HpBRDYTXVaV/9Mq3ft3VGYXb1/8ISoIaXjAtyIpCzDpBwC76wS
 Jc0A74oL5+Yamtn+Lzg7YAtO+B0txHFIHgTi2oXYL5vSWgGuFyqyCQTD1zAXVQe9oiQG
 1iIA==
X-Gm-Message-State: AHQUAuaRX70RKak+I979RxIMCLGedUHj58vZ2aLoaaXUXQEHIJY7P86C
 YslrPovcb05WB/r9s3ZlOQVQtA==
X-Google-Smtp-Source: AHgI3IZcd4zu/3yvHzkl49HGJ4yreQu5p0YiXKGToLp9LNR1JCXvFQTZLzDX27/8lOJeVrKoRHhVcQ==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr5767032wrx.68.1550042973913; 
 Tue, 12 Feb 2019 23:29:33 -0800 (PST)
Received: from dell ([2.27.35.171])
 by smtp.gmail.com with ESMTPSA id q24sm4487482wmq.16.2019.02.12.23.29.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Feb 2019 23:29:33 -0800 (PST)
Date: Wed, 13 Feb 2019 07:29:31 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/12] mfd/sm501: depend on HAS_DMA
Message-ID: <20190213072931.GD1863@dell>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211133554.30055-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_232935_661785_65DE4EC2 
X-CRM114-Status: GOOD (  18.89  )
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
Cc: linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
 devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAxMSBGZWIgMjAxOSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cgo+IEN1cnJlbnRs
eSB0aGUgc201MDEgbWZkIGRyaXZlciBjYW4gYmUgY29tcGlsZWQgd2l0aG91dCBhbnkgZGVwZW5k
ZW5jaWVzLAo+IGJ1dCB0aHJvdWdoIHRoZSB1c2Ugb2YgZG1hX2RlY2xhcmVfY29oZXJlbnQgaXQg
cmVhbGx5IGRlcGVuZHMgb24KPiBoYXZpbmcgRE1BIGFuZCBpb21lbSBzdXBwb3J0LiAgTm9ybWFs
bHkgd2UgZG9uJ3QgZXhwbGljaXRseSByZXF1aXJlIERNQQo+IHN1cHBvcnQgYXMgd2UgaGF2ZSBz
dHVicyBmb3IgaXQgaWYgb24gVU1MLCBidXQgaW4gdGhpcyBjYXNlIHRoZSBkcml2ZXIKPiBzZWxl
Y3RzIHN1cHBvcnQgZm9yIGRtYV9kZWNsYXJlX2NvaGVyZW50IGFuZCB0aHVzIGFsc28gcmVxdWly
ZXMKPiBtZW1tYXAgc3VwcG9ydC4gIEd1YXJkIHRoaXMgYnkgYW4gZXhwbGljaXQgZGVwZW5kZW5j
eS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiAt
LS0KPiAgZHJpdmVycy9tZmQvS2NvbmZpZyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvS2NvbmZpZyBiL2RyaXZlcnMv
bWZkL0tjb25maWcKPiBpbmRleCBmNDYxNDYwYTJhZWIuLmYxNWY2NDg5ODAzZCAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL21mZC9LY29uZmlnCj4gKysrIGIvZHJpdmVycy9tZmQvS2NvbmZpZwo+IEBA
IC0xMDY2LDYgKzEwNjYsNyBAQCBjb25maWcgTUZEX1NJNDc2WF9DT1JFCj4gIAo+ICBjb25maWcg
TUZEX1NNNTAxCj4gIAl0cmlzdGF0ZSAiU2lsaWNvbiBNb3Rpb24gU001MDEiCj4gKwlkZXBlbmRz
IG9uIEhBU19ETUEKPiAgCSAtLS1oZWxwLS0tCj4gIAkgIFRoaXMgaXMgdGhlIGNvcmUgZHJpdmVy
IGZvciB0aGUgU2lsaWNvbiBNb3Rpb24gU001MDEgbXVsdGltZWRpYQo+ICAJICBjb21wYW5pb24g
Y2hpcC4gVGhpcyBkZXZpY2UgaXMgYSBtdWx0aWZ1bmN0aW9uIGRldmljZSB3aGljaCBtYXkKCkkg
d291bGQgbm9ybWFsbHkgaGF2ZSB0YWtlbiB0aGlzLCBidXQgSSBmZWFyIGl0IHdpbGwgY29uZmxp
Y3Qgd2l0aApbUEFUQ0ggMDYvMTJdLiAgRm9yIHRoYXQgcmVhc29uLCBqdXN0IHRha2UgbXk6Cgog
IEFja2VkLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKLS0gCkxlZSBKb25l
cyBb5p2O55C85pavXQpMaW5hcm8gU2VydmljZXMgVGVjaG5pY2FsIExlYWQKTGluYXJvLm9yZyDi
lIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vi
b29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

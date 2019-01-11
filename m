Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003ABC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:57:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB1C2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WTXVGLXr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDaI5R5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB1C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4HQLNA8A5wwIuUjDcgh9s8PA6lEYY1I1sX8IMrm+kMw=; b=WTXVGLXrUOKaB+
	eA8qFPIaemh+G1vYlTn9Cf6D+o2Jn8EInVfBU2U0ijskNylzf8K7K46bNIgC8mTPLzULTGapUg9sZ
	6+FX2i/iVxDq0qj5TJ5P49+LK3n7U6vDcg+4R58nVEleOzZnydDp2IVcr9v2DZ6pJXcHmQS7B5bpE
	MQaAd0EjMppNq2w0c4sTJ36vPsoi+ynhkyvHCSj7SzSBwhrS12gih7pR6B20HmMzPYgBGevNNFtNX
	LOu1nsrTp7sEwfmK8IDulnoXSG7ZVc06Lx2TdovAxzNMLTmO8iSpTLCJb5HLCAwCERNlO/zkommPm
	/9H1lNKNwUiWwM7+h0cQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2vS-0003CU-II; Fri, 11 Jan 2019 19:57:06 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2vP-0003CA-D2
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 19:57:04 +0000
Received: by mail-lj1-x242.google.com with SMTP id t18-v6so13992040ljd.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 11:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eswW6pPmoA/h3/QhmbMqfmTUvW05b88bNnEHdA3+d6A=;
 b=UDaI5R5DmuTMrG7SiXpaEnPeMZOlf9JHEQ9+Rwo456JSUfJPPoqyjpH1yvhOQ3vCos
 uJ61XQZY+r0EmO4PoF18kvO/fOWPctkdG3i1OK8xGQipfhg5JU6xGSBZ0gPKLf4+8veM
 EyDFaf8UNtVga3frTlh3NRHvf6riSDQtU4QPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eswW6pPmoA/h3/QhmbMqfmTUvW05b88bNnEHdA3+d6A=;
 b=eO8ORQ1wg1/m+lH2NJsv2bBjZHwjjUfEhc/DgJMv0ZSWxnyUq1YK797hgsRw3zFWRL
 POR42+DZxVw5WVdC7E9C6L0ERYE6rJnD4ErD6/cDgyv22UcHWhpYFDShug9jCoKJiW49
 XuO6MA3Tw+ITOWi3SwuomZf/N2qh/OptGDF029lUaDUGC1d2lHERCMOhypRaq6nSijLf
 Vc1u+gxe8bqzuAY4L7cKLzYCDeiOhwou5RohptGcyfVG/xoIg/M4MIVSVqTb5TYJVb82
 mAs3HzEwLRqMolR3RUKyiaSJECbIxx1ROOEzYyJhvMHNBNhNlS4S+tDNAeRZxGz6kPd3
 d9Kw==
X-Gm-Message-State: AJcUukedETH2rw+a8y1roOhElOKEFxla90osxFoH5turliJzVhFYc2bw
 gPrqsrxDKVnJrtyH5jVe29EhfOD8kfYv7m+WthZlqWFTsso=
X-Google-Smtp-Source: ALg8bN5FlB1b1iyIx9fxiN0TNRm4AYHkuzGAgqH2dbXRE0/zOj9/kc3SN+d1U6psL4Y+TLyrgbB/zZo8GNsvydYSkCY=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr9390233ljj.9.1547236621471; 
 Fri, 11 Jan 2019 11:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20190107194523.2772-1-u.kleine-koenig@pengutronix.de>
 <CACRpkdbYizVLtQxh8_ZXWC-d6+E-k0T6Zq67qRJ7ascFGWTXig@mail.gmail.com>
 <20190111150441.rsmize5dudrmgu52@pengutronix.de>
In-Reply-To: <20190111150441.rsmize5dudrmgu52@pengutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 20:56:49 +0100
Message-ID: <CACRpkdbY=ZS0hb2wQfLQMr_=vNAGuMUGnAmwgwZi-hZ-fNdD=Q@mail.gmail.com>
Subject: Re: [PATCH] bus: ts-nbus: remove bus driver without user
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_115703_447391_EB8D6C75 
X-CRM114-Status: UNSURE (   8.88  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, kernel <kernel@savoirfairelinux.com>,
 Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBKYW4gMTEsIDIwMTkgYXQgNDowNCBQTSBVd2UgS2xlaW5lLUvDtm5pZwo8dS5rbGVp
bmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToKCj4gQWNrLiBGb3Igbm93IEknZCBzYXkg
YSBzdGF0ZW1lbnQgZnJvbSBzb21lb25lIHdobyB1c2VzIHRoaXMgc3R1ZmYgYWJvdXQKPiB0aGlz
IGZhY3Qgd291bGQgYmUgZ29vZCBlbm91Z2guIEdpdmVuIHRoYXQgc29tZSB0aW1lIGFnbyBJIHNl
bnQgcGF0Y2hlcwo+IGZvciB0aGlzIGRyaXZlciBhbmQgZGlkbid0IGdldCBhbnkgZmVlZGJhY2sg
ZnJvbSBhbiBpbnRlcmVzdGVkIHBhcnR5WzFdCj4gSSB0cmllZCB3aXRoIHRoYXQgcGF0Y2ggYWRk
aW5nIHNvbWUgbW9yZSBwZW9wbGUgZnJvbQo+IHNhdm9pcmZhaXJlbGludXguY29tIC4uLgoKSSBm
b3J3YXJkZWQgdGhlIGNvbnZlcnNhdGlvbiB0byBKZXJvbWUgT3VmZWxsYSBhdCBzYXZvaXJmYWly
ZWxpbnV4LApsZXQncyBzZWUgd2hhdCBoZSBzYXlzLgoKWW91cnMsCkxpbnVzIFdhbGxlaWoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK

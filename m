Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0323AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:40:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF17218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwT7Oz0b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ce3g6XgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF17218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kUvyC1YlTzDOWf05mHT/rO/S5cOF9Qo3EJBw81r99Vo=; b=lwT7Oz0baU4T2R
	sMSKFxfRSEZyu56X7z07Js9rTrkfr2i89D2MlEHJkPwqNV08MPQurulYBmbT/mMMJy+MFKwoeXCIu
	riFnnpTIC9MFr9R4zUPr1eJ+1vhEcCo1nN5Ky/7S9fbVNioojDU3O5ws7hnKg+Dzwk5QTA5QRFXDN
	DLQHB9jqIqf5WJzHFFVmYSNvnc4L5g7rdTaPOkQoz51s65a3gGYH/IhlUgcV6MWsLyhtBsxGpIsXo
	M4Wxbc/e8HD7R7t21ndtYQT76OHmD6PXDMskPb1gdqJ95Wc1ndl/X/GlOybMjQ1MjGmq9W7Jpi622
	b+h2Ee3fBHmM4Sn9/CkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaGM8-00070e-L4; Fri, 21 Dec 2018 08:40:28 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaGM4-0006zZ-TK
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 08:40:26 +0000
Received: by mail-wm1-x341.google.com with SMTP id y139so4453093wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 00:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=tf1B/0sMesJfH+HmA4iAP0Sn3AZ4Gs7mp4+bQjMC6yQ=;
 b=Ce3g6XgAGR/pchMGQ49V8Snubp160RXDplkt9ta1jK2kH2sO+WZcC3B8EN0dCI4WHL
 sJK6r2sbKOs7a4xwnfWv+Gn8tHe5iHbdl2xT4JjUQ0C3Nd7KfjVi5Lh6WjfteGRturVK
 Y2QtwKsM22jiPp80nTFNc5Jo1HoQLteL1Uzck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=tf1B/0sMesJfH+HmA4iAP0Sn3AZ4Gs7mp4+bQjMC6yQ=;
 b=PGP77zW6H7z7SP/HiXOCt76Ui9YotugLe1Okd9pVJZCuqiejwH9tUI+jiZqbUk1IKP
 HiucWX83MhYay1ABq5f0SpajhM9sdMTO2aAw9bw3dM02oJn3FoZYBEqeKeC0jYxI7wfm
 Ld7FEJiRTRpjD6carqwk5/bo4vXjpCqCe2L4gY941YpLYC1pxy6eNHZTZPtszZXlZk6k
 bvE/wBxR5XVKmLZHEd4c3Fl2pzuLjx9/C0lLytGGlXdeOD6XSBjvdKmZP/bOI88RqK9T
 zJ4wuuSEilcRfFvwQFWUukuN59vckVQlFNcVErswIl9DZ3AMgj7bPpV0ANjkF2G8UP0n
 5lAw==
X-Gm-Message-State: AJcUukejqBzliIbs2KvfBenkgt2wzfRfAzjRmMDChNDkRjJT48unFD7e
 ycsD7JMWgSM0EyWc3/e0J5f+cw==
X-Google-Smtp-Source: AFSGD/U8Jzgwv+Bcm/0I+KzdmlOpTvdbyXBiYapL5R7RxmdAi+gsNj7Q/b2HnmtfHaGIMmmt60IPgg==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr1790293wmd.89.1545381613189; 
 Fri, 21 Dec 2018 00:40:13 -0800 (PST)
Received: from dell ([95.149.164.119])
 by smtp.gmail.com with ESMTPSA id x186sm8881966wmg.41.2018.12.21.00.40.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 00:40:12 -0800 (PST)
Date: Fri, 21 Dec 2018 08:40:10 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH v2 5/8] dt-bindings: mfd: axp20x: Add software based
 soft_start for AXP209 LDO3
Message-ID: <20181221084010.GR4497@dell>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
 <25e67fe9b5397aa5f11bdd7026e4ae6be51dd18b.1544512919.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <25e67fe9b5397aa5f11bdd7026e4ae6be51dd18b.1544512919.git-series.plaes@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_004024_954067_EABD51B5 
X-CRM114-Status: GOOD (  16.53  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Mark Brown <broonie@kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Olliver Schinagl <oliver@schinagl.nl>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAxMSBEZWMgMjAxOCwgUHJpaXQgTGFlcyB3cm90ZToKCj4gRnJvbTogT2xsaXZlciBT
Y2hpbmFnbCA8b2xpdmVyQHNjaGluYWdsLm5sPgo+IAo+IEluIHRoZSBwYXN0LCB0aGVyZSBoYXZl
IGJlZW4gd29yZHMgb24gdmFyaW91cyBsaXN0cyB0aGF0IGlmIExETzMgaXMKPiBkaXNhYmxlZCBp
biB1LWJvb3QsIGJ1dCBlbmFibGVkIGluIHRoZSBEVFMsIHRoZSBheHAyMDkgZHJpdmVyIHdvdWxk
Cj4gZmFpbCB0byBjb250aW51ZS9oYW5nLiBTZXZlcmFsIGVuYWJsZS9kaXNhYmxlIHBhdGNoZXMg
aGF2ZSBiZWVuCj4gaXNzdWVzIHRvIGRldmljZXRyZWUncyBpbiBib3RoIHRoZSBrZXJuZWwgYW5k
IHUtYm9vdCB0byBhZGRyZXNzCj4gdGhpcyBpc3N1ZS4KPiAKPiBXaGF0IHJlYWxseSBoYXBwZW5l
ZCBob3dldmVyLCB3YXMgdGhhdCB0aGUgQVhQMjA5IHNodXRzIGRvd24gd2l0aG91dAo+IGEgbm90
aWNlIGFuZCB3aXRob3V0IHNldHRpbmcgYW4gaW50ZXJydXB0LiBUaGlzIGlzIGNhdXNlZCB3aGVu
IExETzMKPiBnZXRzIG92ZXJsb2FkZWQsIGZvciBleGFtcGxlIHdpdGggbGFyZ2UgY2FwYWNpdG9y
cyBvbiB0aGUgTERPMyBvdXRwdXQuCj4gCj4gTm9ybWFsbHksIHdlIHdvdWxkIGV4cGVjdCB0aGF0
IEFYUDIwOSB3b3VsZCBzb3VyY2UgMjAwIG1BIGFzIHBlcgo+IGRhdGFzaGVldCBhbmQgc2V0IGFu
ZCB0cmlnZ2VyIGFuIGludGVycnVwdCB3aGVuIGJlaW5nIG92ZXJsb2FkZWQuCj4gRm9yIHNvbWUg
cmVhc29uIGhvd2V2ZXIsIHRoaXMgZG9lcyBub3QgaGFwcGVuLgo+IAo+IEFzIGEgd29yay1hcm91
bmQsIGltcGxlbWVudCBzb2Z0d2FyZS1iYXNlZCAncmVndWxhdG9yLXNvZnQtc3RhcnQnCj4gcHJv
cGVydHkgZm9yIEFYUDIwOSBMRE8zIHJlZ3VsYXRvciwgd2hpY2ggaXMgdXNlZCB0byBmaXJzdCBi
cmluZyB1cAo+IHRoZSBMRE8zIHRvIHRoZSBsb3dlc3QgcG9zc2libGUgdm9sdGFnZSBhbmQgdGhl
biBlbmFibGUgdGhlIExETy4KPiAKPiBBZnRlciB0aGF0LCB3ZSBjYW4gc2V0IHRoZSByZXF1ZXN0
ZWQgdm9sdGFnZSBhcyB1c3VhbC4KPiAKPiBDb21iaW5pbmcgdGhpcyBzZXR0aW5nIHdpdGggdGhl
IHJlZ3VsYXRvci1yYW1wLWRlbGF5IGFsbG93cyBMRE8zIHRvCj4gY29tZSB1cCBzbG93bHkgYW5k
IHN0YWdnZXJlZCwgcG90ZW50aWFsbHkgcmVkdWNpbmcgb3ZlcmFsbCBpbnJ1c2ggY3VycmVudC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBPbGxpdmVyIFNjaGluYWdsIDxvbGl2ZXJAc2NoaW5hZ2wubmw+
Cj4gU2lnbmVkLW9mZi1ieTogUHJpaXQgTGFlcyA8cGxhZXNAcGxhZXMub3JnPgo+IC0tLQo+ICBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F4cDIweC50eHQgfCAzICsrKwo+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpGb3IgbXkgb3duIHJlZmVyZW5jZToK
ICBBY2tlZC1mb3ItTUZELWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKLS0g
CkxlZSBKb25lcyBb5p2O55C85pavXQpMaW5hcm8gU2VydmljZXMgVGVjaG5pY2FsIExlYWQKTGlu
YXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5h
cm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

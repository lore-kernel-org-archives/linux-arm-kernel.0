Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8580DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:41:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F9220823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rFbP2itD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UEedMoIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F9220823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xlU0UIRNATIr2t3KBNYikN2xeNXkXosv2PW1P5A5HoM=; b=rFbP2itDoVKdKr
	JkPBnyNCucny4YEg3Ags5dZuwAyg5C2vuYS7vD41msbg9m/qqOq2sY2CXC4as1IMLxny3yFxeZczd
	IeeGB563I31Ofeo8KT87iH38qW381YdOX0SqaJDafTI8B85IHTPYD4g+7mLXxSlpKulDpGuq1xahw
	FELjZYMttefkwc7hS1LUOo0NtCvDTNEes6hiqRMQ9YNjnTKvTe9LUFtVKrss0j1qDSeKueAqQE3j0
	j9fGELLv+s1B3tlTVa1L/uibnUpTOarWKGEx7OTjK4b9tCjD0makWbcp1IewY+v5JjlpIgIzM4rzj
	CY/IbwFArzAZob9N6biA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs9Dl-0000sc-Ok; Fri, 08 Feb 2019 16:41:45 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs9Dh-0000rx-Iq
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 16:41:43 +0000
Received: by mail-it1-x142.google.com with SMTP id b5so10366112iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KQ/vZbTI2xvoNfErWMG1eOo/Dhk/zkEMJp2icouEFAI=;
 b=UEedMoIMo5olfWopXlhwmhXIlQJSjpVwH0OSEJmH47wcJPPuNoN4aQsozljAfJU6zj
 63kWwCtqPVc5nMcwES/QhRF84dHzHVDTjN39sdHtKqAu8RvGhpZc6mF62gzjpVmoW7pM
 cbeOF6/+eeCmTNJyu7DezIzByFTuccXFsinqVQadi8NVUJyDYG+hq2roIlarQ/9e8m1Z
 fmc/0jnPMytAHkKPfSOGLRUFBAwwEVVWwB+mUT2Y/61HpHiwse0L/WzNnUhaGf2SLfKe
 96Q2elI9Jing2Q1X2sim7BLrRH6Y5Cwo8NGY4/wEEXKlvRx0o5qrwhRQRV+Xsepy2kfW
 XTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KQ/vZbTI2xvoNfErWMG1eOo/Dhk/zkEMJp2icouEFAI=;
 b=KSp0iEuMYf03V3juOhsA1g8AA/ffR9lYWxYQG+Fc59xqiJ0yV1q2jACSrmu8aNfMvA
 4Cpkw8nDEYX7SMUzvfkpJZ/VWyPG1rgLtImCghwUbvYCFY4bkSGtrEbiKFVP20O1Xcfa
 jLvXsUkUcDCYpM96bj4S1WpH3/HdJxdlYwxmhGPvRv1mXZt4EAGEuDzlJfFRwipge0/X
 WLHOZYcnH7a7hQlVvGQPhzMBo4yS4WF5t4/i8WlR3cDfFPbEHuQ/FR1hPwLT6cbd4NnU
 KfDLpcg6RLHoqrM5YF+yb+i97d+Eky0Wr1BZg0N4N/+Pnd8OdUry7zI7iEdA7LN7e0H9
 faXA==
X-Gm-Message-State: AHQUAuZWj9Fu2iLiHeMIeibQRxdCFKOaL2cwL/QaMxWZqogCRaesfpIZ
 r0sZrLr2rfWguqK8CUpMM4lnVlrXaMrPBE5h3FOWmQ==
X-Google-Smtp-Source: AHgI3IZgoArtwL9xNz85ka5QvIvv5VH79nGCHRlysDd1ZcvIxjIe/xT2qEB6VsDjGAL5g7V1A8t7M/3lzyc5NWwPoUU=
X-Received: by 2002:a6b:440c:: with SMTP id r12mr7734256ioa.258.1549644100627; 
 Fri, 08 Feb 2019 08:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-33-brgl@bgdev.pl>
 <7471c8db-52f1-4833-d3b7-c606133e7362@ti.com>
In-Reply-To: <7471c8db-52f1-4833-d3b7-c606133e7362@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 8 Feb 2019 17:41:29 +0100
Message-ID: <CAMRc=Mdq7UmY8TFG3igz_X7Z_fhmWYFk66zNfuuNE9YktkrXtQ@mail.gmail.com>
Subject: Re: [PATCH 32/35] ARM: davinci: remove intc related fields from
 davinci_soc_info
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_084141_614469_0E94B1DC 
X-CRM114-Status: UNSURE (   9.65  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Y3p3LiwgNyBsdXQgMjAxOSBvIDE1OjA0IFNla2hhciBOb3JpIDxuc2VraGFyQHRpLmNvbT4gbmFw
aXNhxYIoYSk6Cj4KPiBPbiAzMS8wMS8xOSA3OjA5IFBNLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdy
b3RlOgo+ID4gRnJvbTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJl
LmNvbT4KPiA+Cj4gPiBUaGVzZSBhcmUgbm8gbG9uZ2VyIHVzZWQuIFJlbW92ZSB0aGVtLgo+ID4K
PiA+IFNpZ25lZC1vZmYtYnk6IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXls
aWJyZS5jb20+Cj4KPiBJIGFzc3VtZSB5b3UgYXJlIGdvaW5nIHRvIGRyb3AgdGhpcyBwYXRjaCBh
bmQga2VlcCB0aGUgcHJpb3JpdHkgc2V0dGluZwo+IGNvZGUgYXJvdW5kPwo+Cj4gVGhhbmtzLAo+
IFNla2hhcgoKSSdtIHN0aWxsIGdvaW5nIHRvIGRyb3AgaXQgZnJvbSBkYTh4eCBhcyBpdCdzIG5v
IG5lZWRlZCBBRkFJQ1QuIEJvdGgKU29DcyB1c2UgNyBhcyB0aGUgcHJpb3JpdHkgZm9yIGFsbCBp
bnRlcnJ1cHRzLiBJJ20ganVzdCBnb2luZyB0byBrZWVwCnRoZSBkZWZpbmVzIGZvciBvZmZzZXRz
LgoKQmFydAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=

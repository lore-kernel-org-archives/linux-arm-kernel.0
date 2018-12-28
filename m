Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEFDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:20:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF9A20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 18:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rTB43uUM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4IrFHJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF9A20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aboue/GK7++qcQ7byn39TVdjMY7YTkNqXxspZUYusF0=; b=rTB43uUMiSH9Mb
	dX27VddpCJAiZKjHtW+2dBF0eWEkQ99ix1qTbiasWesur7dKpk6bkZdNek6LJwD3w1LBFn+WVJ0xK
	KY3mHyMUt+oJ+xptdbxGWRa7FJUoTFRKMPKJ1dm8ic8uvyBZ71LfRT1PmiQHR1MaQD6neXCWffT0Y
	P2YNBg0AQuR7DJCi1sVJEXx4VVTp7bqelr6wMZC3QxJg5jM3NTPcJSMmQLcOi26abrwInJ12A9lIH
	3EuRtyt6uxppG8sTadEn4TgXu5XBHlckQQfIt0tyE+y/cANO5HrirOE5XihYiEjip3usQfHHYfyqh
	YjngmDf9qqKe8Teqdisg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcwkW-0003N4-Ax; Fri, 28 Dec 2018 18:20:44 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcwkT-0003MO-Mj
 for linux-arm-kernel@lists.infradead.org; Fri, 28 Dec 2018 18:20:43 +0000
Received: by mail-oi1-x241.google.com with SMTP id v6so17903678oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 28 Dec 2018 10:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o2YXIoyu6bSMKbOxxf+CV2nKYwO4K74uKrdD9f4+e0E=;
 b=q4IrFHJKtGP0RM4MxQTuLvHmJyqKET+5BojWDQHiqrdz2ssf1pIxhDluLaFACnYzlP
 fM9VHZECe8lSg5KF1tYT0OtqhNBC1WB+uBduaJqcellmXMm9kikqqkp5b21SimFSK8Vk
 GpPTWjpm8GnEevvjelGVhvBMPS+kVjU6gi8G4T+J5R4yInUd62N3891qMIggPU+Yc2Rp
 fner+zF/SrjKYIW0uC7xAqqpB40p2TcyEFBoikscH0RADzYNafWN8yfAh8dk/6kxfOQ9
 3frlKqDJ70om14+PNgHBNYmEhgzTLTUk70W3fZfx2bJjXcEI9QaEcykPL22IxycfI2qN
 ObkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o2YXIoyu6bSMKbOxxf+CV2nKYwO4K74uKrdD9f4+e0E=;
 b=iGBfe+QjVQwFMKcccHQSnqJbfiSpYXBbCuYhQw4yWHyPCIb9P49Kwi2BEZxn7Pgfha
 lk+M6MHPPOJTA7YZmCjCjuYol39/C1yxZGKGv4KlrNqE5S43htfXCO7EpKhsO6PWpiWf
 c3MZgeJL/TIngQUvyLu6NES6lZU5izDPqLhubVSEfyJSJgpwsVuOFrFzQ+WJYkCZ5Xs7
 fdptFrWECVfndxlWvkARrwybqng+yyMNoCcgi9u/qI+Xtgtaocj8CI0lx3VxPe7RqQOT
 Gx8K5N1ATUeDm2z5zPMKuEcykvtvbfuzo9Bdr0LvhN04NGxU6jQh7tHxHIeYMWBKOVcn
 LrbA==
X-Gm-Message-State: AA+aEWb/fG+01HOqIk+CvHEm9xzIGqzmJwybPXzEaM3j29BDU6uqudHl
 wyCJ5DdAKFXmeahhwKpPK//SPyBKd9PyAd1qUps=
X-Google-Smtp-Source: AFSGD/Wkie2QMUosQmCIyvZWZnqyOc+ein4UvUeNMqz9+cg9KRobn2FA7dREwy8KmU2GhlKV1hZ/WVqsPuPUSkaYl/Y=
X-Received: by 2002:aca:3011:: with SMTP id w17mr19048334oiw.342.1546021230223; 
 Fri, 28 Dec 2018 10:20:30 -0800 (PST)
MIME-Version: 1.0
References: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1545144107-88378-1-git-send-email-michal.vokac@ysoft.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 28 Dec 2018 16:20:37 -0200
Message-ID: <CAOMZO5CuPr_BxMP_wjPuZNTCinHQ-cb08wPHr=Od_Qw_aafPTw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx: Add Y Soft IOTA Draco,
 Hydra and Ursa boards
To: =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_102041_759244_3A223071 
X-CRM114-Status: GOOD (  10.98  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVm9rw6HEjSwKCk9uIFR1ZSwgRGVjIDE4LCAyMDE4IGF0IDEyOjQyIFBNIFZva8OhxI0gTWlj
aGFsIDxNaWNoYWwuVm9rYWNAeXNvZnQuY29tPiB3cm90ZToKCj4gKyZmZWMgewo+ICsgICAgICAg
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiArICAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3Ry
bF9lbmV0PjsKPiArICAgICAgIHBoeS1tb2RlID0gInJnbWlpLWlkIjsKPiArICAgICAgIHBoeS1y
ZXNldC1ncGlvcyA9IDwmZ3BpbzEgMjUgR1BJT19BQ1RJVkVfSElHSD47CgpBcmUgeW91IHN1cmUg
dGhpcyBpcyBhY3RpdmUgaGlnaD8KClRoZSBGRUMgZHJpdmVyIGlnbm9yZXMgdGhlIHBvbGFyaXR5
IG9mIHBoeS1yZXNldC1ncGlvcyBhbmQgaXQgYXNzdW1lcwp0aGUgR1BJTyByZXNldCBhcyBhY3Rp
dmUgbG93LgoKSWYgaXQgcmVhbGx5IGlzIGFjdGl2ZSBoaWdoLCB0aGVuIHlvdSB3b3VsZCBuZWVk
IHRvIHBhc3MgdGhlCiJwaHktcmVzZXQtYWN0aXZlLWhpZ2giIHByb3BlcnR5LgoKPiArLyB7Cj4g
KyAgICAgICBtb2RlbCA9ICJZIFNvZnQgSU9UQSBEcmFjbyBpLk1YNlNvbG8gYm9hcmQiOwo+ICsg
ICAgICAgY29tcGF0aWJsZSA9ICJ5c29mdCxpbXg2ZGwteWFwcDQtZHJhY28iLCAiZnNsLGlteDZk
bCI7Cj4gKwo+ICsgICAgICAgY3B1cyB7Cj4gKyAgICAgICAgICAgICAgIC9kZWxldGUtbm9kZS8g
Y3B1QDE7CgpJcyB0aGlzIHJlYWxseSBuZWVkZWQ/IFdlIGRvbid0IHVzdWFsbHkgZG8gdGhpcyBv
biBpbXg2c29sbyBkdHMgYm9hcmQgZmlsZXMuCgpPbmx5IG9uZSBDUFUgd2lsbCBiZSBicm91Z2h0
IHVwIG9ubGluZSBvbiBpbXg2c29sbyBhbnl3YXkuCgo+ICsgICAgICAgfTsKPiArCj4gKyAgICAg
ICBtZW1vcnlAMTAwMDAwMDAgewoKTmVlZCB0byBwYXNzICJkZXZpY2VfdHlwZSA9ICJtZW1vcnki
OyIKCj4gKy8gewo+ICsgICAgICAgbW9kZWwgPSAiWSBTb2Z0IElPVEEgSHlkcmEgaS5NWDZEdWFs
TGl0ZSBib2FyZCI7Cj4gKyAgICAgICBjb21wYXRpYmxlID0gInlzb2Z0LGlteDZkbC15YXBwNC1o
eWRyYSIsICJmc2wsaW14NmRsIjsKPiArCj4gKyAgICAgICBtZW1vcnlAMTAwMDAwMDAgewoKTmVl
ZCB0byBwYXNzICJkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOyIKCj4gKyAgICAgICBtZW1vcnlAMTAw
MDAwMDAgewoKTmVlZCB0byBwYXNzICJkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOyIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

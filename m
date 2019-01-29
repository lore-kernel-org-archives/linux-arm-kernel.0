Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E389DC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:33:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43422083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ijcWLVd5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZZN6Wad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43422083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s1GmjEOXBi3adt884iXRS86H1UswXk76YA8jfxbx1cs=; b=ijcWLVd5o7MTAQ
	4padAPCNFcFz/cxJRVnmu4/zq90GKJWcaZSyJCo5P5dqFHk6xgIRPQUO2jkMuzYo44V2ztEzxvTqI
	CBMfXc40QlZ6DOr3TeakhccaWlDL4rSzDJgJMxpPBR9X35vS+qQUc7aJVts/2aigp8dqQwmNeTIqv
	euRMHg3yQW70/7ytdK/NDIpgwgLr1Vgd75vOWFM8PJYzUOrR9p4YtT7HLbzJc2/AJNpXEWP9EXnP5
	IX0nnTcRaucm9sCr0zjk6a9uunWOWcsjfX05BZpGWqPjpc0doH9VsLcF+WaJFf3Jjg/DFLhsW4Hs8
	09FEZfRblnZLnAtkJSpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goSa5-0001C2-Nv; Tue, 29 Jan 2019 12:33:33 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goSWr-000687-39
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 12:30:25 +0000
Received: by mail-wm1-x342.google.com with SMTP id f188so17503761wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 04:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=oE8Qm9PdZluCUZkLGWY+ZFIppoNu/D2qntGj/3XiAXQ=;
 b=LZZN6Wadr4cjXRY+8dG1EeZk5m/TdVcTfpOsZ5V3GC5hu0tCP6jbbMPBh03ne5P1zy
 ghlKYErOvpXI91DIeGX1ODR8VvIyaDe5KPQSfDOG6AzBpYuhi+79EKFNQFSSbLM68h6D
 95Z/d7mkgz/UENS2zkiIHBphbNV6BRLo8vu6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=oE8Qm9PdZluCUZkLGWY+ZFIppoNu/D2qntGj/3XiAXQ=;
 b=bX7PuTJ0MqUA+uhVdlnLbYNBF3xdJsacltuWM8iojuB1Znax2Qv4/LCDLxfaaXXXKW
 Nz8Zpw1i4e6+VtXnxZP4m9zF8Rayz5WKq5EmWB5zIXT7P2DIvdZ0to1URxEoiTaBf/Dj
 M4JM/8KtF44axcM2SBMug8jiotAiVWk2t6SxfHfkuzh6i83vw0yweG7lqz2XzhGBdI1n
 ElGrCf7mlYwe2qX2xdOXh8JtCm/JsS74+PzG7s4jTyIhrWDxslIYhtA50v+b6Pm+sady
 Kfr9FaCtiQqMna/B41HEtdzTw+moz9rqwiW8saIsb45aA0QJfMIyQM1uwa2qCP704cCg
 bxTQ==
X-Gm-Message-State: AJcUukfyV7dqRLh6778Q+A5c+ANNJYYNp7DDYK3M1lWRh1Izrtqq8XX9
 KLNWhXtspt/Kx23YkU8ns87y8w==
X-Google-Smtp-Source: ALg8bN6Dv5bto48uf2VZhK8Y3t2maUaWJp3mSF942fyW3hxN7qnMGNqU1ppDG+NKI3dclarAXzygsA==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr21799557wme.6.1548765010759; 
 Tue, 29 Jan 2019 04:30:10 -0800 (PST)
Received: from dell ([2.27.35.198])
 by smtp.gmail.com with ESMTPSA id l19sm2852142wme.21.2019.01.29.04.30.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 04:30:09 -0800 (PST)
Date: Tue, 29 Jan 2019 12:30:08 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Vijay Khemka <vijaykhemka@fb.com>
Subject: Re: [PATCH v2] dt-bindings: aspeed-lpc: Make parameter optional
Message-ID: <20190129123008.GC24070@dell>
References: <20190118201547.640173-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118201547.640173-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_043013_252934_F8A4DCE3 
X-CRM114-Status: GOOD (  16.63  )
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
 linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAxOCBKYW4gMjAxOSwgVmlqYXkgS2hlbWthIHdyb3RlOgoKPiBNZW1vcnktcmVnaW9u
IGFuZCBmbGFzaCBwaGFuZGxlIGlzIG5vdCBhIHJlcXVpcmVkIHBhcmFtZXRlciwgaXQgaXMKPiBv
cHRpb25hbCB0byBkZXNjcmliZSBpbiBkZXZpY2UgdHJlZSBhbmQgbmVlZGVkIG9ubHkgdXNlIGJh
c2lzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29t
Pgo+IC0tLQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVlZC1s
cGMudHh0IHwgMyArKysKPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+IAo+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVlZC1s
cGMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQtbHBj
LnR4dAo+IGluZGV4IDM0ZGQ4OTA4N2NmZi4uZDI4YzRlMTE3NjExIDEwMDY0NAo+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXNwZWVkLWxwYy50eHQKPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVlZC1scGMudHh0Cj4g
QEAgLTEzNSw2ICsxMzUsOSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ICAtIGNsb2NrczoJY29u
dGFpbnMgYSBwaGFuZGxlIHRvIHRoZSBzeXNjb24gbm9kZSBkZXNjcmliaW5nIHRoZSBjbG9ja3Mu
Cj4gIAkJVGhlcmUgc2hvdWxkIHRoZW4gYmUgb25lIGNlbGwgcmVwcmVzZW50aW5nIHRoZSBjbG9j
ayB0byB1c2UKPiAgCj4gK09wdGlvbmFsIHByb3BlcnRpZXM6Cj4gK1RoZXNlIGJlbG93IHByb3Bl
cnRpZXMgYXJlIG9wdGlvbmFsIHRvIGRlZmluZS4KClRoaXMgbGluZSBpcyBzdXBlcmZsdW91cy4g
IFBsZWFzZSByZW1vdmUgaXQuCgo+ICsKPiAgLSBtZW1vcnktcmVnaW9uOiBBIHBoYW5kbGUgdG8g
YSByZXNlcnZlZF9tZW1vcnkgcmVnaW9uIHRvIGJlIHVzZWQgZm9yIHRoZSBMUEMKPiAgCQl0byBB
SEIgbWFwcGluZwo+ICAKCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNlcnZpY2Vz
IFRlY2huaWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBB
Uk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

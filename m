Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0536C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:01:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DED222D1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nW22W2fF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ta1+v11L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DED222D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qAYew2kvskG7ouf6XLqgiQNCZ1bUbDBdZwWNnVUWdwE=; b=nW22W2fFZLx6d0
	Kxi9LAUyYUbZSouM+TdcTaSj0J6qbSrkysen6+vhUxeYuX13N81zER3NZM21PD2inb6fLfvMUwVPe
	35X8bbyPzvZMbOntR/k4fhryBYGTBzEeY8eold9y6FisNAFvDkhw2mcxeXQW8r9GJUcZdZOv1xhUq
	lE3h5QlkMJC9J8Io03uCGPuEUmjUAp0PimvE8t5tvNO48McfqU9LCz8/eYKOVS/MNIRziGFeDkobG
	6eaqyc5yWT7CMJN5fdwjhzMt1osiLzyuimMhr7J8k7rgbGYTuS4s76J15o1PihKPkOCs/LpUWPeNN
	3HnFKwyovmPwEdOAeM1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtxuQ-0005Be-A3; Wed, 13 Feb 2019 17:01:18 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtxuF-00058p-OR
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 17:01:14 +0000
Received: by mail-pg1-x543.google.com with SMTP id r11so1402825pgp.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 09:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=CsGa6xrCqoqf0+VNg/zr8QUSD2calqzCdb+HFhflSIg=;
 b=Ta1+v11LXRHE/m6bXl5bYCsrBWRz/5QZ7KpLJx/oTBx/nbCuz6bWAvfekWwrVt3Ki1
 0VVTcz9dXsYVNRrA3o3AX381GM9U3qYYxYNYeHIN8DM45K+g9Umf5zS1fvlJyuLd8BM7
 d7Wb9hT5ZOUss5/hrhMHbjTZpBhs13i/WevDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=CsGa6xrCqoqf0+VNg/zr8QUSD2calqzCdb+HFhflSIg=;
 b=O2SwovDce17TtngAe7dtlv4+i4d77O0j6W+rP4+YwsgTPDUucPKlHKpRk8a0ifY02K
 EjkPL0bL3MmXLm7uvxwK2eZ8/gxaZ6BHAckcPAu7E9fUyXcnDhXpnfBZ5Ylw42i8ZmqL
 HD7+lWfMUzXmPDdgoqrhnV8DpZ8Kpq4dBQGcE2+ivFlE9kTJum7SN1QzR9H7ercAeHz0
 gXmlVxgplwN9H1vO9HN/QvSnNRhSdMyhbohohXcqf66RcQcB4cMn7+lt17THY+CM8KT/
 Hq6btpH9rvGd2Mzojg3llZq7weCvnAqTadiGspKChJlJyZH6/BpSzRK7RwSHOYayK5DL
 veAA==
X-Gm-Message-State: AHQUAub5LpgablV+Dnm4bAQhil0HUV6j6QUp//cFhn3dNT8cISD2fW1B
 jNXe+Ot1b5+k+8+5fvqQjAiaaw==
X-Google-Smtp-Source: AHgI3IbLTH8zTax3udBIg0vtWgutmzVS9f7NPA1eVw8b7yj25dnkT5eQqLtSZJNS2N0blTJn4eCqtg==
X-Received: by 2002:a63:9501:: with SMTP id p1mr1302223pgd.149.1550077266604; 
 Wed, 13 Feb 2019 09:01:06 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id b15sm14524523pfj.44.2019.02.13.09.01.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 09:01:05 -0800 (PST)
Date: Wed, 13 Feb 2019 09:01:05 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Pi-Hsun Shih <pihsun@chromium.org>
Subject: Re: [PATCH v4 2/6] remoteproc/mediatek: add SCP support for mt8183
Message-ID: <20190213170105.GX117604@google.com>
References: <20190131093131.245531-1-pihsun@chromium.org>
 <20190131093131.245531-3-pihsun@chromium.org>
 <20190202001749.GT81583@google.com>
 <CANdKZ0ds2s46h-Rs-4aJSuVFkoaeEzXi96m2zbx5XjBhhsc3Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANdKZ0ds2s46h-Rs-4aJSuVFkoaeEzXi96m2zbx5XjBhhsc3Xw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_090107_790676_055A83A6 
X-CRM114-Status: GOOD (  19.73  )
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
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Nicolas Boichat <drinkcat@chromium.org>,
 Erin Lo <erin.lo@mediatek.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBGZWIgMTMsIDIwMTkgYXQgMTE6MjA6MThBTSArMDgwMCwgUGktSHN1biBTaGloIHdy
b3RlOgo+IEhpLAo+IAo+IFRoYW5rcyBmb3IgdGhlIHJldmlldywgd291bGQgYWRkcmVzcyBtb3N0
IGNvbW1lbnRzIGluIG5leHQgdmVyc2lvbiBvZiBwYXRjaC4KPiAKPiBPbiBTYXQsIEZlYiAyLCAy
MDE5IGF0IDg6MTcgQU0gTWF0dGhpYXMgS2FlaGxja2UgPG1rYUBjaHJvbWl1bS5vcmc+IHdyb3Rl
Ogo+ID4KPiA+IEhpIFBpLUhzdW4sCj4gPgo+ID4gYSBmZXcgY29tbWVudHMgaW5saW5lLgo+ID4K
PiA+IEl0J3MgdGhlIGZpcnN0IHRpbWUgSSBkYWJibGUgaW50byByZW1vdGVwcm9jLCBJIGRvbid0
IGNsYWltIHRvIGhhdmUgYQo+ID4gY29tcGxldGUgdW5kZXJzdGFuZGluZyBvZiB0aGUgZHJpdmVy
IGF0IHRoaXMgcG9pbnQgOy0pCj4gPgo+ID4gT24gVGh1LCBKYW4gMzEsIDIwMTkgYXQgMDU6MzE6
MjdQTSArMDgwMCwgUGktSHN1biBTaGloIHdyb3RlOgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9yZW1vdGVwcm9jL210a19zY3AuYyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9tdGtfc2NwLmMKPiA+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwMDAuLjkyMGM4
MWMzNTI1YzJhCj4gPiA+IC0tLSAvZGV2L251bGwKPiA+ID4gKysrIGIvZHJpdmVycy9yZW1vdGVw
cm9jL210a19zY3AuYwo+ID4gPiArICAgICAgICAgICAgIHJldHVybiByZXQ7Cj4gPiA+ICsgICAg
IH0KPiA+ID4gKwo+ID4gPiArICAgICB3cml0ZWwoMHgwLCBzY3AtPnJlZ19iYXNlICsgTVQ4MTgz
X1NDUF9TUkFNX1BETik7Cj4gPgo+ID4gd2hhdCBpcyB0aGUgcHVycG9zZSBvZiB0aGlzIHdyaXRl
Pwo+ID4KPiAKPiBBbnN3ZXIgZnJvbSBFcmluOgo+IFRoZSBjb2RlIG5lZWRzIHRvIGV4ZWN1dGUg
b24gc2Nw4oCZcyBTUkFNLgo+IFdlIG5lZWQgdG8gdHVybiBvbiB0aGUgcG93ZXIgb2YgU1JBTSBi
ZWZvcmUgdXNpbmcgaXQuCgpQbGVhc2UgYWRkIGEgYnJpZWYgY29tbWVudCBzaW5jZSB0aGlzIGlz
IG5vdCBldmlkZW50IGZyb20gdGhlIGNvZGUuCgpUaGFua3MKCk1hdHRoaWFzCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

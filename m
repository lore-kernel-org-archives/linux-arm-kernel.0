Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E823C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:28:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F81217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cRb/Lv+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F81217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tbZQtjQjdTXrnPBDoUbbrdOH7vO/ENPuOig30C6SqwQ=; b=cRb/Lv+zqQD4sU
	zuNw6kKh8utJ0FTRjW0lyaVgJm8JU8cRiqKSnM3SdQJp4bBboYyHHcp10Fl21/zlpbKtbszVIm2a9
	H/4wT6hXkRdYKVghKa83ffBQEA5K8FZnk5+5gcXqswhUjDXMgqmuiIPeY7auQ1f/tI4TCmN3YE3Ky
	dlFQ9HjalVyfYGqsV0yLw/3d24N/fDz9ZWLUgfvLHJXf5xj1S3Rs+s0BfbFSMjoah/VwtZcJUktpT
	yE9Cfr0o1iqLEGLt5OyikM7s4GXqRATda9JoqnoZnnZIDYbYTYAmwvCOXAebMhvPYVkLpC6KwLIuj
	v4WhxdzkhqpujOVL6yeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0FP-0003l8-EU; Thu, 20 Dec 2018 15:28:27 +0000
Received: from mail-qk1-f196.google.com ([209.85.222.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0FM-0003jQ-GF
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:28:25 +0000
Received: by mail-qk1-f196.google.com with SMTP id q70so1206483qkh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:28:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Jq3I+sIGPWuTXU9l2I91zVqcZTURf4bARp+MtSMgm1I=;
 b=qq163c/x40cu5sne8gKBF9W8uLcqM01UkGru+GH8lfA56DboOjLMkVpnfCuoiUj+2l
 u/UTSOz1JvuF01kuU7xYSI5sIchZ8cy3JMa+PQJCs/iv/kLXwW/EOYUo79QHusu6LCTT
 WYkk5LiWp71+a2TuS0YO9yh9rFtwjZi0toBFIN7M5TILM2tcuX0Fd3Ij0Xyk9+u9l1ZP
 ctx+Vsi8uK9kjGoZq5R1/q9GCh2gSLd/NoYtgJW9OQspGbfddnsP+Xac0/9EgqeEsS38
 JseNV1iLFTOnQK9WC28FBJzrqeUtgDY/ijhVlfLJBmW/6r68YnxGuDJRiYeVF9JVHjXw
 XYug==
X-Gm-Message-State: AA+aEWZ29SwI4s8Wcf+z8+UCYhR9H6GxZyx3sra6HoVc7+XRnUUuPj63
 91YY7Dfr1T80rbu0GQxqERTVmHdY/6amJFsNNtU=
X-Google-Smtp-Source: AFSGD/V8H9l/pA3RobftRSciF8rJuTJ5OeZ66JUloZ7THmfqhqtbtiRwleRd6hnPYkmoZ7g4C4qibWr88W9YOlFqNf4=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr23791913qkf.107.1545319692643; 
 Thu, 20 Dec 2018 07:28:12 -0800 (PST)
MIME-Version: 1.0
References: <2071995319.127120.1545163830046@email.ionos.de>
 <20181219101844.6362-1-horia.geanta@nxp.com>
In-Reply-To: <20181219101844.6362-1-horia.geanta@nxp.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 Dec 2018 16:27:56 +0100
Message-ID: <CAK8P3a3RLdRtY2ND0r4VQ5447V1WLYD6b9NcWjYvYR2AUCV1tg@mail.gmail.com>
Subject: Re: [PATCH] Revert "arm64: defconfig: Enable FSL_MC_BUS and
 FSL_MC_DPIO"
To: =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_072824_536263_F052B5DC 
X-CRM114-Status: GOOD (  15.21  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBEZWMgMTksIDIwMTggYXQgMTE6MTggQU0gSG9yaWEgR2VhbnTEgyA8aG9yaWEuZ2Vh
bnRhQG54cC5jb20+IHdyb3RlOgo+Cj4gVGhpcyByZXZlcnRzIGNvbW1pdCBkOTY3OGFkYmU3MzNh
NzcwNDI4YTk4NjUxYmVhYTI4MTdkNTAzZWQzLgo+Cj4gUmVjZWl2ZWQgYmVsb3cgcmVwb3J0IGZy
b20gU3RlZmFuLgo+IFJldmVydCB0aGUgY29tbWl0IHVudGlsIENBQU0gZHJpdmVyIGRlcGVuZGVu
Y3kgY3ljbGVzIGFyZSBmaXhlZC4KPgo+IHRoaXMgcGF0Y2ggaW4gbmV4dC0yMDE4MTIxNCBicmVh
a3MgIm1ha2UgbW9kdWxlc19pbnN0YWxsIiBmb3IKPiBhcm02NC9kZWZjb25maWcgb24gbXkgVWJ1
bnR1IG1hY2hpbmU6Cj4KPiBERVBNT0QgIDQuMjAuMC1yYzYtbmV4dC0yMDE4MTIxNAo+IGRlcG1v
ZDogRVJST1I6IEZvdW5kIDYgbW9kdWxlcyBpbiBkZXBlbmRlbmN5IGN5Y2xlcyEKPiBkZXBtb2Q6
IEVSUk9SOiBDeWNsZSBkZXRlY3RlZDogY2FhbWFsZ19kZXNjIC0+IGRwYWEyX2NhYW0gLT4gYXV0
aGVuYwo+IGRlcG1vZDogRVJST1I6IEN5Y2xlIGRldGVjdGVkOiBjYWFtYWxnX2Rlc2MgLT4gZHBh
YTJfY2FhbSAtPiBmc2xfbWNfZHBpbwo+IGRlcG1vZDogRVJST1I6IEN5Y2xlIGRldGVjdGVkOiBk
cGFhMl9jYWFtIC0+IGNhYW1oYXNoX2Rlc2MgLT4gZHBhYTJfY2FhbQo+IGRlcG1vZDogRVJST1I6
IEN5Y2xlIGRldGVjdGVkOiBjYWFtYWxnX2Rlc2MgLT4gZHBhYTJfY2FhbSAtPiBjYWFtaGFzaF9k
ZXNjIC0+IGVycm9yCj4gZGVwbW9kOiBFUlJPUjogQ3ljbGUgZGV0ZWN0ZWQ6IGNhYW1hbGdfZGVz
YyAtPiBkcGFhMl9jYWFtIC0+IGNhYW1oYXNoX2Rlc2MgLT4gY2FhbWFsZ19kZXNjCj4KPiBSZXBv
cnRlZC1ieTogU3RlZmFuIFdhaHJlbiA8c3RlZmFuLndhaHJlbkBpMnNlLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBIb3JpYSBHZWFudMSDIDxob3JpYS5nZWFudGFAbnhwLmNvbT4KCkkndmUgYXBwbGll
ZCB0aGUgcmV2ZXJ0LCBidXQgSSB0aGluayB0aGVyZSBpcyBzdGlsbCBhIHByb2JsZW0sIHNpbmNl
CmFueW9uZSBjb3VsZCBtYW51YWxseSBlbmFibGUgdGhvc2Ugb3B0aW9ucyBhbmQgc2hvdWxkIG5v
dApzZWUgdGhvc2UgY3ljbGVzIGluIHRoZSBtb2R1bGUgZGVwZW5kZW5jaWVzLgoKSG9yaWEsIGNh
biB5b3UgaGF2ZSBhIGxvb2sgYXQgd2hhdCBjYXVzZWQgdGhhdCBhbmQgaG93IHRvIGZpeCBpdD8K
SXQncyBwcm9iYWJseSBhIGNvbW1pdCBpbiB0aGUgY2FhbSBkcml2ZXJzLiBJIGhhdmUgYWxzbyBj
cmVhdGVkCmEgcGF0Y2ggdG8gYWRkcmVzcyBhIHByb2JsZW0gd2l0aCB0aGF0IGRyaXZlciBidXQg
Zm9yZ290CnRvIHNlbmQgdGhhdCBvdXQsIGl0IG1pZ2h0IGZpeCB0aGlzIG9uZSBhcyB3ZWxsLCBz
ZWUgbXkgZm9sbG93LXVwCnBhdGNoICJjcnlwdG86IGNhYW0vcWkyIC0gYWRkIGEgQ1JZUFRPX0RF
Vl9GU0xfQ0FBTQpkZXBlbmRlbmN5Ii4KCiAgICAgICBBcm5kCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

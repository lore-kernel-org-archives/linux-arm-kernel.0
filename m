Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B988EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:51:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862ED20866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U0RXd+pt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d0UhBioK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862ED20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rTvi4O9fzxQzVKARbsBuDmwam/KJw/u3gkFseSlyaLI=; b=U0RXd+ptytt+RX
	mZeS2X0JzkrF/IZmT43MKGlxKaiW1B0vO0KjNYrFltrzChVKg3XIwFuNJiyaAFag0QpArMxoF7YNE
	vDpPn8JrN3zsvIPWIk4Xk8jhvpTi04ORQGxHIQxTw+gZhjjZ9Nd2IVr/FLRtEGg6B5MAFOGOLa1nf
	eGzfKWzKu8a8f+jx0ZDuiYPHDSb10YYNMd5B4L4Ql7WZqEfq0lg//qWcsJS36TIx8L3FcKlVRJvF+
	q0rxZ647h7QHJzD70zdDAyGe0iFMJePG5c9E5WnFotRLjEBkMjZ10np0AtNpSnl7YC/tufa4gVDNM
	4HpaNcoXUJP0FjH4iEMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZjkq-0001CD-3l; Wed, 19 Dec 2018 21:51:48 +0000
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZjkm-0001BP-GJ
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 21:51:46 +0000
Received: by mail-yw1-xc44.google.com with SMTP id d16so6235304ywa.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 13:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GM5hGu4M0G7cLJiG/Agci333y79vb/B6Mg/bPozxqbQ=;
 b=d0UhBioKbOj3lUW4AGfleaR68HWYnVZ51nyMcG4O+WkRY3xIcpbjHL3t8lSkZPAkRg
 cWh00QeeQeSnJZQ5dJk30aggq6GezcAXHtyUyz6B0UFLiG/a1VChq4/l+jcxjcnvOrzk
 dj4vJSRiE4slCuvIBEKYqRGIZdIkmkPwvRxqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GM5hGu4M0G7cLJiG/Agci333y79vb/B6Mg/bPozxqbQ=;
 b=qjnhKnFvXIlInK77sdaVGW73xzqK7nsXX8o72wQ98llaq7khDmusvin0sYmdfpC2Kp
 4ajkVn8hD0GVO8NRJPGRJRp7oPvoVoiqDOWIwfJZTthem9D5qmN3z+sRDuVWwHUSKLLm
 +YYCeD3k/b04njhpw4/lVRqK2ew7GYoikFzdR0Hy6UtfKoq9mdLNQPgQi60ruzkGBq+w
 lpZ+/rNgCzYkXIKLfXMoPX5+gopy7ju8smOGz2rSIS2/dRyIKeiB7BZY+Id33d/BADip
 r/Ad+qWJQeKNMDlYWv/vs/E5KqeRgg4C9Xo14lZpAnh0uT3laSuk6J+cUQVs/qvDVvoY
 BvVQ==
X-Gm-Message-State: AA+aEWaSKnGMGSZBy97rI3C4k807h2JlMcg3X1LRGS/Arj8RvuA+fkrm
 t6eLKFjbrOmOCzWIZPRBSraeR1Yntjs=
X-Google-Smtp-Source: AFSGD/WOKHe3d8ZFfCzT9Efg7z8XLApewV/2okJ1LuZRkGhDTkSlHr61aY0GfMBjQ9H8Y4ACRFyXOA==
X-Received: by 2002:a81:2790:: with SMTP id
 n138mr24006765ywn.128.1545256291839; 
 Wed, 19 Dec 2018 13:51:31 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com.
 [209.85.219.177])
 by smtp.gmail.com with ESMTPSA id k64sm5411436ywc.56.2018.12.19.13.51.29
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Dec 2018 13:51:29 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id m129so8496355ybf.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 13:51:29 -0800 (PST)
X-Received: by 2002:a25:a445:: with SMTP id
 f63-v6mr21956262ybi.171.1545256289326; 
 Wed, 19 Dec 2018 13:51:29 -0800 (PST)
MIME-Version: 1.0
References: <ecb306ea6f4a83302e78884713ad7823@codeaurora.org>
In-Reply-To: <ecb306ea6f4a83302e78884713ad7823@codeaurora.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 19 Dec 2018 13:51:18 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK68J6xHMva1p6aM0ZoQDyY0QiEV3qW3K8UDoK-OeP5Ng@mail.gmail.com>
Message-ID: <CAGXu5jK68J6xHMva1p6aM0ZoQDyY0QiEV3qW3K8UDoK-OeP5Ng@mail.gmail.com>
Subject: Re: usercopy_warn in __copy_to_user
To: rishabhb@codeaurora.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_135144_542915_A747BA11 
X-CRM114-Status: GOOD (  17.85  )
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
Cc: tsoni@codeaurora.org, linux-arm-msm@vger.kernel.org, ckadabi@codeaurora.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-arm Kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBEZWMgMTksIDIwMTggYXQgMTE6NTEgQU0gPHJpc2hhYmhiQGNvZGVhdXJvcmEub3Jn
PiB3cm90ZToKPgo+Cj4gSW4gdGhlIDQuMTkga2VybmVsLCB3ZSBhcmUgc2VlaW5nIGEgVVNFUkNP
UFlfV0FSTiBpbiBfX2NvcHlfdG9fdXNlcgo+IGR1cmluZyBib290dXAuCj4gVGhlIGNvZGUtZmxv
dyBpcyBzb21ldGhpbmcgbGlrZSB0aGlzOgo+Cj4gKGFyY2gvYXJtNjQva2VybmVsL3NpZ25hbC5j
KQo+IHN0cnVjdCBzaWdzZXRfdCAqc2V0Owo+IF9fY29weV90b191c2VyKCZzZi0+dWMudWNfc2ln
bWFzaywgc2V0LCBzaXplb2YoKnNldCkpCj4KPiAoaW5jbHVkZS9saW51eC91YWNjZXNzLmgpCj4g
X19jb3B5X3RvX3VzZXIodm9pZCBfX3VzZXIgKnRvLCBjb25zdCB2b2lkICpmcm9tLCB1bnNpZ25l
ZCBsb25nIG4pCj4gewo+ICAgICAgICAgICAgICAgICAgbWlnaHRfZmF1bHQoKTsKPiAgICAgICAg
ICAgICAgICAgIGthc2FuX2NoZWNrX3JlYWQoZnJvbSwgbik7Cj4gICAgICAgICAgICAgICAgICBj
aGVja19vYmplY3Rfc2l6ZShmcm9tLCBuLCB0cnVlKTsKPiAgICAgICAgICAgICAgICAgIHJldHVy
biByYXdfY29weV90b191c2VyKHRvLCBmcm9tLCBuKTsKPiB9Cj4KPiAoaW5jbHVkZS9saW51eC90
aHJlYWRfaW5mby5oKQo+IHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBjaGVja19vYmplY3Rf
c2l6ZShjb25zdCB2b2lkICpwdHIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVuc2lnbmVkIGxvbmcgbiwgYm9vbCB0b191c2VyKQo+IHsKPiAgICAgICAgICAgICAgICAgIGlm
ICghX19idWlsdGluX2NvbnN0YW50X3AobikpCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgX19jaGVja19vYmplY3Rfc2l6ZShwdHIsIG4sIHRvX3VzZXIpOwo+IH0KPgo+IFNpbmNl
IHNpemVvZigqc2V0KSBpcyBjb25zdGFudCwgX19idWlsdGluX2NvbnN0YW50X3Aobikgc2hvdWxk
IHJldHVybgo+IHRydWUuCj4gQnV0IHdlIGFyZSBzZWVpbmcgdGhhdCBpdHMgcmV0dXJuaW5nIHRo
ZSB2YWx1ZSBhcyBmYWxzZS4gQmVjYXVzZSBvZgo+IHdoaWNoCj4gdGhlIGNvZGUgZ29lcyBvbiB0
byBfX2NoZWNrX29iamVjdF9zaXplIGFuZCBnZW5lcmF0ZXMgYSBVU0VSQ09QWV9XQVJOCj4gKCJ1
c2VyY29weTogV0FSTigpIG9uIHNsYWIgY2FjaGUgdXNlcmNvcHkKPiByZWdpb24gdmlvbGF0aW9u
cyIpLgo+Cj4gV2UgYXJlIHVzaW5nIExMVk0gY2xhbmcgdmVyc2lvbiA2LjAgdG8gY29tcGlsZSB0
aGUga2VybmVsIGFuZCBub3QgZ2NjLgoKVGhpcyBpcyBmaXhlZCBpbiB0aGUgbGF0ZXN0IExMVk0g
YW5kIENsYW5nOgoKaHR0cHM6Ly9naXRodWIuY29tL0NsYW5nQnVpbHRMaW51eC9saW51eC9pc3N1
ZXMvNwoKLUtlZXMKCj4gSW4gY2xhbmcsIF9fYnVpbHRpbl9jb25zdGFudF9wIGlzIGV2YWx1YXRl
ZCBpbW1lZGlhdGVseSwgYmVmb3JlIGlubGluaW5nCj4gb3Igb3RoZXIgb3B0aW1pemF0aW9ucyBy
dW4sIGdjYyBldmFsdWF0ZXMgaXQgbGF0ZXIuCj4gV2UgYmVsaWV2ZSB0aGF0IG1heWJlIGNhdXNp
bmcgX19idWlsdGluX2NvbnN0YW50X3AobikgdG8gcmV0dXJuIGZhbHNlLgo+IFRoZXJl4oCZcyB1
cHN0cmVhbSB3b3JrIHRvIGNoYW5nZSBMTFZNLCBzbyBfX2J1aWx0aW5fY29uc3RhbnRfcCB3b3Jr
cyBtb3JlCj4gbGlrZSBnY2Mgd2hlbiBvcHRpbWl6YXRpb24gaXMgZW5hYmxlZCwgYnV0IGl0cyBz
dGlsbCBpbiBwcm9ncmVzcy4KPgo+Cj4gRm9yIHRoaXMgc2NlbmFyaW8gaXMgdGhlcmUgYSB3YXkg
dG8gYXZvaWQgdGhlIHdhcm5pbmc/IFNob3VsZCB0aGUgY29kZQo+IGJlCj4gd3JpdHRlbiBpbiBh
IGRpZmZlcmVudCB0byBhdm9pZCBkZXBlbmRlbmN5IG9uIGNvbXBpbGVyPwo+Cj4gVGhhbmtzLAo+
IFJpc2hhYmgKCgoKLS0gCktlZXMgQ29vawoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=

Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E9DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:50:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4A22082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="An1MS/gU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3ihogad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4A22082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HG6IiosVskgzWsOawpfcRfWDtW4kJ2wvNcBS0UjE/UI=; b=An1MS/gU2K+xTF
	GQusEcS7BvccCGvKdm8W9/0Sg1FKYU5MqjhREcoDZHzjww86ESEIjbk2oqzDGn+YHfTUqhuG744HQ
	iuxovULZko8ctH7oc31gE4fsCJjHBMlPwd/hKgdVQoA/9zR/nv1xRCNwI4jwUmA2nQi8Z5J8r114U
	e7gpfpgyWf3/Hyt8IQEvDFe+VpqyFNGY/NaHoCVqsjx/nFUMu8dVKTcO1kbixs0uR1+hRQSTOOKQb
	54cnDZt/PvKJ6IExUxBhgMn5yaKzD9sNS7satbOa3baOU94EIbPnig0XuGSG6Z+n7LNiSlDnp5Lsv
	H+j3g7zE0vKtZMU2lilA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUZRO-00071v-9x; Wed, 05 Dec 2018 15:50:22 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUZRC-0005c0-TO
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 15:50:13 +0000
Received: by mail-it1-x144.google.com with SMTP id c9so20913489itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=33EijjaRJn7ta0WAX4wdrpfQ/2/WNKop22PphZmV99k=;
 b=o3ihogadPxLvTJIIG5KNybtLvemQpjvcWphby7j6wQm30P7bs+xy9w3weJiELT2vjL
 J45H41juD2Dq4CLppa2478kXA7XVe/qYDmej7t/71AttCK4DCvckVVzb73C4B1Q2xUTe
 gYAo2YJAjb+eJP/0Boi4PIY1EGCs3S0RuNQ0VstihnQ5526XFEjw+gXq0/A2/fwrw/sw
 XHiQWvj83O+nezCN6x9CHEZpGgFSTQhZKoVKhjuPnlTKn9fw7VWZg8jjbRK1fYJCmP9U
 XSA6j6319gnPXkpdt2SyiKOu1OurzaMqOe8dChRZQwRdOkQ84Ld1OPJ3ft3Vf6ibwSCK
 XpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=33EijjaRJn7ta0WAX4wdrpfQ/2/WNKop22PphZmV99k=;
 b=qyGmQIBiVrwNAN4OhsdhxuxU5CcrigHnLXWQWgJioNGjIKoAeS8Fr2garIwVogCteZ
 1+yFF787+BBxZ6OVqeWhL7KuacFPwZEVy/7smzQYrztCIjl+WTR5QPUorxm64eBxsJdQ
 TYh/UgA0w6oibJna8dM7cse89Ve/K00JWugeIQQMAPFBfBjVyMj5HI58frj/XeipRzuH
 RPUJqWcOhalzI4lAnDy4G3HthOgeDcqsYfZZtbbQ2gElADKGMahf/O4nJF0XDDMzXBRh
 iTmHt0FXqx1j4uf7OFTK8HvIBtxczA/iO7YPJPEHspLuAHvQZSr+4/nahGTqISwtxf98
 Xx2A==
X-Gm-Message-State: AA+aEWaL1r45703zZPAmEg2g6+C4RJOZqWeTsbkvxXPOuzKnkDDzdaOs
 BgotsaeG+g68SHE4MEPXXjTubyjb1+wANZpVIik=
X-Google-Smtp-Source: AFSGD/WzXyDVsSDMObQ1SC+fV736Y1dqJfBvzUG1N8P7aUgB7+Id1OqXgDcB9Sv2ltb6Jf9SYMVb1ALczuBk6okCt7M=
X-Received: by 2002:a05:660c:250:: with SMTP id
 t16mr15050432itk.78.1544024999722; 
 Wed, 05 Dec 2018 07:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20181130154249.3222-1-tiny.windzz@gmail.com>
 <20181205082719.GF2847@vkoul-mobl>
In-Reply-To: <20181205082719.GF2847@vkoul-mobl>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Wed, 5 Dec 2018 23:49:37 +0800
Message-ID: <CAEExFWu1ahDPqKbYWKPY_bQuw=1Kp1gUki+CpQ7Mq5sNNiy_tg@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: remove DBGFS_FUNC_DECL()
To: vkoul@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_075010_954012_3B8042F2 
X-CRM114-Status: GOOD (  10.06  )
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
Cc: linux-soc@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, okaya@kernel.org, sudeep.dutt@intel.com,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org,
 ashutosh.dixit@intel.com, David Brown <david.brown@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
 dan.j.williams@intel.com, robert.jarzmik@free.fr, daniel@zonque.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBEZWMgNSwgMjAxOCBhdCA0OjI3IFBNIFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5v
cmc+IHdyb3RlOgo+Cj4gT24gMzAtMTEtMTgsIDEwOjQyLCBZYW5ndGFvIExpIHdyb3RlOgo+ID4g
V2UgYWxyZWFkeSBoYXZlIHRoZSBERUZJTkVfU0hPV19BVFRSSUJVVEUsVGhlcmUgaXMgbm8gbmVl
ZCB0byBkZWZpbmUKPiA+IHN1Y2ggYSBtYWNybyxzbyByZW1vdmUgREJHRlNfRlVOQ19ERUNMLkFs
c28gdXNlIG1hY3JvIHRvIHNpbXBsaWZ5IHNvbWUKPiA+IGNvZGUuCj4KPiBTcGFjZXMgYWZ0ZXIg
ZnVsbCBzdG9wIGFuZCBjb21tYSBwbGVhc2UKPgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbmd0
YW8gTGkgPHRpbnkud2luZHp6QGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvZG1hL2Ft
YmEtcGwwOHguYyAgICAgfCAxNCArKy0tLS0tLS0tLS0tLQo+ID4gIGRyaXZlcnMvZG1hL21pY194
MTAwX2RtYS5jICAgfCAyMiArKystLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiAgZHJpdmVycy9kbWEv
cHhhX2RtYS5jICAgICAgICB8IDI0ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+ID4gIGRyaXZl
cnMvZG1hL3Fjb20vaGlkbWFfZGJnLmMgfCAzMyArKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KPgo+IERvIHlvdSBtaW5kIHNwbGl0dGluZyBpdCBwZXIgZmlsZS4KSGkgVmlub2Q6CgpX
aHkgbm90IGFwcGx5IGl0IG9uY2Ug77yfVGhlIGNoYW5nZSBpcyBub3QgdG9vIGJpZy4KClRoYW5r
c++8jApZYW5ndGFvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==

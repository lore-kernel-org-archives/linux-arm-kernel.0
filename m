Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBCAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:07:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7112171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="grUQ/Vm1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Df/29kM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7112171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bsXD7+EI51pGSRj9NEZYuQRuv9DNj9PtAi+MOCSB0Ms=; b=grUQ/Vm1VvafiN
	mV18VmgDxSiW7QCN3xhP0cO7e/eoMyZsnwEiubI3jXOggzE34SPzAAIW7QzZwfq9raqF7D8x8z3wb
	vL/FecBsWyVjf3mS+sldZ3f0yVJ/idUNHaChOX5a5EuFNcREKbZSEZtaIXzA1loqbq6t2gZaTt1RZ
	E8inGqNSi55gcsItgQveMRzXgNf8ZUV9Av86fA3AJzeHDlcP6VSVw/jNhxBTmHXlwK3QsBrNk+iND
	3UsFIzf2qXECosbF8OqSj1+WKobQrBbAjLaHgLWmPf2tYV5lyqgTEp9kFcQOxt7OO1Gb/yelGC4P7
	GPb5f1R1NEpielE8RRZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbxfQ-0003mY-8D; Wed, 26 Dec 2018 01:07:24 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbxfK-0003lI-6Y
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 01:07:22 +0000
Received: by mail-lj1-x243.google.com with SMTP id g11-v6so12797129ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 25 Dec 2018 17:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pA9dTqbl67VOASovxKEwkiuLynEHO/coRCOBN6gbTqQ=;
 b=Df/29kM1eD3/RHN81pc5WF3c4heRiaXJnGZBKE6lXTtoT+m+WuDYuJ2gGDyeXlH4r0
 6IbNE+ShKaFr1+RpGWuNDycCAmt3QdjYhXD3azvZNVi8nRMM6bH5akgnVO7ca8/I5h1n
 L/SSFS6YWXVvyFgjtM6beuMEkrP10avsmrbEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pA9dTqbl67VOASovxKEwkiuLynEHO/coRCOBN6gbTqQ=;
 b=niPpEzpErvAbGey580BMGnUdMnviMXTJDUzqM375a0jUIjrnc62fI66G+nJt98o7zj
 CAu41fLKhmnpVabv1SMJRTpyW7uVfKZTept7kQq+nPy6JtKCPJlF+cp6qcmNpnR14Zlh
 B8Z0NjkgPZXANNXPpTwdYBhpme1wSt/IQffRKBUKUBW6vrOeJ8m3dXSL9cVc7wGzFa+b
 Z02uCLNQMhMSK+7d3OCWBm7zWMqWG0hORq+uDpr5gI3OyeO9A7LpfDhGyuzNKqAgqiXD
 SrIZIWkkks3tO+WnQd3Uxa5+N5fKftybg4WdaC1GUeNtn+YDw7Ivi+0xuE66I3B2Qgcr
 6QhA==
X-Gm-Message-State: AJcUukdpnOtCLcyDyWaQQq0FxkrVYDOJvYCdNtwx/Ia/sHzVf5X5IKr3
 Bxh8THScNjpYPED0quaPa4UYSdLIkbuLtIXfL4M+lA==
X-Google-Smtp-Source: ALg8bN62x7qi0rsKJjROmHk3l0FUunViPBx+DRyZIxINNVFbqc2Z8OnX8Dnu3S0lhFqqH8lXKycyi4BXroVfLIA7zGY=
X-Received: by 2002:a2e:7f04:: with SMTP id
 a4-v6mr11384244ljd.156.1545786423507; 
 Tue, 25 Dec 2018 17:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
 <20181222202623.4521-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181222202623.4521-6-wsa+renesas@sang-engineering.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 26 Dec 2018 09:06:52 +0800
Message-ID: <CABymUCMpU+xwb8aaEgfyMWwyYSR5a33ZXuLseZiiDM7oXyRH5Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] i2c: zx2967: don't open code to reject transfers
 when suspended
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181225_170718_242482_DB6A7C60 
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
Cc: linux-pm@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 linux-i2c@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

V29sZnJhbSBTYW5nIDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT4g5LqOMjAxOOW5
tDEy5pyIMjPml6Xlkajml6Ug5LiK5Y2INDoyNuWGmemBk++8mgo+Cj4gVGhpcyBpcyBoYW5kbGVk
IGJ5IHRoZSBJMkMgY29yZSBtZWFud2hpbGUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBXb2xmcmFtIFNh
bmcgPHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJpbmcuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2ky
Yy9idXNzZXMvaTJjLXp4Mjk2Ny5jIHwgOCAtLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBk
ZWxldGlvbnMoLSkKPgogICAgUmV2aWV3ZWQtYnk6IEp1biBOaWUgPGp1bi5uaWVAbGluYXJvLm9y
Zz4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK

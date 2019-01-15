Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17778C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:09:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A2520657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jiSRX8FR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A2520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qcVuHS7gTjCiiQPQ/Y1GcwgH8Mlj5oX81YcU4r6brAw=; b=jiSRX8FRCzmRaB
	Rb8sa01r0Fg4+B9sVbu8VwTr0kmfHOMiNty/0VglNTowqpZxvrwuWKq2aFUGI4MRgvMefMFr5q12x
	jlrlOpyOTOf+JtJqAEJtvFe431iU5pxcIhE/1PHLjEBXt+QLoQUVq0m6Utk6ygy2Q4F8JJR4xjEXr
	HEuhiKpBdp91jZlV3wWPxUzZY40HUP4rdjcL+cF71XBxpC4anafyWQb2Q3yaOFTAwD/3HEJ+vscaZ
	9tvh9ydaYxNNUONAFXAUHSD0IzAYpbDVNOsyYyQmPE6TizCxcmEk2QEhQalLbnOCTMiCOAwaOyCrq
	wyufplaeGaJIFX3fw6XA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjV1r-00063z-Hk; Tue, 15 Jan 2019 20:09:43 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjV1n-00063X-Ew
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 20:09:41 +0000
Received: by mail-oi1-f196.google.com with SMTP id y1so3129206oie.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 12:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=X2yI7e5P5cHlZreYokFubrfa8z2b0Exxs+RLSwtsMk4=;
 b=iU7EuKx3N7zeb/Xc/XC+9hy1e1gvAj9EZpSEkD6jDSzs2wH8kf5CLAdZBbYEM0fwwk
 fFeY0yqNBD++MKTyPxfbvsHQrhYqfEqG62C0KRho7zXPmhajsfEEiQe/ZqMy+hsRmfmG
 So49ychgMOZ0dAzX0AwKA1KCqBPk7K8rWq4hwQ/nSZm0uftw3eWQrdgdrhGVYamMH9oa
 w62qkHkZlgZrgchPMdHkWTAqUyMKo1XrMNvFUhyb70papZJThfm6ncARZfLr2bxLCyfX
 I9/QzKjgsehu65O2BVmjSes39rriuXvHssbAP+0pVGvYcRc0dZWHvDVTZdABByKZw7qX
 Kk2A==
X-Gm-Message-State: AJcUukf3c0ZLuEzd8embF95a4L8Db+tjwrKnlvDCCOfHccktKMNsKmJk
 uZOB6qkkdDjMRRXgBm1Czg==
X-Google-Smtp-Source: ALg8bN4Y3SYBnD3WyCGD3xjpwdQ7/1yRhPEHfzUscS9OtrUhphDtTpPcuYSgUQG+AvwD9nH4ie/64w==
X-Received: by 2002:aca:b6c3:: with SMTP id g186mr2963515oif.289.1547582978100; 
 Tue, 15 Jan 2019 12:09:38 -0800 (PST)
Received: from localhost ([70.231.7.113])
 by smtp.gmail.com with ESMTPSA id v68sm1893040oie.16.2019.01.15.12.09.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 15 Jan 2019 12:09:37 -0800 (PST)
Date: Tue, 15 Jan 2019 14:09:36 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Subject: Re: [PATCH shawn/for-next v4 1/2] dt-bindings: arm: Add Y Soft IOTA
 Draco, Hydra and Ursa boards
Message-ID: <20190115200936.GA28224@bogus>
References: <1547562139-64730-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547562139-64730-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_120939_500932_9E74475B 
X-CRM114-Status: GOOD (  10.93  )
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
 =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>,
 Andrew Lunn <andrew@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAxNSBKYW4gMjAxOSAxNDoyMjo0NCArMDAwMCwgPT91dGYtOD9CP1ZtOXJ3NkhFalNC
TmFXTm9ZV3c9Pz0gd3JvdGU6Cj4gVGhlc2UgYXJlIGkuTVg2RHVhbExpdGUvU29sbyBiYXNlZCBz
aW5nbGUgYm9hcmQgY29tcHV0ZXJzIHVzZWQKPiBpbiB2YXJpb3VzIFkgU29mdCBwcm9kdWN0cy4K
PiAKPiBDYzogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPgo+IFNpZ25lZC1vZmYtYnk6IE1p
Y2hhbCBWb2vDocSNIDxtaWNoYWwudm9rYWNAeXNvZnQuY29tPgo+IC0tLQo+IENoYW5nZXMgc2lu
Y2UgdjI6Cj4gIC0gTmV3IHBhdGNoCj4gCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vZnNsLnlhbWwgfCAzICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspCj4gCgpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK

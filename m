Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:33:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E1D20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IQpRWOIM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zV1WSOz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E1D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oX0fisg+wPslb5v4CdxcIs7n4M06eawskqyOV9x4A/8=; b=IQpRWOIMmFKc8m
	x3LeUl4d5j/IMIp3NC3Rm3vXQxTD2HS6uDmGrMRI/Ki8SU41MHAfSqX0VRWAzyt3dA8MHil/hWCZI
	RTLzkmqhq6oCf7xSFwkXhvKDi8tboktPzY1/wcJn9FyGE+xbAqAxvyHUAleOhnS3v6ZSwMiFMIHlA
	ji5Qn9h2T9ZUciXhGTiehh7tG6obCengdL62xviKDS2oLbCPyW+8W0KAGVY5E+Rz7PqV7XzJBCBFK
	IRDDWzWWEwHGT3ZJHqQXy2RwGUUfP5IfMe38aNb6z5Dn8SvYG9jbk8Ms9NXfNUy5rm+izqMaPpvJI
	nL+nIfZDUguZ5xMDg6OA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk8j2-0002jd-Rp; Thu, 17 Jan 2019 14:32:56 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk8j0-0002jI-0g
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 14:32:55 +0000
Received: by mail-it1-x144.google.com with SMTP id w18so1645859ite.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zBP68msOjrFahT5eyfFbMaC5hk5eijUODNhs/NVuCbA=;
 b=zV1WSOz0yzhjojGyT424OmgAiXjbmHC7A4SCyQfcvbWtrp/np1ImPAHfx3WxUBBfMV
 /UeI9ksPhur6qitBCnkq7CZZPXxMj2Tb2Y4ZeY/oOGL2YMjX3uRaCkUn9fR0fPuyCuVh
 5V4VLTbUUxO+Y+01RxQeBt/EV3MlyE768DWcJ4mwf2MD3hzq7T3AB9cGnG/vP14nAWc/
 dI5lpNNe2h5nsxq+QbTBIIM1nsWv71iIlB5B8e3M8cCXHfTQyjNlZZJae9/KWfE33OW+
 X1fl9731Zb9R6AF/dLZuWVXzQZyeaEpIYXACBOJAIm18Pr+9r8Rbeg+RCFmYHyLnHuhc
 J43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zBP68msOjrFahT5eyfFbMaC5hk5eijUODNhs/NVuCbA=;
 b=BXeLkJeXYMvFwOwtHyvt0A1jt8MXEnkb1esv0GXU5TtlqCr5f4dDwbcyFiaA36QlDr
 gLp+VK9P6g3tt37YWOr9K7sr1nDJGTL9oWQfgrdZOahVEbF0Yc8YVfONKzGengypHhUs
 49wl9t0FxOFPow5+AO66F55WPp4alTnHpM03Pk4Ai6aDP4hN9mR6KDxWZazBkvOr1N6A
 eahlqxJLTlgFOd7idwUQy1HGV/C7QStyzya4EgApi5NTLbhX1urep3a2NLqrsxNEuZ/k
 Vw49qtYvYaHIZkSkzc/vMN2k5RKD9ZhrSOYKUkBM9HMQ2q+Z36bCppocO5w/zEzDgmYP
 5j4A==
X-Gm-Message-State: AJcUukeddah/kNT/ViDDoxVebt3/gHoIogtHhpb0gf6rHVE05ZfK89mF
 2pQRMCnkv73WBZGhRFz+ZNaEDyx6+0nyaoxMEw606A==
X-Google-Smtp-Source: ALg8bN4Rn8FoYt9A4zaNjmm87FzmLmrDHHRH60STLHqGG1BPNxW2vG7xJT78w6ACvmsqYSAO9NGsV1pLDU/LH+GWpoA=
X-Received: by 2002:a02:650d:: with SMTP id u13mr8610481jab.136.1547735572921; 
 Thu, 17 Jan 2019 06:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-2-brgl@bgdev.pl>
 <250a521a-ba07-ba17-83d8-d9ad8f55a460@ti.com>
In-Reply-To: <250a521a-ba07-ba17-83d8-d9ad8f55a460@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Jan 2019 15:32:42 +0100
Message-ID: <CAMRc=MeA_AMvEikj9s03ikiFJwOi+4eri7Ba8ZxTwMogEJvdrA@mail.gmail.com>
Subject: Re: [PATCH 01/17] ARM: dts: da850: fix interrupt numbers for
 clocksource
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_063254_057909_3277D248 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Y3p3LiwgMTcgc3R5IDIwMTkgbyAxNToyMyBTZWtoYXIgTm9yaSA8bnNla2hhckB0aS5jb20+IG5h
cGlzYcWCKGEpOgo+Cj4gT24gMTEvMDEvMTkgMTA6NTEgUE0sIEJhcnRvc3ogR29sYXN6ZXdza2kg
d3JvdGU6Cj4gPiBGcm9tOiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGli
cmUuY29tPgo+ID4KPiA+IFRoZSB0aW1lciBpbnRlcnJ1cHRzIHNwZWNpZmllZCBpbiBjb21taXQg
MzY1MmUyNzQxZjQyICgiQVJNOiBkdHM6Cj4gPiBkYTg1MDogQWRkIGNsb2NrcyIpIGFyZSB3cm9u
ZyBidXQgc2luY2UgdGhlIGN1cnJlbnQgdGltZXIgY29kZQo+ID4gaGFyZC1jb2RlcyB0aGVtLCB0
aGUgYnVnIHdhcyBuZXZlciBzcG90dGVkLgo+ID4KPiA+IFRoaXMgcGF0Y2ggbXVzdCBnbyBpbnRv
IHN0YWJsZSBzaW5jZSwgb25jZSB3ZSBpbnRyb2R1Y2UgYSBwcm9wZXIKPiA+IGNsb2Nrc291cmNl
IGRyaXZlciwgZGV2aWNlcyB3aXRoIGJ1Z2d5IGRldmljZSB0cmVlIHdpbGwgc3RvcCBib290aW5n
Lgo+Cj4gSXMgdGhpcyB0aGUgY2FzZSB3aGVyZSBzb21lb25lIHVzZXMgZGV2aWNlLXRyZWUgZnJv
bSBhIHN0YWJsZSB0cmVlIGFuZAo+IGtlcm5lbCBmcm9tIGxhdGVzdCBtYWlubGluZT8KPgoKV2Vs
bCwgaWYgc29tZW9uZSB3YW50cyB0byB1c2UgYW4gb2xkIGRldmljZSB0cmVlIGFuZCBhIG5ld2Vy
IGtlcm5lbCwKdGhlbiBpdCdsbCBiZSBicm9rZW4gYW55d2F5LiBJZiB3ZSBnZXQgaXQgdG8gc3Rh
YmxlIHRoZW4gYXQgbGVhc3QgdGhlCmZpeGVkIGRldmljZSB0cmVlIHdpbGwgd29yayBpbiB0aGUg
ZnV0dXJlLiBUaGF0IHdhcyBteSByZWFzb25pbmcuCgpCYXJ0CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

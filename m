Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A164CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:04:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443592082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="frjcCVEK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogDpR9hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443592082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TVSBVf96+NeP+2kkXWWtgSvzfL0x9Od0ymVUgDBiw7g=; b=frjcCVEKaToTDd
	SdfbnTNhgz+x6ohV6N5yE0JXs5pb1VAk3mMgd+7dK2uDNK0eMkGxLiQiYs+16K6miVbYklImN7cS/
	Oity+5dNV5vxGCrdbWWTNO9xHASd7qfbBVlOamRbDJio2BxeUxmjCQ4LuEFt2Qv8Y/QTfJ6DBNKVa
	NUOGNGHKlB2G4x/2W5zhN9sRxfok7s/klgA0ca5wNu1zn1Osx5I+lPPOsSmzAZYxhpiTyIaYK8xgF
	/cfpLnzGxg+0RoDK7E3BZYfuWaOUSb9dgM1DeLw/hZy9r4hA7txPUKxxjeH8grwFC1jCHo23vNBUH
	T1rmQRrJAzDo44Eaf45g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gji3x-0000RR-4t; Wed, 16 Jan 2019 10:04:45 +0000
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gji3t-0000QZ-A4; Wed, 16 Jan 2019 10:04:42 +0000
Received: by mail-qk1-x744.google.com with SMTP id a1so3405022qkc.5;
 Wed, 16 Jan 2019 02:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZdRJ//Al+7TrpSHqfgXJa9IQ9Wno7RlwX5/uoypigaE=;
 b=ogDpR9hjHUkL9ki0B3c+nx3Aum6eJbEz3z5kPph1GVnzZW49vE82rLVUKnco6n/BUt
 Oxy/ygWmzFfCn7vpQ+lU1WIENPBHVC1HZRBlgO1YemQ1AFelm0q8q5ObJjiTr7s5pDp+
 THUniQ7848PSuN/lTB9pQrNFO6iaHSvQmur91Otp3MRcwcA9kRn/kJXrDptcnHhD0kS4
 HlANwezIjrrFaPSpDHNeH58eT82lLbz9F6qxTQzzleYngCGt/RUxDO9ld/N+RbruJ4oE
 CoKCvvofnMNQhv6ccIW3O0hl9+JVfXTMS/gSU/ddOedW/bHdPL8pf0r+ygmAllWICg6O
 bFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZdRJ//Al+7TrpSHqfgXJa9IQ9Wno7RlwX5/uoypigaE=;
 b=QEJzrg80jJE1bDDx2FAcMOhsrA6jWcvhwg6aaAfELcRUzA1SF3GpFlczjB5X9dP75K
 3JBcp76LRLfIcxCQqknPwqAxHO55kYX3X1IWg1brDEvD4ggV8/O80RbKIDlBKcKG6U3E
 Rkz5WTfk48B9h5+oEvc1syKfRPSUY0oCpGZsidHjp/7gT3LZCR4WOkUPh+AQAfzrj5Dd
 mjj+hGR4z+kyhyYxkIElfZBrPMl+sVFwOSKR0PSjY7YwWzixW4BoG/9xXrfXZwrd24id
 rYrCjQZA1+M8P93kH4OlsDekI6NWgyg1AxOaMpS2P8WUfy0jDZWsSg+L4fAk6t+0wpme
 7m8w==
X-Gm-Message-State: AJcUukcaZeir5WZ+RVjqlbfnBtkYNPzx85QaNPVXKaZRXZcZehTYRRuo
 kNieq9+dzpIgwFpXDBT+pq+bZWjgElte7WvLUbY=
X-Google-Smtp-Source: ALg8bN6A9T3bU1dtHUmI5aKbuXFGUonsRZUuII6/cTSUgeBm227/Rsi4Mx59hzAgKoCnPwR3/2mG0ufGZ52MUh5T9ic=
X-Received: by 2002:a37:6442:: with SMTP id y63mr6009160qkb.119.1547633079483; 
 Wed, 16 Jan 2019 02:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20190109171415.9954-1-enric.balletbo@collabora.com>
 <5125335.cuvu72hbmo@phil> <8a0ea28a-961f-130b-bd76-9dbda42ea417@ti.com>
In-Reply-To: <8a0ea28a-961f-130b-bd76-9dbda42ea417@ti.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Wed, 16 Jan 2019 11:04:28 +0100
Message-ID: <CAFqH_52gy8oUUAy61O+gMycd08Q22ZS1mqh6fm6TXzKfO1CgyQ@mail.gmail.com>
Subject: Re: [PATCH v2] phy: phy-rockchip-inno-usb2: drop reading the
 utmi-avalid property
To: Kishon Vijay Abraham I <kishon@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_020441_353490_63AA78AF 
X-CRM114-Status: GOOD (  13.38  )
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
Cc: Heiko Stuebner <heiko@sntech.de>, Guenter Roeck <groeck@google.com>,
 kieran.bingham@ideasonboard.com, linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, kernel@collabora.com,
 Benson Leung <bleung@chromium.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Missatge de Kishon Vijay Abraham I <kishon@ti.com> del dia dc., 16 de
gen. 2019 a les 9:46:
>
> Hi,
>
> On 10/01/19 5:56 PM, Heiko Stuebner wrote:
> > Am Mittwoch, 9. Januar 2019, 18:14:15 CET schrieb Enric Balletbo i Serra:
> >> That property is no used in mainline and is not documented. The only
> >> board using that property is the rk33-99-evb-rev1 and -rev2 in the
> >> vendor kernel. The existence of a further -rev3 (which also looks way
> >> better cared for compared rev1+2) indicates that the older ones are
> >> probably some sort of preproduction models, where some wiring (on the soc
> >> or board) may have gone wrong.
> >>
> >> It is also not clear why this is a hardware-description or a DT
> >> property, so, as noboby seems to care of this just drop reading that
> >> property.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> For some reason, I don't seem to have the original patch in the inbox. Can you
> resend it please?
>
Yes, seems that for some reason my script to add the maintainers
failed, sorry about that. I'll resend the last three patches.

> Thanks
> Kishon
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

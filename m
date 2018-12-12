Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F90C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:39:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1332084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FYI17/wR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NfcuQqmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1332084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W3qcHhPRr6kq5qpdpAWRw8Ks/K5pXS2wun/kDzq5sK8=; b=FYI17/wRnSEP5L
	liJdUTRgWgqskBwNXUWUvO1RQAqIGw1CZTobIrvfe0g/Gih8DUanTzvUYmyqKmacjni8Wtqtri34x
	XdGF6C9NnzUbdlVEeeP6jEWP0x5ZmOnIwLFKSw9UOb0vMedZadhl/2zc/ADVlb9nLiXnD7MJ+wfMD
	vdNzDi0ipOuyi0AD64Y5iuPTqzKV8DPtrQzn/FoEy9Gv526ZWn0rcE6dif2nm0COefnBmKjW4FDBr
	51oYfu6I65y9MDvqketLedY0M7UIun6+Q0gu+e5Fm44Z01n1FO71NCRHXvcaJx2hdxndIDuCCktQX
	TCymafAKIyiVlPluo0aA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3nx-0003hL-AN; Wed, 12 Dec 2018 12:39:57 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3nt-0003eJ-3J
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 12:39:55 +0000
Received: by mail-wr1-x442.google.com with SMTP id j2so17572186wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 04:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=J0ei1kwZyhqYGIfpGeg+JUNQ8JWaYJvOQ2erDW/ftt0=;
 b=NfcuQqmWCfRnrZ319gPr2DrCIbG3YA86Nhfku31BBeVHB1Ml1cwDJmK/8IxSlfuFi3
 NgkpS4mvhJ+3GiuNy1T5QIxXgswjeWkFZ+XHOEqHkqCcaLg2zrXMvCP9Xer/IDEWZf2i
 15khR8prPKYzFmmtOYQLq2awJPprfU2RzOFBX8r5DN4hBBdvZ1brUuaVqR3RprRdda3J
 NWCsZhPM1/QqKXaRmWV8H+2zRu4Q2dKDmkrekzryLGld5e14S7w63FTOCtSl+8nlijKJ
 ZZJWDXc/EWbVZv3LxEY3x2uEqofsECDInFD5QNV/GEou9/r4z/0g/N+nza0kQk9iNz5P
 sf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :organization:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=J0ei1kwZyhqYGIfpGeg+JUNQ8JWaYJvOQ2erDW/ftt0=;
 b=Z4L1ddudP8jhvv0iOLPUirS2hqEnqm9ElyuFOdt9ZmhXQ1df3Yq3aR24zV8Jr7tukT
 HXCSxaFAPh9xKC+3zo7Vp8BjLvpY8RgxAZq5DhASaLo8+R4m/SlpMsQZId5YGrBJ0NGD
 tfLX8F7ZFtWha3u6B/GQrMt2ubXI8IphR/8NCmvRS8Bd/jkzv6gt8RbT1++grSY19K0U
 /hltplT9VFPGajnriltzUBBjP6HrRkjwxXoA7N0feZmpvVHCa42LFm9cY2UuuOuYVeSP
 6Q2jx1omWSYb58X7swwP76l8uXGzBGhn675bXLX+LXmk9/jpxNFaTDqn6sXU0dmbRYBE
 oz0w==
X-Gm-Message-State: AA+aEWZDee0NJ9JZ0zzMsMkmqy0ZltPde51mu/9lpWj59uPFHcj7q/Dh
 HtZ3QVvoe/8WeHaliihKQuiFgw==
X-Google-Smtp-Source: AFSGD/XCS/2Xwv5s62agkojHgttwWO1wilmiS2vYXJMHTvJ88LHf/8izGlVllHN6Lb9gRp+WOtqVeg==
X-Received: by 2002:adf:fb4c:: with SMTP id c12mr16501960wrs.297.1544618381382; 
 Wed, 12 Dec 2018 04:39:41 -0800 (PST)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id j24sm16176525wrd.86.2018.12.12.04.39.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 04:39:40 -0800 (PST)
Subject: Re: [PATCH RESEND] drm/meson: remove firmware framebuffers
To: Maxime Jourdan <mjourdan@baylibre.com>
References: <20181210092853.13050-1-mjourdan@baylibre.com>
 <c5138091-d801-8b2a-85ab-d815f0508933@baylibre.com>
 <CAMO6nay4+8Y_O2iTWJ041Bt0+3VUuOQj0WEN3Pyf6L80vuxHTA@mail.gmail.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <19df7254-3fec-fb60-7581-54cf22e10509@baylibre.com>
Date: Wed, 12 Dec 2018 13:39:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMO6nay4+8Y_O2iTWJ041Bt0+3VUuOQj0WEN3Pyf6L80vuxHTA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_043953_145733_91815F91 
X-CRM114-Status: GOOD (  19.13  )
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
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/12/2018 13:22, Maxime Jourdan wrote:
> Hi Neil,
> On Wed, Dec 12, 2018 at 10:55 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Maxime,
>>
>> On 10/12/2018 10:28, Maxime Jourdan wrote:
>>> In case we are using simplefb or another conflicting framebuffer, make
>>> the call to drm_fb_helper_remove_conflicting_framebuffers()
>>>
>>> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
>>> ---
>>>  drivers/gpu/drm/meson/meson_drv.c | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
>>> index d3443125e661..afbb3d707d15 100644
>>> --- a/drivers/gpu/drm/meson/meson_drv.c
>>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>>> @@ -159,6 +159,23 @@ static void meson_vpu_init(struct meson_drm *priv)
>>>       writel_relaxed(0x20000, priv->io_base + _REG(VPU_WRARB_MODE_L2C1));
>>>  }
>>>
>>> +static void meson_remove_framebuffers(void)
>>> +{
>>> +     struct apertures_struct *ap;
>>> +
>>> +     ap = alloc_apertures(1);
>>> +     if (!ap)
>>> +             return;
>>> +
>>> +     /* The framebuffer can be located anywhere in RAM */
>>> +     ap->ranges[0].base = 0;
>>> +     ap->ranges[0].size = ~0;
>>> +
>>> +     drm_fb_helper_remove_conflicting_framebuffers(ap, "meson-drm-fb",
>>> +                                                   false);
>>
>> I always wondered, where does the "meson-drm-fb" comes from ???
>>
>> Neil
>>
> 
> This name ultimately ends up in a printk and has no functional impact.
> See drivers/video/fbdev/core/fbmem.c:1613 :
> 
> printk(KERN_INFO "fb%d: switching to %s from %s\n", i, name,
> registered_fb[i]->fix.id);
> 
> I just picked one that was similar to the names of other drm drivers
> calling drm_fb_helper_remove_conflicting_framebuffers().

Ok Cool !

> 
> Maxime
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

I'll push it when the bindings are acked and when v4.21-rc1 is tagged !

Neil

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

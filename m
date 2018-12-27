Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3275C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:05:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E5720861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PgunmR84";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egOkD9gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E5720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nTcRbHblX+mJ6jYADfafbcXBxBeub7Qkze1LyWp0HC4=; b=PgunmR840IYvlX
	445RQDKnPxlCXjblsqj1goa3/HQ1UdjxL5bVkj/mAU7fSMEp98zb9pRQNDilhD0vP2lPhR6z+t0kJ
	FKXEeIdAKYT8tcWIzEhPKlgnvr0AlZ7ILHq6+tfIsiQG4E82v57VB8wjYyQ4dhNvPfJ/1wV/dMTMe
	nfK08n1dYiEgiwy54P7z11tnC+BDyD3Zi5IwVGBy7xmFZyX7fHZW0qMLdArmS7Eb42cBqaTIEpoO2
	IFyafcIXmtksyzOoHCaxxcRDgvokQa6qsAZo37Eng1uu8Oq0X4NHygllaU2kN65ZBJA25ZAJYSeKv
	3jXlK3v7o4pl9u1N4gMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcZ6U-0000f7-8F; Thu, 27 Dec 2018 17:05:50 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcZ6Q-0000eX-Uo
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 17:05:48 +0000
Received: by mail-io1-xd44.google.com with SMTP id k7so14969066iob.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PxN3IceSAHTN/afci5ZupMRI+FLUTdEFATdBPqBbyCc=;
 b=egOkD9gEN5p+sArcJFiDGEk33G2YpATtE0uvWpTcKvIqUl4bYw0zgJ6WOn+HnMO8b3
 dx0DgsFObwqkR6b+v9MfHF0uupzTcJKetq/YqEMabu4AAXASB8TyN/qtogKEVT5X1mx9
 pqfbAlY4UKe45Rk6MN7A15KVZBQXrYl0aKo1SbfJsHumEOxudItX5+A3R1xPBn4Uvf7x
 aMCMV5+7s6XMw8ECxn9KVNl3dImbA3jxrfCY48SVKgH4MsJhl9h4WI/ehT8B3iezVs2N
 BMP/MCSWzf76gRKbCzvWRD6AumZmEW6WTORggX3PAB6HNQjcREhSgezNVuU4eMHtiPvD
 80OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PxN3IceSAHTN/afci5ZupMRI+FLUTdEFATdBPqBbyCc=;
 b=RyR70SGyWhiXimjuuJ+tN/FY3k+hqR0aUwSatD+rFwNz8mCerDm6+3d/9NlzBAG1Jv
 4AcUdaYYKuYVw0rRarhtaiI6F41gcp7NmxhqaWH1P7YGDk1UX07ZqMKcrTkKzqUxCTN7
 smRfU3sjO4hdFo4ZBNfK3al17ADrKH2tDHekfIXziOeAN6T65bYAug6Hk/0+zoIpu/0+
 8xFDA+5t5EkGikH3H60ITDL0Mg1ZMHzCTQLsZ7L2mfwHGT0OZ4mcjXJtBw+10WFpDxPX
 1zVawv8wwftWVwEuUbt3q4pIJxar7/Y1LoiAJxMyUjJDp/YtK4CMnwPwYeMcK/NCSyuM
 8Mcw==
X-Gm-Message-State: AJcUukdQWl2nhDvdYFDxlhP4CzDHS9E9V1PH7CPAFrOq8dLJ9Vz4yaUx
 Bhd8GHDI4dKYw37pnoequ0gEyKg/TinFB1tONC0=
X-Google-Smtp-Source: ALg8bN530QwDZk6ZM7S2W3Vk0PxLTxOmlW+nnHY50MXRYVqZelhgZv5zsBUnt9znjyI+SoaBkLEbwIUYwLvnzPzhCyE=
X-Received: by 2002:a5d:9a03:: with SMTP id s3mr17124347iol.69.1545930335808; 
 Thu, 27 Dec 2018 09:05:35 -0800 (PST)
MIME-Version: 1.0
References: <20181213230411.5009-1-tony@atomide.com>
 <CAHCN7xJmde1RJOMMqexR0uNiVEYjztTV4qXvkcjqb+w7R1vmpA@mail.gmail.com>
 <20181223163040.GO6707@atomide.com>
 <CAHCN7xJKyjXb6br-f+_q_dQxkqWHFxFfA+X_yYG4eh8w7RW8SQ@mail.gmail.com>
 <20181227165812.GS6707@atomide.com>
In-Reply-To: <20181227165812.GS6707@atomide.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 27 Dec 2018 11:05:23 -0600
Message-ID: <CAHCN7xKyvXPMSaRQ_qP4u_bX7uh=52OUCtfO2XW974=rNnRcXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: Add wlcore wakeirq for omap3-evm
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_090547_022756_50E0863A 
X-CRM114-Status: GOOD (  20.35  )
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
Cc: devicetree <devicetree@vger.kernel.org>, linux-omap@vger.kernel.org,
 =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 27, 2018 at 10:58 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [181227 14:33]:
> > On Sun, Dec 23, 2018 at 10:30 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * Adam Ford <aford173@gmail.com> [181222 20:54]:
> > > > I noticed for your patch, I noticed you listed both the IRQ, gpio 149
> > > > as well as uart1_rts.  Looking at the device tree, I see that
> > > > uart1_rts is configured as gpio 149.
> > >
> > > The uart1_rts is just the pad name used in the TRM, so it should
> > > probably say uart1_rts.gpio_149 meaning pad uart1_rts is muxed to
> > > gpio_149.
> > >
> > > Would that clear the issue for you?
> >
> > That part I understand.  I poorly phrased my question.  What was
> > mostly confusing to me is why both irq and wakeup interrupts are
> > needed since it seems like
> >
> > <&gpio5 21 IRQ_TYPE_EDGE_RISING>,
> >
> > and
> > <&omap3_pmx_core 0x14e>;
> > point to the same pin.  Or did I mis-interpret the datasheet again?  :-)
>
> Ah OK. Yes the same pin can trigger interrupts at two different
> controllers. During runtime a proper GPIO is triggered, and then
> in deeper idle states only the padconf interrupt is triggered as
> the GPIO can be powered off. So the padconf interrupt is there
> to provide wake-up events if configured. This allows the device
> to enter off-mode during idle with things like ping and ssh
> working with some extra latency :)
>
> The padconf interrupt can also be something other than a GPIO pin,
> such as UART RX pin, and the padconf device is separate from the
> GPIO device. So they're treated as two separate interrupt
> controllers. They can be both active the same time although that
> is undesired for the extra overhead.
>
> Eventually we should be able to make the GPIO interrupts work
> in a transparent way with the padconf interrupts.

Thanks for the clarifcation.  Is this additional IRQ and wakeup stuff
something I should add to the Torpedo and SOM-LV boards?  I think
right now, I'm just triggering on the GPIO rising edge.

adam
>
> Regards,
>
> Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

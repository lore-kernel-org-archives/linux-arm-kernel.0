Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:33:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58468208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nX9DfOH8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKqZQZEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58468208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W4ttjh7X9Yku7SIiq+Pa/3KxKMoksRXCeRb1nId7hL8=; b=nX9DfOH8OpsE3D
	ro6XmmYgrskiOOc6i3tFtu9SSZCqiqMHJmm0Ds8+zEfdafPJBLCr5gyDdnB7qOaCrnZZHiOn5R9Y1
	633rNuDVJwf2CwgO86FIM/sobI4ZAt00CN539D40qjpBodZbePlU4qPKZW5s8CR+xxvmVk+8jlXbN
	93J/Sbs5rSCIVTQ+qzoqFTFf66U09S85B6jmU3bnk66QdwQB/XL638djyLzcwEzgOhXlHJV7YJ85o
	eMAssqGguce7Rf0UZt8zt6cnFP0nHUmb49ofr3rplzDXVTkp/IX8yM6WmhV8wxIQq9KOoRxeBFdHb
	kUgPVqBr7+EOjQyPMLcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcWjV-0000vT-AK; Thu, 27 Dec 2018 14:33:57 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcWjR-0000uy-U4
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 14:33:55 +0000
Received: by mail-io1-xd44.google.com with SMTP id t24so14670690ioi.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 06:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WMtXR8oiv4vxpJ3vpb7KtqugYQei2IG24hwxAevcVYM=;
 b=aKqZQZEIfGTlEbLgHpdvGyIFxNkB+ESjBurX17lzOpGIhL9kcPGnvXeX2TLcPQA+xO
 XOCSunZWWLEru74rbuEzRX6QL06/NaiTqYkqlqfJ7NDfV8MoTP92zOVqnq7xkizwaM4/
 H5aOLN6AkzyT4vgavJQnmX0+oVVod/LDqkEEnop1hYYbiYOv8wY1odMSa8UeD0r/+C2J
 zx8XShm9zJiE7QNi8b3NAgCwGIklVRPJZ+X5GDjMCiuCHtlL15ZmvoatDLQm26xcyvSy
 oHRpiGS+XaPFGITQboMJ12/R4/3ZA8G5NIJI0hoG3PSkPseHbB4iOVGwsWkfNVDbCg9s
 qCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WMtXR8oiv4vxpJ3vpb7KtqugYQei2IG24hwxAevcVYM=;
 b=AnjcrFrajvbANw9WC95zUC7Nh1KImuaFmUFPvULxTsFu5y+m1qN45h9V76Quq7qRc6
 STOVJOu+J0bufhi9ki+8yIt/vnNDtst6km1HLrsS04+WdxAq71F/aUL714KfzfRzcjTG
 nhstF4RPsc+7peJt7e4IeeuDSBn2Kxj3CMWOWyKroBu3CRqTQION2wg/+Bwmza8GeD3T
 e0rrpI7R9UrkCmB0qsTIkYZNY3KKwFr3u8HEv+5UFb7y+LAE4wSBe0L9dRMFcrL74Nfy
 b8I8joP2Sno8fzZZFAYfupY8LAj/q0JXPrjKirOEkp0Bn3hKHAt3LiFU4zY2cQjOIb2/
 L+cw==
X-Gm-Message-State: AJcUukclU/8bqEdFlkd2uKdVzb+31bgUDuPaZvNfXYdZt9bGokWhoo+I
 GiuZMyWfkogoDL07PgDkfyaGhBpK0T3B3vBBwr4=
X-Google-Smtp-Source: ALg8bN4LK8rnHxQDJcWdvAktE12TcPAGGqlkX/gn3ccLMPCbo0JdHTpV4XGhtW/+cSWClEYB28LPV15EMU2AkFiBj50=
X-Received: by 2002:a5d:9a03:: with SMTP id s3mr16694897iol.69.1545921221159; 
 Thu, 27 Dec 2018 06:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20181213230411.5009-1-tony@atomide.com>
 <CAHCN7xJmde1RJOMMqexR0uNiVEYjztTV4qXvkcjqb+w7R1vmpA@mail.gmail.com>
 <20181223163040.GO6707@atomide.com>
In-Reply-To: <20181223163040.GO6707@atomide.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 27 Dec 2018 08:33:30 -0600
Message-ID: <CAHCN7xJKyjXb6br-f+_q_dQxkqWHFxFfA+X_yYG4eh8w7RW8SQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: Add wlcore wakeirq for omap3-evm
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_063353_992051_D36573C3 
X-CRM114-Status: GOOD (  16.24  )
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

On Sun, Dec 23, 2018 at 10:30 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [181222 20:54]:
> > I noticed for your patch, I noticed you listed both the IRQ, gpio 149
> > as well as uart1_rts.  Looking at the device tree, I see that
> > uart1_rts is configured as gpio 149.
>
> The uart1_rts is just the pad name used in the TRM, so it should
> probably say uart1_rts.gpio_149 meaning pad uart1_rts is muxed to
> gpio_149.
>
> Would that clear the issue for you?

That part I understand.  I poorly phrased my question.  What was
mostly confusing to me is why both irq and wakeup interrupts are
needed since it seems like

<&gpio5 21 IRQ_TYPE_EDGE_RISING>,

and
<&omap3_pmx_core 0x14e>;
point to the same pin.  Or did I mis-interpret the datasheet again?  :-)


adam
>
> > I did a quick scan of other
> > boards, I haven't noticed other boards listing the same gpio twice,
> > once under IRQ and once under the pmx_core wakeup.  Is that something
> > we should do on other boards, or is that something unique to the
> > omap3-evm?
>
> No just trying to come up with some some less confusing comments,
> but obviously that did not work so far :)
>
> Regards,
>
> Tony

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

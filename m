Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB86EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:39:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89EF92087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qOFQ9u1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EF92087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DEJirYR17jjo9rq8lBjCV5Pyffta51aS7pkwbw5Uf3g=; b=qOFQ9u1k9BWhrm
	5eqRH/MpUqzSYZ4lGNx3aJbUloUUQEE+PE7AjbSobR0b/GojVAfhkIwaz58dmw4TnOdWDqhpyLazd
	G3aaV+/H98ePQ0140Tb293In3prBEUXb1Xo0wrhwwg3OHGBYIJ8+upyHqw/ji8GlsoxxXpTCX6khR
	4VaRV/9myuRE85XMnJiPQlFnNS+MfSSBSMv4nNDHmf8rjycPtWJtiYIsSeNDL/4ZfM6aXIcK9UIxM
	OSSkT3yVEPW8mlppsg3IngIyrW6DQAjybT0l9s2fjYjsiTbI20cJkn/CfJSfzx4jHU/YQCb4GsNoX
	NddS3nBoFDc1ldG/d/qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyGTQ-0001SC-KB; Mon, 25 Feb 2019 13:39:12 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyGTM-0001Rg-MI
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:39:10 +0000
Received: by mail-qt1-f196.google.com with SMTP id z25so10374831qti.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 05:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qQa+wgPMesiTlKTvsul58fMBX/JX9ZGKjrHuNhwWwaE=;
 b=dZ4iGkyhixbuzFh8YNHfPd43BwY/G0mp1qdZr5b2A12ozJzOgZNKBWWEo2BZB/7fEh
 Ah7Ga3dB1bQJBUXitp5gdiqvc2otoXmpOTNv9cwYqGs+4X2Tt6yEhDmf71kEPj4IxtuB
 acQMsHiQcQxLuKilgOsRQc+oS3fqQPjtu0Ga6LupDlTm6zt6ti1R0ZDcyCTU/+0sCthl
 vzDwOE1tnEUyY05uj84ZAinra+gALa9g1Fv94jXHlRH5UWd4U+cFEO7KHYcWeJusXRkS
 tmUtBzqVQBuTM5+ZWBscL6qzYKtgvBJMT8rin7SUXnEdxOE1yBxjLxFjqWsyWMbHwY5x
 FMqQ==
X-Gm-Message-State: AHQUAubtAguw9MMETm3tDUEdghjORKXCYMJnB2i5dY9tGLwVvB0CoymS
 CZT+P3Tsca+7m5HC7D0ZMjzKR8Q/Fs6xP1caWKE=
X-Google-Smtp-Source: AHgI3Ia0H18NOVTeeQv3O4dtvQH0bnDl573OwqEPOJrarR2yrs4QFNav2eGJajGvCjfkGip/4HEkbKLCBWB4/EEEHDM=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr13488848qtn.212.1551101947115; 
 Mon, 25 Feb 2019 05:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20190225123615.49bce7cd@canb.auug.org.au>
 <CAK8P3a3moJ12SDM3Ow-Hw3qBeTv9siswK+9pPiEA4JJ+7k4xvg@mail.gmail.com>
 <s5hr2bw2k7m.wl-tiwai@suse.de>
 <e2aaed45-0fb1-c9c8-76d4-3b97b36cada6@nvidia.com>
In-Reply-To: <e2aaed45-0fb1-c9c8-76d4-3b97b36cada6@nvidia.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Feb 2019 14:38:50 +0100
Message-ID: <CAK8P3a2Q7OAAYCU01TNpHR2SM7N=YunyqZEihSESnQwxzL5=Vg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the sound tree with the arm-soc tree
To: Sameer Pujar <spujar@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_053908_734009_B3631174 
X-CRM114-Status: GOOD (  21.09  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, DTML <devicetree@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Thierry Reding <treding@nvidia.com>,
 ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 25, 2019 at 12:24 PM Sameer Pujar <spujar@nvidia.com> wrote:
> On 2/25/2019 4:44 PM, Takashi Iwai wrote:
> > On Mon, 25 Feb 2019 10:19:15 +0100, Arnd Bergmann wrote:
> >> On Mon, Feb 25, 2019 at 2:36 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >> I see this property being used in commit c0bde003a013 ("ALSA:
> >> hda/tegra: sound card name from device tree"), which removes
> >> a questionable use of the root compatible property, replacing
> >> it with the new 'nvidia,model' property. We don't do this for any
> >> other subsystem, so why does the sound subsystem export
> >> information about the board as a string here?
> > The sound subsystem exports merely some understandable name string
> > for the given sound card object, and that was composed from the
> > compatible string in the past, which turned out to be useless on some
> > configs.
> >
> > But this kind of addition is an extremely bad manner, I'm fine to
> > revert these (at best with a better alternative).  This isn't about
> > any functionality but rather some readable information that isn't a
> > part of API.

It is not extremely bad, but it is at the minimum surprising.

> The motivation for adding custom sound card name is following,
> 1. When for boards, multiple HDMI/DP ports are exposed, it is sometimes
>     necessary to know the default port or any customization for that matter.
>     Audio userspace can distinguish based on the sound card names.
> 2. Multiple sound cards can coexist for a platform, the indication of
> particular
>     audio path is useful.
> 3. It can help to customize audio paths.
>     Generally people use "*,model" property in DT to name the sound complex.
>     Ex: "samsung,model" [sound/soc/samsung/snow.c]
>         "rockchip,model" [sound/soc/rockchip/rockchip_rt5645.c]

I see, I had not noticed those before. They do seem a little unusual,
and inconsistent, as the samsung sames are always names the board
there, but rockchip doesn't: one board names it just "I2C", the other
one uses "VEYRON-I2S", and the example in the documentation lists
"ROCKCHIP-I2S" and "Analog audio output", each of them following
different naming systems.

In Documentation/devicetree/bindings/sound/qcom,apq8096.txt, a
"qcom,model" property is listeds as "Obsolete", and replaced by
a "model" property. This is in turn also used on amlogic, freescale,
and some samsung platforms.

My impression here is that the idea of passing a model name
through DT is well established, but for new stuff, we probably
want to standardize on plain "model" rather than "$vendor,model".

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

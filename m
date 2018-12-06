Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B82FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:19:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433F420700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IqL1qhIk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FmVdNl4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433F420700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kmplEyHplGp2ldAoowB7NBNQhiGLYHZD1bEiG2NgIGk=; b=IqL1qhIkxnGUe1
	vHOFf5xInVOCuCRLjr/Rfgv/QPXRFcac2Ra5+EduQQIUsZK0tZzFzgtpXVH85rlGLtYqyqE0GPamD
	KZ4wiow345CTZ7fs/2qo8oPQkMkteeVHPZ0VtgKlywWqH4Clu+oQHH1nKvqmJxPw8aCpMhuEmEOoM
	ytLAHOZZ7bZMLZnbNYTpjoB+MCdqKVwK/nZiiq5L2CXmtLl0/V+NFrU8US5M21sSY/ETs1t1T9gbH
	IYlDQYz+JeU1bQj/ZcRyjj65vjYmq4eUivqfRpVDGcMRbPNTWJRoqpgIfRG0RrqUQzonKQjcT5BYb
	5qzd4Hp2oNhNDX+f4o8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUwN0-0005GV-6F; Thu, 06 Dec 2018 16:19:22 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUwMd-0004uy-3M
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 16:19:04 +0000
Received: by mail-it1-x144.google.com with SMTP id p197so2332436itp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wwFF5RodQzcPhlF5Fs1Z1R7kCHD7s0M2IolrVWTUV8I=;
 b=FmVdNl4oqZcQo3G02EC703bO1c5yl219Ex2MeU9DfRkMpnCThTn0KlXCubxyNCcKlD
 IJZ6g0yCpXFp1hT54VUxi9LRM2X4/BytQp2NtNAq7JMgyUVGsKOiyMzre1Q7M4d9WYBI
 1d6UN3TP6XUxRioNV5ikcMIIcihRaBWanx7cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wwFF5RodQzcPhlF5Fs1Z1R7kCHD7s0M2IolrVWTUV8I=;
 b=bLDah8QHH39W2S6wPAc4U3DfseK/qQBm/NXllJfCw4X5sTbxdRzyAR9aWCXssvgQyY
 oCbq2oCpyUmQAY5K9SBCFXgSZv1kFDKZji6sAJmWKa4JrFExJJwF2kVsE3omBnuZKDlo
 +EBMLTUblPIySoUt2YFuEh9PkmiInXn5xBQaDxmHtAoWl0PdMfIWiCEVpVkeEgHUZpEi
 z7H0oCR1MkbO6qSQpLDVqkWr8bcboUCNr/yZ7iCLIrjgSs2zKoWaS1jAOmNld4OUiu2A
 +bBHCeRYj7+JIo8oCAMqGj+yKf+p2Svyn25GMG5NdjM6enljxLcyGGX5JIClb8GVzRDG
 o8/Q==
X-Gm-Message-State: AA+aEWavJzMbevUwzjt7/xW+B9x2ZR//Nv+n/IpjO11KJTjrMf8tYQoQ
 GfWSYawg/W0wHdscwfU0jliU1EynIjpcGql6PIOG3Q==
X-Google-Smtp-Source: AFSGD/Vktru4QIRmr0qQj22J+Oc+HyD5QK50oyvY4sFLYB8EKWkVpIU70ShDOaifv/dnLCkA5Ggmjhr3DjuMw0sAk2Q=
X-Received: by 2002:a24:5411:: with SMTP id t17mr18520001ita.32.1544113127612; 
 Thu, 06 Dec 2018 08:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-3-jagan@amarulasolutions.com>
 <20181206153532.6c756gccmpuj4wdw@flea>
In-Reply-To: <20181206153532.6c756gccmpuj4wdw@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 6 Dec 2018 21:48:34 +0530
Message-ID: <CAMty3ZB0rvZ8kwcOmXT2oLUqDLc5w8VBshMQirXfUAVG=042kw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: allwinner: a64: Add pinmux setting for
 CSI MCLK on PE1
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_081859_136277_4DE2A915 
X-CRM114-Status: GOOD (  19.12  )
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
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 9:05 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Dec 06, 2018 at 06:53:06PM +0530, Jagan Teki wrote:
> > Some camera modules have the SoC feeding a master clock to the sensor
> > instead of having a standalone crystal. This clock signal is generated
> > from the clock control unit and output from the CSI MCLK function of
> > pin PE1.
> >
> > Add a pinmux setting for it for camera sensors to reference.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - new patch
> >
> >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > index d7ab0006ebce..902b5238f1dd 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > @@ -538,6 +538,11 @@
> >                               function = "csi0";
> >                       };
> >
> > +                     csi_mclk_pin: csi-mclk {
> > +                             pins = "PE1";
> > +                             function = "csi0";
> > +                     };
> > +
>
> We're not merging nodes that have no users.

Yes, v1 [1] has a consumer for this. Since it's under discussion about
PE group supply, opendrain I hold it. will send once the discussion
done, I even tested on top-of your ov5640 changes.

[1] https://patchwork.kernel.org/patch/10709077/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

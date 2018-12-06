Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C28BC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5A220989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LaG/oBOM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtw80NaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5A220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9z1rXQrSLyyOmXEpDbs4WlMx5daK8JQw1MHemUHLzSg=; b=LaG/oBOMAOc65H
	BZmrl/2NnWRLe8Pu2SCLAnY9Qnx6RtZ2nh+RjMvOYSysBSllhX/ZF4QIsHxRnrlc9eFY72nRGZTzf
	1TUy+9V1pIdRCqD2/gOBHtjOQPK4qZodki2KclXkjImHJ2asMOGyQxK7QXxJLXQj6FX2B5fEkn7rT
	ZK/axE1Y6JOBXB7sYAZNH+6+6LUs5nRZET0GrZk4+/0lWg/sMkZlBzZMNhw5UzZfC3FFysbaP5GoQ
	l+pLUxSeCGGV5HZ/aeZA6TjAOdbNuHrSIdfIQen53X/bIlrqMkd7FwyE/UaZhSUVT3JAippOCahZX
	AGNeN1REZkJ+/iRDc1qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1Bf-0003Fi-Rl; Thu, 06 Dec 2018 21:27:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1Bb-0003Er-JW; Thu, 06 Dec 2018 21:27:57 +0000
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 29346214DB;
 Thu,  6 Dec 2018 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544131665;
 bh=YUKdoUTdVOsh4ePDuGZ5IkFg5OFwW2rDLrMYKWOZJig=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Mtw80NaMfMVffOW74aj/EI26GoQDEzan0jzuEAo+MAJ6brIQBDlkWQKmd9IWDFEXk
 Tn9/bMPwQS6xTmEYNE5bM/Mg9ql9Q8lAcUMZMtdl1Qw6kzdzwTf4DXTlz+llH2FShD
 9neyDhJX+Xl3B1H4Kz94GaksN4CqAIAXVOkIJlR4=
Received: by mail-qt1-f180.google.com with SMTP id k12so2248161qtf.7;
 Thu, 06 Dec 2018 13:27:45 -0800 (PST)
X-Gm-Message-State: AA+aEWYIzk43aU9a29G9ruQSrCO32K54BbTlwXUvbOYjthhnEz1p/gC1
 dZBnukpsh5UnkQimd68OYKGaqpEWVVHF1bEV8A==
X-Google-Smtp-Source: AFSGD/Xq7Y31Py8rddAX76hKx/Dgp6RhHrT1700dFVf7MBtjRNWpyx/brxsFhnAarR60gHdRV/sSlbWPfoSSMDfS4m0=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr29894028qvl.77.1544131664335; 
 Thu, 06 Dec 2018 13:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-15-robh@kernel.org>
 <dfb921ca-63c5-a4c2-f3e2-c2eebdf688f6@baylibre.com>
 <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+e2m5VaibpvuTYURZ+E=MCSUGH8cokdWYWEjn_jy9iwA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Dec 2018 15:27:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLCtY=jpaA=Pxq6ncFX2rSg8Kjc3iZXKM3HvaqCi16N6Q@mail.gmail.com>
Message-ID: <CAL_JsqLCtY=jpaA=Pxq6ncFX2rSg8Kjc3iZXKM3HvaqCi16N6Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/34] dt-bindings: arm: Convert Amlogic board/soc
 bindings to json-schema
To: Neil Armstrong <narmstrong@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_132755_676742_4DE27BC0 
X-CRM114-Status: GOOD (  22.73  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>, Kevin Hilman <khilman@baylibre.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 8:44 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 4, 2018 at 2:39 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > Hi Rob,
> >
> > You forgot linux-amlogic in CC...
> >
> > On 03/12/2018 22:32, Rob Herring wrote:
> > > Convert Amlogic SoC bindings to DT schema format using json-schema.
> > >
> > > Cc: Carlo Caione <carlo@caione.org>
> > > Cc: Kevin Hilman <khilman@baylibre.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
>
> [...]
>
> > > +      - items:
> > > +          - enum:
> > > +              - amlogic,s400
> > > +          - const: amlogic,a113d
> > > +          - const: amlogic,meson-axg
> > > +      - items:
> > > +          - enum:
> > > +              - amlogic,u200
> > > +          - const: amlogic,g12a
> >
> > but all this feels wrong for me.
> >
> > First of all, this yaml description is not human friendly and not intuitive at all,
> > and secondly with this conversion we loose all the comments about the SoC family relationship
> > with the compatible strings !
> >
> > I really understand the point to have automated verification, but really it's a pain to read
> > (I can't imagine newcomers... the actual DT bindings are already hard to read...) and
> > I feel it will be a real pain to write !
>
> What do you suggest that would be easier? Is it the YAML itself or the
> json-schema vocabulary? For the former, we could use {} and [] to make
> things more json style. But I imagine it is the latter.
>
> There is some learning curve for json-schema and is certainly a
> concern I have, but there would be a learning curve for anything. Our
> choices are use some existing schema language or invent one. All the
> previous efforts (there's been about 5 since 2013) have been inventing
> one, and they've not gone far. There will be far few resources
> available to train people with if we do something custom.
>
> > Can't we mix an "humam text" with a "yaml" part on a same document ? we are in 2018 (nearly 2019),
> > and it should be easy to extract a yaml description from a text document without pain and
> > keep all the human description, no ?
>
> Yes. Please go look at the annotated example in patch 2.

How's this?:

  compatible:
    oneOf:
      - description: Boards with the Amlogic Meson6 SoC
        items:
          - enum:
              - geniatech,atv1200
          - const: amlogic,meson6

      - description: Boards with the Amlogic Meson8 SoC
        items:
          - enum:
              - minix,neo-x8
          - const: amlogic,meson8

      - description: Boards with the Amlogic Meson8m2 SoC
        items:
          - enum:
              - tronsmart,mxiii-plus
          - const: amlogic,meson8m2

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

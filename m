Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5F7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:09:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE3F206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nHc+0vdS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0hXyPnI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE3F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aOcaGllAHbSOJW4hoP4o3WGWwGduhd1Zvmn0YW7TrDE=; b=nHc+0vdSpimj/8
	JJTPlQ3chQqIYMjL6kF81KqGmPVK+CxzFoOrnsKzEZijz27DGODrIA6ywq91d45+JizgpZET2yTe6
	y2Uay+CpCO1oy2mVYolKbDwJZVEVIAWWl06NBccW90AUxehYOnzlntKqdLVMSS8JGXxUgU4qw/s/0
	UxbX6m0XgKxYjf0nXkCWmDDSvoGpFlj6GKD5beOcrLn0HEYovRbDvjUoeJvNDhxWWZoZR74tjW23B
	c2Wm1GVPUjXaheygjAKqiNl7RBQKw3utqhotmbFVJ8mAn2JhHYrWQLIljYig3CtomGayutZML5jI6
	eHJeixP0vrC/VoMwTb3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCKD-0006fd-Nn; Tue, 04 Dec 2018 15:09:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCK8-0006ek-4C
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:09:21 +0000
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68AA520851
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543936149;
 bh=+0MI/8EOCqbI1qFoWjATuKQrFBYgzbVNInZxkwwjqEM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0hXyPnI9maJyqcmzB6tMN4pIULVnhwcNY4dEKGfbJxU1GFyu/FoWh7TzessGN03cZ
 s/rGuYd11D1t1GeUI0SOQwFVIOJlnCSH2FrdqhPNho5g/tLINU/kkTfPDLdepWZRDC
 GmnQOyJlSCRF9CMIS6hXfsXK//Ld8wZn6+P3moGM=
Received: by mail-qk1-f178.google.com with SMTP id 189so9770302qkj.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 07:09:09 -0800 (PST)
X-Gm-Message-State: AA+aEWbvUQMeP7U3Qa3vPOxfXZlVjRuGyo2Gw6BPLlAdX/jSLq9Lj04b
 KzW4g4XmMNQu1qZ6gEPc4uENPBrDJarqSJJStA==
X-Google-Smtp-Source: AFSGD/VUggFDQVcQ6qA6a8K2W5gIb5rqDIXHwIpEuSzH4QIaox5BhRGzLSfFb7Q1X7Odc6q1CLQrY+AToiydWVRNR2k=
X-Received: by 2002:a37:5686:: with SMTP id k128mr17892902qkb.29.1543936148619; 
 Tue, 04 Dec 2018 07:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-27-robh@kernel.org>
 <20181204144822.uqonsto45u7ysdu5@verge.net.au>
 <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
In-Reply-To: <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 09:08:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJX9eb58piavQayXM5j5GXxsGxmy93m5oRKtghMFvkhuA@mail.gmail.com>
Message-ID: <CAL_JsqJX9eb58piavQayXM5j5GXxsGxmy93m5oRKtghMFvkhuA@mail.gmail.com>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Simon Horman <horms@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_070920_202748_17B11538 
X-CRM114-Status: GOOD (  19.42  )
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
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:MEDIA DRIVERS FOR RENESAS - FCP"
 <linux-renesas-soc@vger.kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 8:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Simon,
>
> On Tue, Dec 4, 2018 at 3:48 PM Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> > > Convert Renesas SoC bindings to DT schema format using json-schema.
> > >
> > > Cc: Simon Horman <horms@verge.net.au>
> > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: linux-renesas-soc@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
> > >  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
> > >  2 files changed, 218 insertions(+), 151 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
> >
> > Hi Rob,
> >
> > what is this based on? I get a conflict when applying the .txt change
> > and if I knew the base for this patch it would be rather easy to work
> > out what has changed.

4.20-rc2

> >
> > Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?

Yes. Though it was pointed out that get_maintainers.pl can pull emails
out of this file. We'd need to get that to work by default though.

> Probably even s/shmobile.yaml/renesas.yaml/, while at it?

Sure, if that's what you all want.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

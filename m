Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E9AC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:41:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB7F20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RvRPV5Ny";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOQ4ycYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB7F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U4TBOMqS/o3aH1qTmN9kAauxj9J9O2XkdxO4kVsslWA=; b=RvRPV5NyLK8LV1
	f6B6UKx6xssiX666uyBODUWXTG+tkrW9UydXF1QBtt519iXPQZ2hPeWiHMOURI1+5K7xVgoD48Ec8
	diIJ5X00lU2OBoeXYQPBKFR28sMCiu49kpiQeFS4dS9+ECRcArEEqYMOJ/IhrIxFMZW6wGEdYKtup
	J/q744GB6vGOVbzIvkC2rqXJF3w8we02TLe61BFqL6x8YfDaBkGHbrODKUKkPT03pGum2R1d7sNZR
	E0XcpfsbrqdFiTeCeTtum+QP65aunz9Af98b7Rz0maHOxEdNs5HR31SGEfNUPSCUgqUQdnm91swxn
	42eToI3K6em3VeaeRF5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwIo-0007oi-NC; Tue, 22 Jan 2019 13:41:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwIl-0007oN-4J
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:41:16 +0000
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AD25220870
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548164474;
 bh=prFZcRP2SYee4GKipvHLC7KZ4SliP42MtaVyeVdlh2A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=BOQ4ycYlTLpc5uezYKUMOrfAXHswWDBGXLvrEItfClni52ctYZ3ku+tGxWE3R5D/R
 2HQw3j3kKgTMt7rAMeCTJqbTydKGnWHtkywb7Vc9t4ii/UUVcGRUuQrku/Y9g8EifT
 O+MduOUFFlrmHjm7zJyBXowCguQEWv1pzoRIIUcQ=
Received: by mail-qt1-f177.google.com with SMTP id i7so27510493qtj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 05:41:14 -0800 (PST)
X-Gm-Message-State: AJcUukfoqjlYu+Ml8fSm9G10puRl+eOT1AtbYRXbL0deErltTw4iUUxJ
 8arXoNJujMUjPwjD1uBZeEe9SEopUDxneycCCA==
X-Google-Smtp-Source: ALg8bN695c+L8pmAwWxgWUmilJnYICCOItILluOzhBlnIdnXOahwthK245Edsf20/kfKy9PIhPJMGlZImkUi73OcWwQ=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr31349294qts.144.1548164473958; 
 Tue, 22 Jan 2019 05:41:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <0005c2ef28b985c663e0cd058bbc6d3856e05ec2.1547629763.git.nicolas.ferre@microchip.com>
 <20190122011014.GA25211@bogus>
 <be8ba0bf-993e-d38c-61e8-af422ff3c636@microchip.com>
In-Reply-To: <be8ba0bf-993e-d38c-61e8-af422ff3c636@microchip.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Jan 2019 07:41:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+31C2KXNy_GeVU9g7mZ_aSw3yqdjU-V5mV2Xdc200TuA@mail.gmail.com>
Message-ID: <CAL_Jsq+31C2KXNy_GeVU9g7mZ_aSw3yqdjU-V5mV2Xdc200TuA@mail.gmail.com>
Subject: Re: [PATCH 4/8] net/macb: bindings doc/trivial: fix documentation for
 sama5d3 10/100 interface
To: Nicolas Ferre <Nicolas.Ferre@microchip.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_054115_208734_C713F58C 
X-CRM114-Status: GOOD (  19.30  )
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
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>,
 Sebastian Reichel <sre@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ludovic Desroches <Ludovic.Desroches@microchip.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Miller <davem@davemloft.net>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 22, 2019 at 3:09 AM <Nicolas.Ferre@microchip.com> wrote:
>
> Hi Rob,
>
> On 22/01/2019 at 02:10, Rob Herring wrote:
> > On Wed, Jan 16, 2019 at 10:57:40AM +0100, Nicolas Ferre wrote:
> >> This removes a line left while adding the correct compatibility string for
> >> sama5d3 10/100 interface. Now use the "atmel,sama5d3-macb" string.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >> ---
> >>   Documentation/devicetree/bindings/net/macb.txt | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
> >> index 3e17ac1d5d58..f5c414b10e27 100644
> >> --- a/Documentation/devicetree/bindings/net/macb.txt
> >> +++ b/Documentation/devicetree/bindings/net/macb.txt
> >> @@ -3,8 +3,7 @@
> >>   Required properties:
> >>   - compatible: Should be "cdns,[<chip>-]{macb|gem}"
> >>     Use "cdns,at91rm9200-emac" Atmel at91rm9200 SoC.
> >> -  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs or the 10/100Mbit IP
> >> -  available on sama5d3 SoCs.
> >> +  Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs.
> >
> > Where is "atmel,sama5d3-macb"?
>
> It's actually a couple of line below: line 13 of the resulting macb.txt
> file. It was already in the file when I removed the leftovers.
>
> Do you advice to try to better sort entries in this file? Is there a
> common pattern?

Okay, it's fine.

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1456BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:40:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA12C20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vDNrQURK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPH9i+oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA12C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ysYvJy4ZqRN7symu+P5TWCrzWt7GCzAJvdLISRv89Uo=; b=vDNrQURKHn+VlH
	5A4qr3RwdSRMXvB77BFANnqYaFth3WuzVOSGIgYEGipYDHW763L6/tm2lngvvDkFhMbcrgWQcQeSb
	JTYYwcWlU0ZtA8y226IF9er/fJVa79DynX4shwGGK6/OEkzYZOcP4oh5Ia28xy8zhxNVLclvn6pHd
	xnb32f5MCZVY0v0BDUbGGc5lINRZOKjI/LcaN7tthXXcVBFWDxpySj90Z9zByMORMT8doHr461Y+9
	UY29iG5dtiE/AyPmH5cXWo99lwHoZotz0cLIyVR0HNWji5BcNyJItlAuzWzOAXKL3TeBttJ2eKjNd
	f6RI5GvPmhO4XhrCwh9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwIN-0007Yo-1Q; Tue, 22 Jan 2019 13:40:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwIC-0007XF-KJ
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:40:48 +0000
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 27DFE217D6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548164440;
 bh=esbp9yipemWFMphPhojg5duibYbaUh0JWxIadTVP0vY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NPH9i+oUre4ZzBzURZisLcgijhVu68l0fyNbD1HBoOYXzIBIM2F8oi+ISdjS3rZcO
 6kNGyXcHK7ABrzq6aKJxQrBU3B1MsVYRyWgN+9WM02/EavoUThA3n7Uhcw0eC3uOCD
 7FIeWBPZzEaDam+sNvgHhyMenn0uW6ompduZsIb0=
Received: by mail-qt1-f179.google.com with SMTP id l11so27637178qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 05:40:40 -0800 (PST)
X-Gm-Message-State: AJcUukeyFVBr16VP3huFMTf5dBsqpzMaUdsyem7BWxoAfviu2VJfNR51
 dYue7oWt15Mojof5oqpRUKzweLpWKeUpWnY5rw==
X-Google-Smtp-Source: ALg8bN6VWQGgEZg/m39bTZGl5i9AbykXudTG4rdsmuBKNFX7AihzzCAkCGIaaG+cZcAC9tqIVmkzewOr+lMujKnbjoI=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr30157262qta.38.1548164439355; 
 Tue, 22 Jan 2019 05:40:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
 <ed46005be5beff6efc47d40cea304185efa2bcc0.1547629763.git.nicolas.ferre@microchip.com>
 <20190122010733.GA21139@bogus>
 <24a53365-1a8c-51cd-dcd4-db4a69d5256a@microchip.com>
In-Reply-To: <24a53365-1a8c-51cd-dcd4-db4a69d5256a@microchip.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Jan 2019 07:40:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLb3W=UG5VRFheGd2CfS+8rb5pJpHmHNq2bb1zrR3mEwA@mail.gmail.com>
Message-ID: <CAL_JsqLb3W=UG5VRFheGd2CfS+8rb5pJpHmHNq2bb1zrR3mEwA@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: arm: atmel: add new sam9x60 reset
 controller binding
To: Nicolas Ferre <Nicolas.Ferre@microchip.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_054040_824867_73E218DF 
X-CRM114-Status: GOOD (  18.84  )
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

On Tue, Jan 22, 2019 at 3:00 AM <Nicolas.Ferre@microchip.com> wrote:
>
> Hi Rob,
>
> On 22/01/2019 at 02:07, Rob Herring wrote:
> > On Wed, Jan 16, 2019 at 10:57:38AM +0100, Nicolas Ferre wrote:
> >> Update the Reset Controller's binding to add new SoC compatibility string.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >> ---
> >>   Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> >> index 36952cc39993..badce6ef3ab3 100644
> >> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> >> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> >> @@ -22,6 +22,7 @@ Its subnodes can be:
> >>   RSTC Reset Controller required properties:
> >>   - compatible: Should be "atmel,<chip>-rstc".
> >>     <chip> can be "at91sam9260", "at91sam9g45", "sama5d3" or "samx7"
> >> +  it also can be "microchip,sam9x60-rstc"
> >
> > How is this related to at91sam9260-rstc?
>
> at91sam9260 and sam9x60 are completely different products (they share
> the same core though...). I know the naming could be misleading but it
> is like it is...
>
> > The 'x' is a wildcard? We generally avoid wildcards.
>
> Here, the 'x' is definitively not a wildcard nor a kind of "family"
> name, it's included in the (upcoming) single product's name.
>
> I hope it clarifies.

Yes, thanks.

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

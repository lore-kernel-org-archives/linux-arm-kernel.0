Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B737C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:54:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD5021479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rE2DRT5N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MN8zygtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD5021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gRF9/itUtg0mgX9Mrpmw/k5RLTgaIlzjsuYnjr/jKNc=; b=rE2DRT5NiEdzxZ
	C2IWVxQ3xj5ffUyyMhwV1VeRWhbY9cCMM6RIGdNrw6R/hsfa14r/aj+7dAI31fHtDs3jORZsSQQV5
	LsFiASHWA60HD+Ian7CUZ5NyvOynpOyrG+q8U9fZfTf4h3jyPyQuCJ0UaOTmCa3wSQNyCfsYjsiZw
	7Y1rWilF/qvLzm60fslG8eoYyGbVBXPHgwUdAablFwIQMjyVk8/qa0A+vr3KalyHJzn6OQ3zwDPcI
	+1mkrvpq6cGXILI2TjFeUd/dXPy9702BeaUX+3gB6nklFjja9MwemIXxcTx1ASqKlRe/jeWp+kPRD
	mpdTbeMQRYp+9o+6v0zQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfBst-0006Ae-4L; Thu, 03 Jan 2019 22:54:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfBsp-00069k-VS
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 22:54:37 +0000
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2DB4B218A4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  3 Jan 2019 22:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546556073;
 bh=1gUjY9BZjRTRbmp7iSzVzBJKVBQ2LYhd6TRyCJz9QsM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MN8zygtMTxrwiOr+MO4URY22EuAYdLMFD04ps4mJ8KA6LyYr3A1wSfghicUJeIR1b
 wkyruPwXjEk6DqHU213zBsXzl2cIiALnK5h1k90BjoKi3Z/o2tHINe0HaP0aDKXqTR
 uSPVhXs2godGMqmBZSU5rBkot8Ay/Suq8ztusD+4=
Received: by mail-qk1-f178.google.com with SMTP id c21so4652976qkl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 14:54:33 -0800 (PST)
X-Gm-Message-State: AJcUuke10u/jCMYlVMVrRG+XB9AivqTgi+JDYjfuVpPFTT99qb2yPeWl
 KSCLngyXu57ny3hdiw9Jj6zPVqPexKYpWepcBw==
X-Google-Smtp-Source: ALg8bN5m6v9H/I4NQUee5O8gyS7jB37kPxSC9DSxW8g42WmQLn7hSJ0PKamZOTpOPWLhJGvESVaiqy+Fwl9TfWgSoN8=
X-Received: by 2002:a37:7682:: with SMTP id r124mr46179392qkc.79.1546556072321; 
 Thu, 03 Jan 2019 14:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20181221013409.14324-1-f.fainelli@gmail.com>
 <20181221013409.14324-2-f.fainelli@gmail.com>
 <20190103174117.GA6613@bogus> <2a54c2cf-5595-ade5-fb29-40e8b6d3133e@gmail.com>
 <20190103191915.GB6613@bogus> <bcfe4df0-8928-90e2-6460-1391320af9be@gmail.com>
In-Reply-To: <bcfe4df0-8928-90e2-6460-1391320af9be@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 3 Jan 2019 16:54:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKpFYnnAY-feAeJ-Va5yS7JH34FOzvBmTi4gMV=kjbCVQ@mail.gmail.com>
Message-ID: <CAL_JsqKpFYnnAY-feAeJ-Va5yS7JH34FOzvBmTi4gMV=kjbCVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
To: Florian Fainelli <f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_145436_044492_ADC780E9 
X-CRM114-Status: GOOD (  31.28  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 3, 2019 at 1:31 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/3/19 11:19 AM, Rob Herring wrote:
> > On Thu, Jan 03, 2019 at 10:53:25AM -0800, Florian Fainelli wrote:
> >> On 1/3/19 9:41 AM, Rob Herring wrote:
> >>> On Thu, Dec 20, 2018 at 05:34:08PM -0800, Florian Fainelli wrote:
> >>>> Add a binding document for the Broadcom STB reset controller, also known
> >>>> as SW_INIT-style reset controller.
> >>>>
> >>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >>>> ---
> >>>>  .../devicetree/bindings/reset/brcm,reset.txt  | 27 +++++++++++++++++++
> >>>>  1 file changed, 27 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/reset/brcm,reset.txt b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> >>>> new file mode 100644
> >>>> index 000000000000..6e5341b4f891
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> >>>> @@ -0,0 +1,27 @@
> >>>> +Broadcom STB SW_INIT-style reset controller
> >>>> +===========================================
> >>>> +
> >>>> +Broadcom STB SoCs have a SW_INIT-style reset controller with separate
> >>>> +SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
> >>>> +reset lines.
> >>>> +
> >>>> +Please also refer to reset.txt in this directory for common reset
> >>>> +controller binding usage.
> >>>> +
> >>>> +Required properties:
> >>>> +- compatible: should be brcm,brcmstb-reset
> >>>> +- reg: register base and length
> >>>> +- #reset-cells: must be set to 1
> >>>> +
> >>>> +Example:
> >>>> +
> >>>> +  reset: reset-controller@8404318 {
> >>>> +          compatible = "brcm,brcmstb-reset";
> >>>> +          reg = <0x8404318 0x30>;
> >>>
> >>> Based on this address, should this be a sub-node of something else? Or
> >>> not even a sub-node and just make the parent be a reset provider?
> >>
> >> The reset controller is part of a larger "sundry" node which has a
> >> collection of functionality, from pinmux/pinctrl, reset controller,
> >> spare bits, chicken bits, anything the designers forgot to put somewhere
> >> else and decided to put there.
> >>
> >> If there is one thing consistent though is that given a set of 32-bit
> >> register groups, they have a self contained functionality such that you
> >> can break up the larger "sundry" space into smaller sub-blocks which
> >> have one an only one functionality. Do you think this warrants a
> >> different representation in Device Tree?
> >
> > With pinctrl in the mix, you're going to need sub-nodes anyways. So just
> > define what this is a sub-node of.
>
> pinctrl is not necessarily something I want the kernel to control, since
> we have a high level scripting language without our bootloader that
> makes sure pinctrl is properly configured from early boot on all the way
> to the kernel, and preserved across suspend/resume states.
> pinctrl-single does work, and was occasionally used. Everything else is
> typically muxes that the kernel does not need to touch/see/be aware of.

That's good. I'd rather see more platforms do that rather than have
the kernel handle it. OTOH, bootloaders often use DT too, so maybe who
handles pin muxing is irrelevant.

> > Also, I'd prefer to have complete example for the "sundry" node and
> > child nodes than partial examples spread across the tree.
>
> I am afraid I can't provide that example because the sundry node is
> really changing from chip to chip, and there is a gazillion of things in
> there that the kernel typically does not even touch, like
> pinmuxing/pinctrl, various mux selections etc. I could provide the
> following example if that is what you are requesting?:
>
>
> sun-top-ctrl: simple-bus@8404000 {
>         compatible = "brcm,brcmstb-sun-top-ctrl", "simple-bus";
>         reg = <0x8404000 0x708>;
>
>         reset: reset-controller@318 {
>                 compatible = "brcm,brcmstb-reset";
>                 reg = <0x318 0x30>;
>                 #reset-cells = <1>;
>         };
> };
>
> Would that be what you expect to see?

The problem is with this alone, you should just move #reset-cells to
the parent and remove the child node. That's all you really need from
a DT perspective. But if this is really a separate block that's reused
from chip to chip, then a separate node is fine. Typically in these
situations, I just can't tell whether it's that or just the
convenience of creating nodes for every kernel driver.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

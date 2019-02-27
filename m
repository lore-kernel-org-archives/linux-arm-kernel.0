Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6006DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:04:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABF32087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 23:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qEmHIUSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABF32087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+wTIOf8nTisCpidz/z+SsglzRO+WOtz0EMqlG/ACdIA=; b=qEmHIUSVJblMOk
	2h3VJEU89TBx2M12jJOBhO5kc63cfftac2pXGy09fhtdmR9dsTDZbG/ccMkCRl8CZHUAFLHFNw1rQ
	f08H14kRDpA+VbrA6CK2YYZ8oVXtwmQqDi50B3WebYZdClljZlCj1VkXS4CFcf7G1XcX2QkPvHG5/
	OruXtPcafk+cIxd481FqvB5PgJFfhzeoe5mjgvehs80nUOit5d7+BFdZbIgBzBwlxQuYmD1KBTsmP
	6xT7ZzqrNXSaXXkolsvW5BkpHp4tfd7os2DM8rQFEe2P3w+GoZ8ejlGqPoLj6YzUvpHAQ325hh3ok
	0QwRHTY/eHQ1firS2jsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz8FM-0002JT-7f; Wed, 27 Feb 2019 23:04:16 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz8FI-0002Ib-Ri; Wed, 27 Feb 2019 23:04:14 +0000
Received: by mail-oi1-f195.google.com with SMTP id t206so14950523oib.3;
 Wed, 27 Feb 2019 15:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6xp3MERVpFmLr5DjrSIUraGCZG0QRk7Pfas0mtbAFRM=;
 b=hQWLwAnNnoSiTdgGBUQ5eVM6Kwy8zFXL3cw6Sy9U2yfILmbYM6l+wknHWiCPb5k3Bg
 ntFuUIoyTqsslwS373RK/oTjkCSgWiH3CRzr/LupPzMUCE9mB/FV90TCwhpNSi1MD+mo
 Qype6e/H3Mg78JU+CJ5yItsjzR6qg8OC7mPKTJwkBzObUTdttW3rzIblSAZUDt1qpsDo
 dxV+zIzAXB9eavJGyItkNdBqEGFatOxw2i+dEb+Mg3I+lXsYJBShySxHZQCgfHVddcBP
 tw2Zf65OT+/zRy+bzUt4ZBxzACBocnLSFXHMPCNRBDcGXzM/hiGLEx5XDBF6bUg0EzV/
 UZVQ==
X-Gm-Message-State: AHQUAubCKxGkJN3NZrui4EvpzPMCKNynqqY9swR9D6nclX2cAlTPWWXd
 3LPtaRZ3FSc5CwxokzTogXw0djKrKf2/SF2/0ms=
X-Google-Smtp-Source: AHgI3IbwmM7ugRwp/8WyXr6jFGbU0ALIKO3UtcMW0l6YmC9GAh8qWOOoRK/mLYUZpOCoffSk5zw46jUYZ6JEZOIwieE=
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr1149840oih.76.1551308649198; 
 Wed, 27 Feb 2019 15:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <20190226232822.GA174696@google.com>
 <d67512fe-42b4-513f-d27a-fed85c19e9c2@arm.com>
 <CAKv+Gu_fZK7dUqrrVPCejAZNWyUeMUX2ojQ=vQ3hiMkGF6e6tw@mail.gmail.com>
 <20190227205754.GF174696@google.com>
In-Reply-To: <20190227205754.GF174696@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Feb 2019 00:03:56 +0100
Message-ID: <CAJZ5v0gZFDdtbKQ6y52x+X8yoiPhP6BhGYZO=R_varx2nwuv5g@mail.gmail.com>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
To: Brian Norris <briannorris@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_150412_895495_DEA445AC 
X-CRM114-Status: GOOD (  25.82  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Amitkumar Karwar <amitkarwar@gmail.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 linux-rockchip@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Devicetree List <devicetree@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Kalle Valo <kvalo@codeaurora.org>, Ganapathi Bhat <gbhat@marvell.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Xinming Hu <huxinming820@gmail.com>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
 "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 27, 2019 at 9:58 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi Ard,
>
> On Wed, Feb 27, 2019 at 11:16:12AM +0100, Ard Biesheuvel wrote:
> > On Wed, 27 Feb 2019 at 11:02, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > > On 26/02/2019 23:28, Brian Norris wrote:
> > > > You're not the first person to notice this. All the motivations are not
> > > > necessarily painted clearly in their cover letter, but here are some
> > > > previous attempts at solving this problem:
> > > >
> > > > [RFC PATCH v11 0/5] PCI: rockchip: Move PCIe WAKE# handling into pci core
> > > > https://lkml.kernel.org/lkml/20171225114742.18920-1-jeffy.chen@rock-chips.com/
> > > > http://lkml.kernel.org/lkml/20171226023646.17722-1-jeffy.chen@rock-chips.com/
> > > >
> > > > As you can see by the 12th iteration, it wasn't left unsolved for lack
> > > > of trying...
> > >
> > > I wasn't aware of this. That's definitely a better approach than my
> > > hack, and I would really like this to be revived.
> > >
> >
> > I don't think this approach is entirely sound either.
>
> (I'm sure there may be problems with the above series. We probably
> should give it another shot though someday, as I think it's closer to
> the mark.)
>
> > From the side of the PCI device, WAKE# is just a GPIO line, and how it
> > is wired into the system is an entirely separate matter. So I don't
> > think it is justified to overload the notion of legacy interrupts with
> > some other pin that may behave in a way that is vaguely similar to how
> > a true wake-up capable interrupt works.
>
> I think you've conflated INTx with WAKE# just a bit (and to be fair,
> that's exactly what the bad binding we're trying to replace did,
> accidentally). We're not trying to claim this WAKE# signal replaces the
> typical PCI interrupts, but it *is* an interrupt in some sense --
> "depending on your definition of interrupt", per our IRC conversation ;)
>
> > So I'd argue that we should add an optional 'wake-gpio' DT property
> > instead to the generic PCI device binding, and leave the interrupt
> > binding and discovery alone.
>
> So I think Mark Rutland already shot that one down; it's conceptually an
> interrupt from the device's perspective.

Which device are you talking about?  The one that signals wakeup?  If
so, then I beg to differ.

On ACPI platforms WAKE# is represented as an ACPI GPE that is signaled
through SCI and handled at a different level (on HW-reduced ACPI it
actually can be a GPIO interrupt, but it still is handled with the
help of AML).  The driver of the device signaling wakeup need not even
be aware that WAKE# has been asserted.

> We just need to figure out a good way of representing it that doesn't stomp on the existing INTx
> definitions.

WAKE# is a signal that is converted into an interrupt, but that
interrupt may arrive at some place your driver has nothing to do with.
It generally doesn't make sense to represent it as an interrupt for
the target device.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A0DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:16:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2230220851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mSseJXvc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kViykZsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2230220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U22w8VRmEr7nmmJ6rvIUuhSnbrhbHwO/FOiTHgy4A+4=; b=mSseJXvcE5V53y
	53+YUOjzqdOEJDhRk6ENxjv3L+V3QoVn5I9NR8+lH4gbyQo6R0ASgdBwFjEDgWD7CDJfgllO6FMkM
	fVMqpNvfRn38pEgHGE/s15RfVHZvz4Racz8+UuglwwqZ6Nx48H5Y3QqZ2et7EaAr9mTr2IIGkPmtu
	zUDx3ZzWrclhDaSG1LDp36FucZvAwN5vEBv9ADOmFd5eOGbtSWG4e1a0C3PdYdaP6fS2fBBnfSuRp
	S6VKtQqvdpaqa4/+D5ltUnNWoDANSiW4lXBEbdN3vBwVZhwxBk+mdQSvJCcxwd8nlikn3Ry6hq28Z
	2pYH2ABeRpB6rMqsxO0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gywGL-0007R7-P6; Wed, 27 Feb 2019 10:16:29 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gywGH-0007Pa-HQ
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 10:16:27 +0000
Received: by mail-io1-xd44.google.com with SMTP id e186so13112353ioa.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 02:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PSEnQlO4ryJ5lj1eUjpEnJNgdDcKb7s4xmHWDAD6wFA=;
 b=kViykZsxAUrFfq+Zejo7w/E/rf9vjyhY37z3ZMXmnrLLe+2bIJAcGuMwJ1ykxz9SbX
 7Onuzn+mjyJ+CORMNaLMs6rvT1d+wofFxEzhfLwUZN0gYADKSuslU4XizGqvW6cFg8df
 9FnZayk+IY23PEAwkPp/yLJHp+V4tlzGmJpS9mk3fGnYY8hXccOJFheQU/A0nK9MOW4p
 2NNZxGmcRRGobB4eLftBGlBjbuvCgPNjEdAXyZQwBpJtwHYgXJ743qH03WcsLknv7RxM
 X2tGkThjD3HG8CmkwnWxElob6zXzjxj1ZPPPiAQSu+zUYB4cPNQCa2Cl1ywz3/pPDzWF
 1/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PSEnQlO4ryJ5lj1eUjpEnJNgdDcKb7s4xmHWDAD6wFA=;
 b=c7XGEbJyDiItnE9EksKUpMp92AGjDZQwnnZxRJYNpn2LfZRvqhlj1uIJnQ7OWQxAZi
 n7mu3ZDK9xL+rbHjv7yw/bMuOTv6NAajQ6Bwrat3kPPp6uh1ehdhCj49o2oAWzGVmtdT
 1q8vExX/XCrxRaHVro1CaifnvsCUdmC9QTnC9+UuxALqo5g2hjJBztfF6QcRAFbOVlre
 Fb/whC8LaUQTxhc4Jv2OSu+Cnrr0OEVmDJpsQc9JOkpnWxzpHY6q1criDSXk4zckmG2A
 0WwMdb6VGl4kWCF7/IEMsW2VS/utr7ZelqQij7pc/7m3ixNxgZ/DpVKzn8BSzlNMZpD1
 roYA==
X-Gm-Message-State: APjAAAUHG+ih3wmNi+OB5VDpVJJEb6QBm97+loLK5vCzxlb98VUKrrkh
 dZXYesf3YiawTTInvwM44JjesC+lDbG21i8aCtTUag==
X-Google-Smtp-Source: APXvYqxO9HQ9KWZQWEqmdGEwKaw5+KXyYiq9o9hgt1i/4kSVEQkCmMwNZAPJ/7nG39ptRqsCkOpqcQLOfsuy1y978mo=
X-Received: by 2002:a6b:7b02:: with SMTP id l2mr1605643iop.60.1551262583854;
 Wed, 27 Feb 2019 02:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <20190226232822.GA174696@google.com>
 <d67512fe-42b4-513f-d27a-fed85c19e9c2@arm.com>
In-Reply-To: <d67512fe-42b4-513f-d27a-fed85c19e9c2@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 27 Feb 2019 11:16:12 +0100
Message-ID: <CAKv+Gu_fZK7dUqrrVPCejAZNWyUeMUX2ojQ=vQ3hiMkGF6e6tw@mail.gmail.com>
Subject: Re: [PATCH 0/4] mwifiex PCI/wake-up interrupt fixes
To: Marc Zyngier <marc.zyngier@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_021625_592392_C3BF9034 
X-CRM114-Status: GOOD (  22.81  )
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
Cc: Ganapathi Bhat <gbhat@marvell.com>, Brian Norris <briannorris@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Devicetree List <devicetree@vger.kernel.org>,
 Xinming Hu <huxinming820@gmail.com>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amitkumar Karwar <amitkarwar@gmail.com>, linux-rockchip@lists.infradead.org,
 Nishant Sarmukadam <nishants@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kalle Valo <kvalo@codeaurora.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 27 Feb 2019 at 11:02, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> + Lorenzo
>
> Hi Brian,
>
> On 26/02/2019 23:28, Brian Norris wrote:
> > + others
> >
> > Hi Marc,
> >
> > Thanks for the series. I have a few bits of history to add to this, and
> > some comments.
> >
> > On Sun, Feb 24, 2019 at 02:04:22PM +0000, Marc Zyngier wrote:
> >> For quite some time, I wondered why the PCI mwifiex device built in my
> >> Chromebook was unable to use the good old legacy interrupts. But as MSIs
> >> were working fine, I never really bothered investigating. I finally had a
> >> look, and the result isn't very pretty.
> >>
> >> On this machine (rk3399-based kevin), the wake-up interrupt is described as
> >> such:
> >>
> >> &pci_rootport {
> >>      mvl_wifi: wifi@0,0 {
> >>              compatible = "pci1b4b,2b42";
> >>              reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
> >>                     0x83010000 0x0 0x00100000 0x0 0x00100000>;
> >>              interrupt-parent = <&gpio0>;
> >>              interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> >>              pinctrl-names = "default";
> >>              pinctrl-0 = <&wlan_host_wake_l>;
> >>              wakeup-source;
> >>      };
> >> };
> >>
> >> Note how the interrupt is part of the properties directly attached to the
> >> PCI node. And yet, this interrupt has nothing to do with a PCI legacy
> >> interrupt, as it is attached to the wake-up widget that bypasses the PCIe RC
> >> altogether (Yay for the broken design!). This is in total violation of the
> >> IEEE Std 1275-1994 spec[1], which clearly documents that such interrupt
> >> specifiers describe the PCI device interrupts, and must obey the
> >> INT-{A,B,C,D} mapping. Oops!
> >
> > You're not the first person to notice this. All the motivations are not
> > necessarily painted clearly in their cover letter, but here are some
> > previous attempts at solving this problem:
> >
> > [RFC PATCH v11 0/5] PCI: rockchip: Move PCIe WAKE# handling into pci core
> > https://lkml.kernel.org/lkml/20171225114742.18920-1-jeffy.chen@rock-chips.com/
> > http://lkml.kernel.org/lkml/20171226023646.17722-1-jeffy.chen@rock-chips.com/
> >
> > As you can see by the 12th iteration, it wasn't left unsolved for lack
> > of trying...
>
> I wasn't aware of this. That's definitely a better approach than my
> hack, and I would really like this to be revived.
>

I don't think this approach is entirely sound either.

From the side of the PCI device, WAKE# is just a GPIO line, and how it
is wired into the system is an entirely separate matter. So I don't
think it is justified to overload the notion of legacy interrupts with
some other pin that may behave in a way that is vaguely similar to how
a true wake-up capable interrupt works.

So I'd argue that we should add an optional 'wake-gpio' DT property
instead to the generic PCI device binding, and leave the interrupt
binding and discovery alone.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

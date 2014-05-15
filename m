From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 15:32:46 +0200
Subject: [PATCH v6 1/3] ARM: kconfig: allow PCI support to be selected
 with ARCH_MULTIPLATFORM
In-Reply-To: <CAL_JsqLbWL136=dGZZfzPbPdF5HjhktYwLaVfbkOoo7Tr+g9Pg@mail.gmail.com>
References: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
 <20140515123948.GD27594@arm.com>
 <CAL_JsqLbWL136=dGZZfzPbPdF5HjhktYwLaVfbkOoo7Tr+g9Pg@mail.gmail.com>
Message-ID: <10281549.JzWby2ApEY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 08:16:16 Rob Herring wrote:
> On Thu, May 15, 2014 at 7:39 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, May 14, 2014 at 03:01:35PM +0100, Rob Herring wrote:
> >> On Wed, May 7, 2014 at 11:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> >> > When targetting ARCH_MULTIPLATFORM, we may include support for SoCs with
> >> > PCI-capable devices (e.g. mach-virt with virtio-pci).
> >> >
> >> > This patch allows PCI support to be selected for these SoCs by selecting
> >> > CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_MULTIPLATFORM=y.
> >>
> >> I generally think we should select all options for multi-platform that
> >> only serve to hide other options like this.
> >>
> >> You should remove the MIGHT_HAVE_PCI selections from all the
> >> multi-platform enabled platforms as well.
> >
> > Something like the diff below?
> 
> Yes, but that raises another question as to what do we do with
> PCI_DOMAINS? Probably should be a PCI host driver select, or given how
> little code it controls it could just be removed. Anyway, that's a
> problem for another day (or patch).
> 
> So with the below part added:
> 
> Acked-by: Rob Herring <robh@kernel.org>

I think we should also 'select PCI_DOMAINS if PCI' for multiplatform, but
I agree it doesn't have to be in this patch.

	Arnd

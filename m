From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 28 Jan 2015 10:46:45 +0100
Subject: arm64: USB_ARCH_HAS_EHCI
In-Reply-To: <alpine.DEB.2.02.1501272130470.19947@utopia.booyaka.com>
References: <1422351833.14015.20.camel@x220>
 <alpine.DEB.2.02.1501272130470.19947@utopia.booyaka.com>
Message-ID: <1422438405.5666.16.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-27 at 21:31 +0000, Paul Walmsley wrote:
> On Tue, 27 Jan 2015, Paul Bolle wrote:
> 
> > Your commit d035fdfa27ac ("arm64: Add Tegra132 support") is included in
> > today's linux-next (ie, next-20150127). I noticed because a script I use
> > to check linux-next spotted a minor problem with it.
> > 
> > It adds a select for the Kconfig symbol USB_ARCH_HAS_EHCI. That Kconfig
> > was obsoleted in v3.11 and removed in v3.15. See commit b797b76fb464
> > ("usb: host: remove USB_ARCH_HAS_?HCI"). That select is now a nop.
> > 
> > Should I submit the trivial patch to remove that line or do you prefer
> > to do that yourself?
> 
> Thanks, I'll post a new version.

I just noticed that your commit added another unneeded select. The entry
for ARCH_TEGRA selects HAVE_SMP, but HAVE_SMP is only available on arm
or xtensa. There's no point in selecting it in arm64.

(The patch I submitted in https://lkml.org/lkml/2014/9/30/578 would have
warned about this. See https://lkml.org/lkml/2014/9/30/577 for an
introduction. I'll see if I can get Michal Marek to put that patch in a
tree that is part of linux-next.)


Paul Bolle

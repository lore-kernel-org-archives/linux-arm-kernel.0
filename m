From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Nov 2017 23:13:26 +0000
Subject: [PATCH 0/2] STRICT_KERNEL_RWX weakened on ARM by CONFIG_ARM_LPAE=y
In-Reply-To: <20171109094920.2xpyhtrwj5kjb2qz@tarshish>
References: <20171109004144.2246-1-philip@cog.systems>
 <CAGXu5jKBipDwQLz=ez8-SCW4=QNw8hNi+e4NYzQhbfEFACggcQ@mail.gmail.com>
 <20171109093734.GB12318@n2100.armlinux.org.uk>
 <20171109094920.2xpyhtrwj5kjb2qz@tarshish>
Message-ID: <20171109231326.GF12318@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 11:49:20AM +0200, Baruch Siach wrote:
> Hi Russell,
> 
> On Thu, Nov 09, 2017 at 09:37:34AM +0000, Russell King - ARM Linux wrote:
> > On Wed, Nov 08, 2017 at 05:23:43PM -0800, Kees Cook wrote:
> > > On Wed, Nov 8, 2017 at 4:41 PM, Philip Derrin <philip@cog.systems> wrote:
> > > > Hi,
> > > >
> > > > This patch series fixes a bug which makes CONFIG_STRICT_KERNEL_RWX ineffective
> > > > when CONFIG_ARM_LPAE is enabled. Specifically, the kernel text and rodata are
> > > > mapped writeable. This has been the case since DEBUG_RODATA for ARM was first
> > > > merged in 3.19.
> > > >
> > > > The cause was an incorrect conflict resolution in 1e3479225acb ("ARM: 8275/1:
> > > > mm: fix PMD_SECT_RDONLY undeclared compile error") between the commit that
> > > > implemented DEBUG_RODATA, 80d6b0c2eed2 ("ARM: mm: allow text and rodata
> > > > sections to be read-only"), and another that moved the LPAE read-only bit into
> > > > a software bit, ded947798469 ("ARM: 8109/1: mm: Modify pte_write and pmd_write
> > > > logic for LPAE").
> > > >
> > > > The incorrect mappings were not apparent in the debugfs kernel_page_tables
> > > > dump because that was checking only the software RO bit, not the hardware RO
> > > > bit.
> > > 
> > > Thanks for catching this! Please consider both patches:
> > > 
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Where are these patches, and why weren't they copied to the arm kernel
> > list?
> 
> I got the patches from the list.
> 
>   Cover:
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/541532.html
>   1/2:
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/541531.html
>   2/2:
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/541533.html

Ah, dspam decided they were spam, so they ended up in one of my junk
mailboxes.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

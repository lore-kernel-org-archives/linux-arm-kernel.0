From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 Mar 2013 15:20:30 -0400
Subject: [PATCH] arm: mvebu: Fix the memory size on the Mirabox
In-Reply-To: <CABx3TkWDrN1wCvECjja=EGeGFB-QpFmCG5FGO=1n+343fcCXcQ@mail.gmail.com>
References: <1364579477-19018-1-git-send-email-ryan@presslab.us>
 <20130329180447.GK13280@titan.lakedaemon.net>
 <CABx3TkVK86b8Ku4EvUVe8OBtprwKW6YtJ7OU6YVHa3Bd5s7DsQ@mail.gmail.com>
 <20130329193716.GA7127@localhost>
 <20130329194453.GN13280@titan.lakedaemon.net>
 <CABx3TkWDrN1wCvECjja=EGeGFB-QpFmCG5FGO=1n+343fcCXcQ@mail.gmail.com>
Message-ID: <20130330192030.GR13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 08:30:35PM -0700, Ryan Press wrote:
> On Fri, Mar 29, 2013 at 12:44 PM, Jason Cooper <jason@lakedaemon.net> wrote:
...
> > In this case, the bootloader should be amending the dtb to provide the
> > correct value for the particular board.  If your bootloader is
> > devicetree-capable, it'll happen auto-magically.  Otherwise, you'll need
> > to enable ARM_ATAG_DTB_COMPAT.

To clarify, I meant to enable this in the kernel.  It'll then take the
ATAGs passed from the bootloader (including RAM size), and modify the
dtb accordingly.  No bootloader modification necessary.

It's used as a stop-gap measure (including ARM_APPENDED_DTB) until
everyone is shipping devices with devicetree-aware bootloaders.
Primarily for developers and tinkerers.

> The U-Boot that comes with the Mirabox is not capable of devicetree;
> it is circa 2009 so it has some support for other CPUs but not ARM.

?

> I didn't see any Armada support in mainline U-Boot.  I am working on
> making the old U-Boot devicetree capable and I am close.  I see that
> there is an fdt_memory_fixup function that adds the memory entries, so
> I will be sure to implement that.  I think getting a devicetree
> capable bootloader is the best way forward.

See my comment above.  It's a lot less work ;-)

hth,

Jason.

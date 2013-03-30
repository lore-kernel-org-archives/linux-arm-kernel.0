From: ryan@presslab.us (Ryan Press)
Date: Fri, 29 Mar 2013 20:30:35 -0700
Subject: [PATCH] arm: mvebu: Fix the memory size on the Mirabox
In-Reply-To: <20130329194453.GN13280@titan.lakedaemon.net>
References: <1364579477-19018-1-git-send-email-ryan@presslab.us>
 <20130329180447.GK13280@titan.lakedaemon.net>
 <CABx3TkVK86b8Ku4EvUVe8OBtprwKW6YtJ7OU6YVHa3Bd5s7DsQ@mail.gmail.com>
 <20130329193716.GA7127@localhost>
 <20130329194453.GN13280@titan.lakedaemon.net>
Message-ID: <CABx3TkWDrN1wCvECjja=EGeGFB-QpFmCG5FGO=1n+343fcCXcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Fri, Mar 29, 2013 at 12:44 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Fri, Mar 29, 2013 at 04:37:17PM -0300, Ezequiel Garcia wrote:
>> On Fri, Mar 29, 2013 at 11:09:23AM -0700, Ryan Press wrote:
>> > On Fri, Mar 29, 2013 at 11:04 AM, Jason Cooper <jason@lakedaemon.net> wrote:
>> > > On Fri, Mar 29, 2013 at 10:51:17AM -0700, Ryan Press wrote:
>> > >> The memory size in the device tree is only 512 MB, but the
>> > >> Mirabox actually has 1 GB.
>> > >>
>> > >> Tested the change with memtester and no problems found.
>> > >>
>> > >> Signed-off-by: Ryan Press <ryan@presslab.us>
>> > >> ---
>> > >>  arch/arm/boot/dts/armada-370-mirabox.dts | 2 +-
>> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > Thanks for the patch.  It looks good, but please don't forget to Cc: the
>> > > maintainers (Andrew Lunn, Gregory Clemente, and myself).  I almost
>> > > missed this one. :)
>> > >
>>
>> As far as I can remember, Gregory has a Mirabox with only 512 MiB,
>> which means some boards were shipped with 512 MiB and some with 1 GiB.
>> Moreover, apparently nothing can distinguish one from the other.
>>
>> @Gregory: can you confirm this?
>>
>> If Gregory confirms this, then we shouldn't apply this patch.
>> Don't forget in-kernel DTS are only meant for developers and
>> for reference. The vendor (Globalscale in this case) has to ship
>> a proper DTS for each board.
>
> In this case, the bootloader should be amending the dtb to provide the
> correct value for the particular board.  If your bootloader is
> devicetree-capable, it'll happen auto-magically.  Otherwise, you'll need
> to enable ARM_ATAG_DTB_COMPAT.
>
> I'll drop this patch unless Gregory says it's ok.

I didn't realize that some Mirabox had 512 MB, so that makes sense.
The U-Boot that comes with the Mirabox is not capable of devicetree;
it is circa 2009 so it has some support for other CPUs but not ARM.  I
didn't see any Armada support in mainline U-Boot.  I am working on
making the old U-Boot devicetree capable and I am close.  I see that
there is an fdt_memory_fixup function that adds the memory entries, so
I will be sure to implement that.  I think getting a devicetree
capable bootloader is the best way forward.

Thanks,
Ryan

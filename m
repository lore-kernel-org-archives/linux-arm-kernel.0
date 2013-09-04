From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Sep 2013 11:39:59 +0200
Subject: [PATCH 1/4] ARM: shmobile: r8a7778: add Ether DT support
In-Reply-To: <CANqRtoSfsEwqJhh9DgX6jxK5DjH5FeroMAcsvss5o2vAzFk-pg@mail.gmail.com>
References: <201309010311.05466.sergei.shtylyov@cogentembedded.com>
 <52262A1B.4050406@cogentembedded.com>
 <CANqRtoSfsEwqJhh9DgX6jxK5DjH5FeroMAcsvss5o2vAzFk-pg@mail.gmail.com>
Message-ID: <76573995.iPm3QS0b9I@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 September 2013 14:35:14 Magnus Damm wrote:
> On Wed, Sep 4, 2013 at 3:27 AM, Sergei Shtylyov wrote:
> > On 09/03/2013 07:17 PM, Magnus Damm wrote:
> >>> Define the generic R8A777x part of the Ether device node.
> >>> 
> >>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>> 
> >>> ---
> >>> 
> >>>   arch/arm/boot/dts/r8a7778.dtsi |   11 +++++++++++
> >>>   1 file changed, 11 insertions(+)
> >>> 
> >>> Index: renesas/arch/arm/boot/dts/r8a7778.dtsi
> >>> ===================================================================
> >>> --- renesas.orig/arch/arm/boot/dts/r8a7778.dtsi
> >>> +++ renesas/arch/arm/boot/dts/r8a7778.dtsi
> >>> @@ -98,4 +98,15 @@
> >>>                  reg = <0xfffc000 0x118>;
> >>>                  #gpio-range-cells = <3>;
> >>>          };
> >>> +
> >>> +       ether: ethernet at fde00000 {
> >>> +               device_type = "network";
> >>> +               compatible = "renesas,ether-r8a7779";
> >> 
> >> Hi Sergei,
> >> 
> >> Thanks for your patch. What's the reason behind the r8a7778 SoC using
> >> a compatible string for r8a7779 like "renesas,ether-r8a7779"?
> >
> > R8A7779 support has appeared first in Linux and as R8A7778 Ether is
> > identical to R8A7779 and no wildcards are allowed in the device tree, I
> > decided to use this "compatible" prop.
> 
> Thanks for your reply, I see.
> 
> >> It seems that you assume that the r8a7778 ethernet controller is 100%
> >> compatible with r8a7779. Is that really true? For earlier versions the
> >> sh_eth hardware documentation was anything but accurate, so it seems
> >> to me that it must be more safe that r8a7778 would be using
> >> "renesas,ether-r8a7778". What do you think?
> >
> > I think R8A7778 and R8A7779 EtherMACs are identical. I've cross checked
> > the documentation at the start of the development and the registers
> > appeared to be the same.
> 
> But even if the current version of the documentation happens to be
> similar in it still doesn't guarantee that the IP is the same. And
> using the "correct" SoC compatible value doesn't really hurt in any
> way, does it?
> 
> My feeling is that using the identical SoC as compatible value must be
> the best option - unless we know for sure they are identical that is.
> 
> So unless we're 100% certain about IP compatibility I'm trying to
> enforce that we either use a strict matching for exactly the same SoC
> version or IP block. Using a different maybe-compatible SoC string
> seems to be begging for future trouble IMO.
> 
> Laurent, any opinion?

I agree. If we had access to IP version information we could use that to 
construct the compatible name. As we don't, the SoC name is the best option, 
and to ensure future compatibility we should use the exact SoC version.

-- 
Regards,

Laurent Pinchart

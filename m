From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 16:47:57 -0300
Subject: [PATCH] ARM: Kirkwood: Fix the internal register ranges
 translation
In-Reply-To: <51C0B838.90809@gmail.com>
References: <1371569479-31498-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <51C0B838.90809@gmail.com>
Message-ID: <20130618194756.GA2470@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 09:42:48PM +0200, Sebastian Hesselbarth wrote:
> On 06/18/2013 05:31 PM, Ezequiel Garcia wrote:
> > Although the internal register window size is 1 MiB, the previous
> > ranges translation for the internal register space had a size of
> > 0x4000000. This was done to allow the crypto and nand node to access
> > the corresponding 'sram' and 'nand' decoding windows.
> >
> > In order to describe the hardware more accurately, we declare the
> > real 1 MiB internal register space in the ranges, and add a translation
> > entry for the nand node to access the 'nand' window.
> >
> > This commit will make future improvements on the MBus DT binding easier.
> >
> > Signed-off-by: Ezequiel Garcia<ezequiel.garcia@free-electrons.com>
> > ---
> > Tested on Plathome Openblocks A6 board.
> >
> >   arch/arm/boot/dts/kirkwood.dtsi | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> > index 8a1e3bb..910fabc 100644
> > --- a/arch/arm/boot/dts/kirkwood.dtsi
> > +++ b/arch/arm/boot/dts/kirkwood.dtsi
> > @@ -38,7 +38,8 @@
> >
> >   	ocp at f1000000 {
> >   		compatible = "simple-bus";
> > -		ranges =<0x00000000 0xf1000000 0x4000000
> > +		ranges =<0x00000000 0xf1000000 0x0100000
> > +		          0xf4000000 0xf4000000 0x0000400
> >   		          0xf5000000 0xf5000000 0x0000400>;
> 
> Ezequiel,
> 
> maybe you should also put a comment at the end of each ranges
> line to name the remap it does?
> 
> Also, as already mentioned on IRC, it would be great to also
> have dove.dtsi updated accordingly.
> 

Indeed, I will do both.

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

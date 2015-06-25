From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Jun 2015 22:12:53 -0700
Subject: [PATCH 2/2] arm: boot: store ATAG structure into DT atags field
In-Reply-To: <46811670.AspmkHD9JS@wuerfel>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <3513646.XX80DTTJbc@wuerfel> <201505152216.24622@pali>
 <46811670.AspmkHD9JS@wuerfel>
Message-ID: <20150625051253.GN4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [150515 13:23]:
> On Friday 15 May 2015 22:16:24 Pali Roh?r wrote:
> > On Friday 15 May 2015 22:12:41 Arnd Bergmann wrote:
> > > On Friday 15 May 2015 21:50:07 Pali Roh?r wrote:
> > > >                 }
> > > >         
> > > >         }
> > > > 
> > > > +       /* include the terminating ATAG_NONE */
> > > > +       atag_size = (char *)atag - (char *)atag_list +
> > > > sizeof(struct tag_header); +       setprop(fdt, "/", "atags",
> > > > atag_list, atag_size);
> > > > +
> > > > 
> > > >         if (memcount) {
> > > >         
> > > >                 setprop(fdt, "/memory", "reg", mem_reg_property,
> > > >                 
> > > >                         4 * memcount * memsize);
> > > 
> > > The property should probably have a DT binding, and be named
> > > "linux,atags".
> > > 
> > > It may also help to check if the "linux,atags" property already
> > > exists and not create it otherwise. That way we can put it into the
> > > n900 dts file and have it updated by the compat code, but not expose
> > > the atags on other platforms unless they opt in.

Using "linux,atags" sounds good to me. And yes checking it with
getprop before doing setprop makes sense.

> > Maybe what would help: Is there a way to tell decompressor/kernel to not 
> > touch atag memory and then after kernel/board-code starts it save copy 
> > of atags? I think it is not possible right now, but correct me if I'm 
> > wrong...
> > 
> 
> I don't think that is possible without an incompatible change to the
> boot protocol.

Agreed, let's keep the changes to minimum.

Looks like with the comments posted all the pending four patches
from Pali become quite a minimal set of three patches if we keep
the rev string as hex.

Regrds,

Tony

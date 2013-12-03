From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Dec 2013 22:50:05 +0100
Subject: [PATCH 1/2] ARM: DT: Kirkwood: Use symbolic names from input.h
In-Reply-To: <87fvq9brfd.fsf@natisbad.org>
References: <1386100305-31280-1-git-send-email-andrew@lunn.ch>
 <87fvq9brfd.fsf@natisbad.org>
Message-ID: <20131203215005.GA31337@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 09:39:02PM +0100, Arnaud Ebalard wrote:
> Hi Andrew,
> 
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> > Replace the numeric key value with a symbolic name from
> > <bt-bindings/input/input.h>
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/arm/boot/dts/kirkwood-cloudbox.dts                | 2 +-
> >  arch/arm/boot/dts/kirkwood-dnskw.dtsi                  | 6 +++---
> >  arch/arm/boot/dts/kirkwood-ib62x0.dts                  | 4 ++--
> >  arch/arm/boot/dts/kirkwood-iconnect.dts                | 4 ++--
> >  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts          | 6 +++---
> >  arch/arm/boot/dts/kirkwood-lsxl.dtsi                   | 6 +++---
> >  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts         | 4 ++--
> >  arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 6 +++---
> 
> Jason just applied (yesterday IIRC) to mvebu/dt a series which provides
> cleanup for ReadyNAS .dts files. Among other things, it replaces numeric
> key values with a symbolic name. And it also does the same for GPIO
> voltage level. I guess you can remove that specific .dts from your patch.

I sore your patches. I did it slightly different to you, in that i've
the includes in the top level kirkwood.dtsi file, where as you put
them into the .dts files. That makes yours redundant, if we keep to
this scheme.

Jason, which do you prefer, includes in every .dts file, or once in
kirkwood.dtsi. 

> Just in case you have the same in preparation for armada .dts files,
> RN102 and RN104 .dts files are also fixed in mvebu/dt.

I've nothing for those files.

     Andrew

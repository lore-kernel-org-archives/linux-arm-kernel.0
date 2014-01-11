From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Jan 2014 14:15:28 +0100
Subject: DT include files
In-Reply-To: <20140111031214.GK21717@S2101-09.ap.freescale.net>
References: <20140103023211.GA25079@S2101-09.ap.freescale.net>
 <CAOesGMhP5t=QHj7TdDY9Nq+=WHeQXv1V0n9TGmmEnqSG9SaFKg@mail.gmail.com>
 <20140111031214.GK21717@S2101-09.ap.freescale.net>
Message-ID: <201401111415.29395.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 11 January 2014, Shawn Guo wrote:
> While I agree such macro usage should be avoided or limited, it really
> helps IMX pinctrl case to improve the readability and make the handwriting
> of these pinctrl entries less error prone.  Isn't it the whole point of
> introducing macro support for DTC?

The macros are useful for all cases where the binding defines an
arbitrary number space, e.g. for the interrupt flags or when a
clock or pin controller provides a set of pins/clocks that don't
already have a number assigned to them. In this case, the header
file can be shared between the dts and kernel source files to ensure
that they are talking about the same things.

However, I don't like to see uses of such macros where the definition
is done to match a hardware constant (bit number, register index, etc),
like in the recently posted eDMA driver case. Here the macro /reduces/
readability of the dts source IMHO, because you cannot easily check
the dts file against the data sheet without cross-referencing the
header file as well.

	Arnd

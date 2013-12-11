From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 11 Dec 2013 10:48:27 -0500 (EST)
Subject: [PATCH 0/8] Impedance matcher for Samsung boards
In-Reply-To: <52A88286.2030401@gmail.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <005d01cef679$be770570$3b651050$%wilczek@samsung.com>
 <52A8725F.2020403@gmail.com> <1837099.JIoGixjT73@amdc1227>
 <52A88286.2030401@gmail.com>
Message-ID: <alpine.LFD.2.10.1312111040240.15948@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Dec 2013, Daniel Mack wrote:

> On 12/11/2013 03:28 PM, Tomasz Figa wrote:
> > There are some parameters that bootloaders normally pass with ATAGS
> > and can't be hardcoded in DT, such as initrd location in memory, serial
> > number, board revision, command line and in some cases even memory,
> > as on some boards it might vary between units.
> 
> Ok, that was my question :) Sure, if you have units that differ in
> hardware details, but are indistinguishable by their machine ID or board
> revision number, there's not much that we can do but modify the FDT at
> runtime. Serial numbers are also something that can't be solved in a
> nicer way.
> 
> What bugs me, though, is that it blows up the code base so massively.

You could investigate gcc's -ffunction-sections argument.  This won't 
help with the code size, but it does help for discarding unreferenced 
functions from the final lbinary.


Nicolas

From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 11 Aug 2015 08:16:34 -0400 (EDT)
Subject: [PATCH v3] ARM: appropriate __init annotation for const data
In-Reply-To: <20150811094512.GY7557@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.20.1507271750160.1806@knanqh.ubzr>
 <20150811094512.GY7557@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.20.1508110813130.1515@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Aug 2015, Russell King - ARM Linux wrote:

> On Mon, Jul 27, 2015 at 06:27:52PM -0400, Nicolas Pitre wrote:
> > Init data marked const should be annotated with __initconst for
> > correctness and not __initdata.  In some cases the array gathering
> > references to that data has to be marked const as well. This fixes
> > LTO builds that otherwise fail with section mismatch errors.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> Can we please get a little smarter at splitting up changes between core
> ARM code and SoC ARM code please.
> 
> This now causes a delete/modify conflict between my tree and arm-soc,
> because I'm now carrying ARMs patches which move arch/arm/kernel/psci.c
> to drivers/firmware.

This is the only occurrence in the core code so it slipped through.  
Sorry about that.

> Right now, my resolution for that conflict is to just delete the old
> file, I'm not even checking to see whether the new one needs this
> change applied.  If it does, please submit a change on top of my
> tree.

No problem.


Nicolas

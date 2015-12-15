From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 15 Dec 2015 19:06:17 +0100
Subject: [PATCH v5 2/2] arm: pxa27x: support for ICP DAS LP-8x4x w/ DT
In-Reply-To: <1450200281.21989.24.camel@gmail.com> (Sergei Ianovich's message
 of "Tue, 15 Dec 2015 20:24:41 +0300")
References: <1449700088-28076-3-git-send-email-ynvich@gmail.com>
 <7496839.vMjVcqPe8Q@wuerfel> <1450197727.21989.9.camel@gmail.com>
 <1843454.zCnLJtF7B6@wuerfel> <1450200281.21989.24.camel@gmail.com>
Message-ID: <87a8pbio2u.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Ianovich <ynvich@gmail.com> writes:

> On Tue, 2015-12-15 at 18:02 +0100, Arnd Bergmann wrote:
>> On Tuesday 15 December 2015 19:42:07 Sergei Ianovich wrote:
>> > There are several board-specific devices on LP8x4x: custom FPGA,
>> > custom
>> > UART, custom IRQ on FPGA, custom parallel bus for industrial IO. The
>> > defconfig file could alert potential users to this fact. If this is
>> > not
>> > a sufficient reason to have a defconfig file, it can be dropped.
>> > 
>> > I use the full .config anyway 
>> 
>> I would like those drivers to be enabled in some defconfig, so we get
>> compile-time coverage, but we generally stopped having one-config-per-
>> board
>> files.
>> 
>> Maybe we can have a pxa_defconfig file that enables lots of boards
>> and then we remove the individual configs? We don't have to remove
>> them all at once, but it would make me very happy if we could at
>> least kill off some of the ones that are not used regularly.
Yeah, I'd be happy too, that would simplify also my life.

Actually I was thinking of 2 defconfigs :
 - one for platform_data based boards pxa2xx
 - one for DT only boards pxa2xx

> lp8x4x seems to be the first pxa board which requires DT.
Most probably AFAIK.

> We can create pxa27x-dt_defconfig which selects:
> 1. PXA27X_DT
> 2. PXA_FB and 8250_PXA to enable console
> 3. MMC, MMC_PXA and EXT4_FS to enable boot from MMC
If you put MMC_PXA, one can argue why not any MTD device used on pxa devices,
such as pxa2xx-flash or docg3/docg4, etc ... I won't argue, I'm just pondering
about the right choice.

> 4. all optional pxa stuff as modules
> 5. all stuff on supported pxa boards as modules

> If #5 is extended when support for new boards is added, it should be
> possible to run any supported pxa27x board with pxa27x_defconfig.

I'm very eager to see a patch on that. I can feed my Jenkins with it, it would
greatly help me catch issues earlier. Moreover it would for free test it on
lubbock, mainstone and mioa701. If there was one also for pxa3xx, I would launch
it on zylonite cm-x300 ... (that's a bonus, I know :))

Cheers.

-- 
Robert

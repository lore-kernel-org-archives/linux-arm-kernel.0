From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 22 Dec 2015 12:49:07 -0800
Subject: [PATCH v11 0/2] Sigma Designs Tango4 port
In-Reply-To: <5679B15F.80106@free.fr> (Mason's message of "Tue, 22 Dec 2015
 21:23:59 +0100")
References: <566FDF53.3030004@sigmadesigns.com>
 <7hr3iexp3e.fsf@deeprootsystems.com> <5679B15F.80106@free.fr>
Message-ID: <7hoadi6wfw.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 22/12/2015 20:25, Kevin Hilman wrote:
>
>> Marc Gonzalez wrote:
>> 
>>> Changes since v10:
>>> Add aliases and chosen DT nodes
>>> Use CPU_CLK and SYS_CLK symbolic names
>>> MPCore private memory region DT node
>>> select TANGO_IRQ instead of GENERIC_IRQ_CHIP
>>>
>>> Changes planned for a future patch series:
>>> Have clkgen driver export CD2 for USB, and CD6 for SDIO
>> 
>> Was it intentional to leave out a multi_v7_defconfig change so that this
>> actually builds?  Or was that planned for a future series?
>
> How is a multi_v7_defconfig different from any old defconfig?

Not sure what you're asking.

The point is that this series doesn't enable any defconfig to build it.

>> IMO, it should be part of this series so it gets build tested as soon as
>> it's merged.
>
> The problem is that a mandatory driver is missing upstream
> (interrupt controller).
>
> http://thread.gmane.org/gmane.linux.kernel/2089470

Which means it presumably wont boot without that, but it should still
build without it, correct?  (I tried it locally, and it does.)

Kevin

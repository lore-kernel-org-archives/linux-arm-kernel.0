From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 13 Jul 2011 17:15:17 -0500
Subject: [PATCH] new helper to define common struct resource constructs
In-Reply-To: <201107132342.18648.arnd@arndb.de>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>
	<201107121529.17611.arnd@arndb.de>
	<20110713141849.b8cbf675.akpm@linux-foundation.org>
	<201107132342.18648.arnd@arndb.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383E058E9@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 13, 2011 2:42 PM, Arnd Bergmann wrote:
> On Wednesday 13 July 2011 23:18:49 Andrew Morton wrote:
>>> On Monday 11 July 2011, Uwe Kleine-K__nig wrote:
>>>> resource definitions that just define start, end and flags = IORESOURCE_MEM
>>>> or IORESOURCE_IRQ (with start=end) are quite common. So introduce a shortcut
>>>> for them. Also make available a macro to specify named resources of both
>>>> types which are less common.
>>>> 
>>>> Signed-off-by: Uwe Kleine-K____nig <u.kleine-koenig@pengutronix.de>
>>> 
>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>> 
>>> What do others think, is this worthwhile?
>>> Should we also define macros for IORESOURCE_IO and IORESOURCE_DMA?
>>> 
>>
>> It would help if we could see some usage examples (ie: sample
>> conversions), to get a better idea of the value of this.
>
> Uwe posted a patch '[PATCH] ARM: mxc: use new helpers to define
> common struct resource entries' that converts one ARM platform to use
> it, with reasonable outcome:
>
> 26 files changed, 72 insertions(+), 308 deletions(-)

ep93xx doesn't have that many but converting it's core.c gives:

 1 files changed, 19 insertions(+), 93 deletions(-)

Regards,
Hartley

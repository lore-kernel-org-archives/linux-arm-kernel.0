From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Mar 2013 11:15:41 +0100
Subject: [PATCH] dma: of-dma: return error when 'dma-cells' not found
In-Reply-To: <5135BE58.4040105@gmail.com>
References: <1362475531-32260-1-git-send-email-padma.v@samsung.com>
 <5135BE58.4040105@gmail.com>
Message-ID: <1859273.NY466Orvuh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013 03:43:52 Rob Herring wrote:
> On 03/05/2013 03:25 AM, Padmavathi Venna wrote:
> > This patch returns error when 'dma-cells' property not found
> > in the corresponding device node. With out this change there
> > is a crash in the generic dma incompatible platforms.
> > 
> > Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> 
> NAK.
> 
> #dma-cells should be optional. It is not needed for platforms supporting
> memory to memory transfers only and should therefore be optional. You
> cannot assume the dtb can be updated and kernel changes need to work
> with old dtbs. I've submitted patches to address this and fix the crash:
> 
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-February/028769.html

Why would you call of_dma_controller_register() for a dma
engine that does not support slave channels, when that is the
only purpose of that interface?

Note that the binding defines #dma-cells as required, and it
does not make any sense otherwise.

	Arnd

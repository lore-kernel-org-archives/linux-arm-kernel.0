From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Mar 2013 16:46:49 +0200
Subject: USB: simplify clock lookup for mv ehci/otg/udc
In-Reply-To: <2174936.bGhG5fu0iO@wuerfel>
References: <2174936.bGhG5fu0iO@wuerfel>
Message-ID: <20130319144649.GA21922@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 19, 2013 at 02:44:46PM +0100, Arnd Bergmann wrote:
> While going over the suggested changes for the ehci-mv separation patch,
> we noticed that the driver uses a variable number of clock names it gets
> passed from the platform code, which is highly unusual behavior and adds
> a lot of extra complexity.
> 
> Even though there is a comment in the mv_udc driver stating that some SoCs
> require multiple clocks, none of the code in the upstream kernel provides
> more than one, and even if an out of tree SoC port needs multiple clocks,
> it is still wrong to pass them them through platform data, since they are
> a property of the device, not a property of the platform.
> 
> This patch attempts to clean up the situation by turning the one clock
> that is passed into the ehci/udc/otg devices into an anomymous one and
> removing the clkname array from the platform data. Another simplification
> is to always call clk_prepare_enable/clk_disable_unprepare directly,
> since that is a valid operation on a NULL clk pointer if the platform
> has not attacked a clk to the device.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

needs to be rebased on my -next branch. Also, it would be really good if
dependencies between drivers and arch code would be cut to a minimum.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130319/327c63d9/attachment.sig>

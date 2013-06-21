From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Jun 2013 11:41:35 -0400
Subject: [PATCH] ARM: Kirkwood: Fix the internal register ranges
 translation
In-Reply-To: <1371569479-31498-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371569479-31498-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130621154135.GS31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 12:31:19PM -0300, Ezequiel Garcia wrote:
> Although the internal register window size is 1 MiB, the previous
> ranges translation for the internal register space had a size of
> 0x4000000. This was done to allow the crypto and nand node to access
> the corresponding 'sram' and 'nand' decoding windows.
> 
> In order to describe the hardware more accurately, we declare the
> real 1 MiB internal register space in the ranges, and add a translation
> entry for the nand node to access the 'nand' window.
> 
> This commit will make future improvements on the MBus DT binding easier.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Tested on Plathome Openblocks A6 board.
> 
>  arch/arm/boot/dts/kirkwood.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to mvebu/dt

thx,

Jason.

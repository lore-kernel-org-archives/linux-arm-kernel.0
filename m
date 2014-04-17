From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Apr 2014 00:48:14 -0400
Subject: [PATCH v2 1/4] memory: mvebu-devbus: fix the conversion of the
 bus width
In-Reply-To: <1397489361-5833-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397489361-5833-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397489361-5833-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140417044814.GM28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 05:29:18PM +0200, Thomas Petazzoni wrote:
> According to the Armada 370 and Armada XP datasheets, the part of the
> Device Bus register that configure the bus width should contain 0 for
> a 8 bits bus width, and 1 for a 16 bits bus width (other values are
> unsupported/reserved).
> 
> However, the current conversion done in the driver to convert from a
> bus width in bits to the value expected by the register leads to
> setting the register to 1 for a 8 bits bus, and 2 for a 16 bits bus.
> 
> This mistake was compensated by a mistake in the existing Device Tree
> files for Armada 370/XP platforms: they were declaring a 8 bits bus
> width, while the hardware in fact uses a 16 bits bus width.
> 
> This commit fixes that by adjusting the conversion logic.
> 
> This patch fixes a bug that was introduced in
> 3edad321b1bd2e6c8b5f38146c115c8982438f06 ('drivers: memory: Introduce
> Marvell EBU Device Bus driver'), which was merged in v3.11.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: stable at vger.kernel.org
> ---
>  drivers/memory/mvebu-devbus.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Applied to mvebu/fixes

thx,

Jason.

From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Apr 2014 00:55:54 -0400
Subject: [PATCH 01/29] ARM: orion5x: fix target ID for crypto SRAM window
In-Reply-To: <1397400006-4315-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140417045554.GN28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 13, 2014 at 04:39:38PM +0200, Thomas Petazzoni wrote:
> In commit 4ca2c04085a1caa903e92a5fc0da25362150aac2 ('ARM: orion5x:
> Move to ID based window creation'), the mach-orion5x code was changed
> to use the new mvebu-mbus API. However, in the process, a mistake was
> made on the crypto SRAM window target ID: it should have been 0x9
> (verified in the datasheet) and not 0x0.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: stable at vger.kernel.org
> ---
> This should be backported to stable all the way to v3.12.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-orion5x/common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/fixes with Sebastian's Ack.

thx,

Jason.

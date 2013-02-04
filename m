From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 3 Feb 2013 20:34:08 -0500
Subject: [PATCH v2 2/2] ARM: kirkwood: fix to retain gbe MAC addresses
 for DT kernels
In-Reply-To: <1359577799-23351-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20130130183049.GR7717@titan.lakedaemon.net>
 <1359577799-23351-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130204013408.GH14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 09:29:58PM +0100, Sebastian Hesselbarth wrote:
> The ethernet controller used on kirkwood looses its MAC address
> register contents when the corresponding clock is gated. As soon as
> mv643xx_eth is built as module, the clock gets gated and when loading
> the module, the MAC address is gone.
> 
> Proper DT support for the mv643xx_eth driver is expected soon, so we add
> a workaround to always enable ge0/ge1 clocks on kirkwood. This workaround
> is also already used on non-DT kirkwood kernels.
> 
> Reported-by: Simon Baatz <gmbnomis@gmail.com>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Changelog:
> [v2]
> - add note in patch description that MAC address is lost only when using
>   modular driver
> - add note in patch description that the workaround will be removed soon
> 
> Cc: Simon Baatz <gmbnomis@gmail.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-kirkwood/board-dt.c |   24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)

Applied to mvebu/fixes with Simon's Tested-by:

thx,

Jason.

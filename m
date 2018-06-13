From: horms@verge.net.au (Simon Horman)
Date: Wed, 13 Jun 2018 13:06:47 +0200
Subject: [PATCH V5] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <20180611121513.9673-1-marek.vasut+renesas@gmail.com>
References: <20180611121513.9673-1-marek.vasut+renesas@gmail.com>
Message-ID: <20180613110647.ygg66nu36pcf6kpn@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2018 at 02:15:13PM +0200, Marek Vasut wrote:
> Rather than hard-coding the quirk topology, which stopped scaling,
> parse the information from DT. The code looks for all compatible
> PMICs -- da9063 and da9210 -- and checks if their IRQ line is tied
> to the same pin. If so, the code sends a matching sequence to the
> PMIC to deassert the IRQ.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc at vger.kernel.org
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be> (on Koelsch)

Hi,

This looks fine to me but I will wait to see if there are other reviews
before applying.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

From: horms@verge.net.au (Simon Horman)
Date: Wed, 25 May 2016 10:01:51 +0900
Subject: [PATCH] ARM: shmobile: rcar-gen2: Use ICRAM1 for jump stub on
 all SoCs
In-Reply-To: <1463498133-23918-1-git-send-email-geert+renesas@glider.be>
References: <1463498133-23918-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160525010150.GD7292@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 05:15:33PM +0200, Geert Uytterhoeven wrote:
> Currently the different SoCs in the R-Car Gen2 family use different
> types of on-chip RAM for the jump stub:
>   - R-Car H2 uses Media RAM,
>   - R-Car M2-W uses another type of optional On-chip RAM, as it doesn't
>     have Media RAM,
>   - R-Car M2-N uses Inter Connect RAM in Magnus Damm's "ARM: shmobile:
>     r8a7793 boot address update".
> 
> As all R-Car Gen2 SoCs have 4 KiB of Inter Connect RAM, consolidate the
> code by always using that.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Tested on r8a7790/lager and r8a7791/koelsch.
> ---
>  arch/arm/mach-shmobile/pm-rcar-gen2.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Thanks, I have queued this up.

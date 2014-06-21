From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 20:47:59 -0400
Subject: [PATCH v2] ARM: mvebu: Don't apply the thermal quirk if the
 SoC revision is unknown
In-Reply-To: <1402425283-24989-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1402425283-24989-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140621004759.GW21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 03:34:43PM -0300, Ezequiel Garcia wrote:
> Currently, the thermal quirk is skipped only if the SoC revision is known to be
> one that does not need them, but if the SoC revision cannot be obtained, the
> quirk is applied assuming it's needed.
> 
> However, this quirk must be applied only we are sure the SoC needs it, for it
> breaks the thermal support if applied on a SoC that doesn't need it. The reason
> for this is that the quirk consists in changing the thermal devicetree
> compatible string and register offsets, to workaround a hardware bug in the
> early SoC revision.
> 
> Such changes are wrong if the SoC is a new revision and doesn't need
> the workaround. Therefore, this commit changes the behavior, by
> requiring the SoC revision to be known in order to peform a quirk.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Changes from v1:
>   * Add better commit log and a proper explanation in the code.
> 
>   * Dropped the I2C quirk modification, this fix is only applicable
>     for the thermal quirk.
> 
>  arch/arm/mach-mvebu/board-v7.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Applied to mvebu/soc

thx,

Jason.

From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 31 May 2016 11:30:34 +0200
Subject: [PATCH 1/3] mmc: fix mmc mode selection for HS-DDR and higher
In-Reply-To: <1464505484-3661-2-git-send-email-wens@csie.org>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
 <1464505484-3661-2-git-send-email-wens@csie.org>
Message-ID: <CAJKOXPcGCXJb5j2ShwL15GzKUXqR=z8p7TApORoHm9t-z1i6kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 29, 2016 at 9:04 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> When IS_ERR_VALUE was removed from the mmc core code, it was replaced
> with a simple not-zero check. This does not work, as the value checked
> is the return value for mmc_select_bus_width, which returns the set
> bit width on success. This made eMMC modes higher than HS-DDR unusable.
>
> Fix this by checking for a positive return value instead.
>
> Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mmc/core/mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Could you be so kind and pick it up as fast as possible for current
RC? Half of my boards fail (because they work on eMMC) so testing
patches before applying is limited.

Best regards,
Krzysztof

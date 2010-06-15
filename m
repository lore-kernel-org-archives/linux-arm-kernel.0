From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 Jun 2010 10:33:51 -0600
Subject: [PATCH 04/12] phylib: add a way to make PHY time stamps possible.
In-Reply-To: <27c0ad283f025c2bb71e7ceb71be07f969939429.1276615626.git.richard.cochran@omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<27c0ad283f025c2bb71e7ceb71be07f969939429.1276615626.git.richard.cochran@omicron.at>
Message-ID: <AANLkTimhAvu0_WuMCwnCrw9Rbcy6dKxvTlzepJm7ZDdR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 10:08 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> This patch adds a new networking option to allow hardware time stamps
> from PHY devices. Using PHY time stamps will still require adding two
> inline function calls to each MAC driver. The CONFIG option makes these
> calls safe to add, since the calls become NOOPs when the option is
> disabled.
>
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
> ---
> ?include/linux/phy.h ? ?| ? ?4 ++++
> ?include/linux/skbuff.h | ? 32 ++++++++++++++++++++++++++++++++
> ?net/Kconfig ? ? ? ? ? ?| ? 11 +++++++++++
> ?3 files changed, 47 insertions(+), 0 deletions(-)
>
[...]
> diff --git a/net/Kconfig b/net/Kconfig
> index 0d68b40..3fa7ae3 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -86,6 +86,17 @@ config NETWORK_SECMARK
> ? ? ? ? ?to nfmark, but designated for security purposes.
> ? ? ? ? ?If you are unsure how to answer this question, answer N.
>
> +config NETWORK_PHY_TIMESTAMPING
> + ? ? ? bool "Timestamping in PHY devices"
> + ? ? ? depends on EXPERIMENTAL
> + ? ? ? help
> + ? ? ? ? This allows timestamping of network packets by PHYs with
> + ? ? ? ? hardware timestamping capabilities. This option adds some
> + ? ? ? ? overhead in the transmit and receive paths. Note that this
> + ? ? ? ? option also requires support in the MAC driver.

Some overhead?  At a brief glance of the series it looks like it could
add a lot of overhead, but I'm not fully clear on what the full
process is.  Can you describe how the hardware timestamping works?  I
could use an overview of what the kernel has to do.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

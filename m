From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 11 Sep 2014 23:04:43 +0200
Subject: [PATCH] pinctrl: berlin: fix the dt_free_map function
In-Reply-To: <1410340551-24023-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1410340551-24023-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <54120E6B.4090704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2014 11:15 AM, Antoine Tenart wrote:
> The berlin_pinctrl_dt_free_map function tries to free memory
> allocated and handled by the of subsystem. This is wrong and
> already handled by pinctrl_dt_free_maps() which calls
> of_node_put().
> 
> This patch fixes the Berlin pinctrl way of freeing its maps,
> avoiding a kernel BUG(), by using the common
> pinctrl_utils_dt_free_map function instead.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/pinctrl/berlin/berlin.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)

I like the diffstat :)

I am very short on time, so if it works for you, I am fine with it.

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Sebastian

From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 8 Sep 2016 08:40:51 -0500
Subject: [PATCH v8 03/16] of/numa: add nid check for memory block
In-Reply-To: <1472712907-12700-4-git-send-email-thunder.leizhen@huawei.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
 <1472712907-12700-4-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <CAL_JsqK6P86F=AJjC2J6W4NOFXavb4e-OR_dmc4iofUNCJGrJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 1:54 AM, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> If the numa-id which was configured in memory@ devicetree node is greater
> than MAX_NUMNODES, we should report a warning. We have done this for cpus
> and distance-map dt nodes, this patch help them to be consistent.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/of/of_numa.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> index 7b3fbdc..c1bd62c 100644
> --- a/drivers/of/of_numa.c
> +++ b/drivers/of/of_numa.c
> @@ -75,6 +75,11 @@ static int __init of_numa_parse_memory_nodes(void)
>                          */
>                         continue;
>
> +               if (nid >= MAX_NUMNODES) {
> +                       pr_warn("NUMA: Node id %u exceeds maximum value\n", nid);

Really using pr_fmt should come first so you're not changing this
line. But not worth respinning for that:

Acked-by: Rob Herring <robh@kernel.org>

Rob

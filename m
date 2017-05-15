From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 15 May 2017 11:47:01 -0600
Subject: [PATCH 3/3] coresight: etb10: Improve a size determination in
 etb_alloc_buffer()
In-Reply-To: <b8ed57f7-cdcf-9b35-4fdd-8833db008ff0@users.sourceforge.net>
References: <5d5cd752-f2f2-b511-6b1e-daf5bf1bc522@users.sourceforge.net>
 <b8ed57f7-cdcf-9b35-4fdd-8833db008ff0@users.sourceforge.net>
Message-ID: <CANLsYkwxkXZ5t5L1_=2e9FLdkwOg7KUT=u2o-KeEfH8QYOfStA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2017 at 12:53, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 12 May 2017 20:36:03 +0200
>
> Replace the specification of a data structure by a pointer dereference
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index d5b96423e1a5..7096c4562e15 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -278,8 +278,7 @@ static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
>         if (cpu == -1)
>                 cpu = smp_processor_id();
>         node = cpu_to_node(cpu);
> -
> -       buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
> +       buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, node);

I'm fine with this change but if it's going to happen, it has to be in
all the coresight drivers and not just this one - please respin with
all instances fixed.  One patch per driver would be much appreciated.

Thanks,
Mathieu


>         if (!buf)
>                 return NULL;
>
> --
> 2.12.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

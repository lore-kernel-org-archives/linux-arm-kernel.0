From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 15 Oct 2012 10:35:04 +0300
Subject: [PATCH V2 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <CAKohpo=20mwje+9AVgs7b-_DshyRO2DZ=Nacjm7vFAhed=Wkqg@mail.gmail.com>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350051925.git.viresh.kumar@linaro.org>
 <9688d98010716880c1bbd966ead312c446282204.1350051925.git.viresh.kumar@linaro.org>
 <1350053897.10584.172.camel@smile>
 <CAKohpo=20mwje+9AVgs7b-_DshyRO2DZ=Nacjm7vFAhed=Wkqg@mail.gmail.com>
Message-ID: <1350286504.10584.176.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-10-15 at 08:59 +0530, Viresh Kumar wrote: 
> On 12 October 2012 20:28, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >> +     if (last_dw) {
> >> +             if ((last_bus_id == param) && (last_dw == dw))
> >> +                     return false;
> >> +     }
> > Just came to my mind.
> > dw can't be NULL, can't it?
> > Then
> > if (last_dw) {
> > ...
> > }
> > is unneeded.
> 
> Fixup for this:
> 
> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
> index d72c26f..764c159 100644
> --- a/drivers/dma/dw_dmac.c
> +++ b/drivers/dma/dw_dmac.c
> @@ -1196,11 +1196,8 @@ bool dw_dma_generic_filter(struct dma_chan
> *chan, void *param)
>          * failure. If dw and param are same, i.e. trying on same dw with
>          * different channel, return false.
>          */
> -       if (last_dw) {
> -               if ((last_bus_id == param) && (last_dw == dw))
> -                       return false;
> -       }
> -
> +       if ((last_dw == dw) && (last_bus_id == param))
> +               return false;
>         /*
>          * Return true:
>          * - If dw_dma's platform data is not filled with slave info, then all
Good.
So, have my 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> 

for this patch.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

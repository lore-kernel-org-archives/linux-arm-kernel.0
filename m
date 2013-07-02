From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 02 Jul 2013 10:20:00 -0700
Subject: [PATCH] USB: OHCI: make ohci-da8xx a separate driver
In-Reply-To: <CAJFYCKErW5hvgBvKiywHmf0eBYOix8Fkn9vQFa-TKHA63hX7aQ@mail.gmail.com>
References: <1372765019-7191-1-git-send-email-manjunath.goudar@linaro.org>
 <51D2E8A0.1080102@cogentembedded.com>
 <CAJFYCKErW5hvgBvKiywHmf0eBYOix8Fkn9vQFa-TKHA63hX7aQ@mail.gmail.com>
Message-ID: <51D30BC0.9090108@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2013 08:14 AM, Manjunath Goudar wrote:
> 
> 
> On 2 July 2013 20:20, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com
> <mailto:sergei.shtylyov@cogentembedded.com>> wrote:
> 
>     Hello.
> 
> 
>     On 02-07-2013 15:36, Manjunath Goudar wrote:
> 
>         Separate the Davinci OHCI host controller driver from ohci-hcd
>         host code so that it can be built as a separate driver module.
>         This work is part of enabling multi-platform kernels on ARM;
>         it would be nice to have in 3.11.
> 
> 
>         One preexisting error:
>         "da8xx_syscfg0_base" [drivers/usb/host/ohci-da8xx.__ko] undefined!
> 
> 
>         Fixed eventually using below modification:
>         added EXPORT_SYMBOL_GPL(da8xx___syscfg0_base) in
>         arch/arm/mach-davinci/devices-__da8xx.c.
> 
> 
>        And you managed to get this fix into the DaVinci tree? I tried it
>     long ago and it was refused by then DaVinci maintainer Kevin Hilman.
> 
> 
> Yes I saw your patch that is what I mentioned in patch description.
> We will wait for DaVinci maintainer response,what he will suggest. 

Note that Sekhar Nori (now Cc'd) is the primary maintainer of davinci,
and I'll defer the final decision to him.  However, the mach-davinci
change is not in this patch, so I'm not sure exactly how it relates
here, since that problem exists independently of this patch.

That being said, I will NAK the above EXPORT_SYMBOL change in
mach-davinci code because passing data between platform code and drivers
via global variables is still a bad idea.  Some helper accessor
functions will need to be created to abstract those low-level accesses.

>         Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org
>         <mailto:manjunath.goudar@linaro.org>>
>         Cc: Arnd Bergmann <arnd at arndb.de <mailto:arnd@arndb.de>>
>         Cc: Alan Stern <stern@rowland.harvard.edu
>         <mailto:stern@rowland.harvard.edu>>
>         Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com
>         <mailto:sshtylyov@ru.mvista.com>>
>         Cc: Kevin Hilman <kjh at hilman.org <mailto:kjh@hilman.org>>

Also, please khilman at linaro.org instead of my personal address.  Thanks,

Kevin

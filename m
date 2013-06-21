From: agnel.joel@gmail.com (Joel A Fernandes)
Date: Fri, 21 Jun 2013 16:53:57 -0500
Subject: [PATCH v12 05/11] edma: config: Enable config options for EDMA
In-Reply-To: <201306212044.26677.arnd@arndb.de>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <201306211632.12577.arnd@arndb.de>
 <CAD=GYpbhBAaSkMtcJaPtVpWar7AcW37QpAk3A0qgwX6G5PDoZg@mail.gmail.com>
 <201306212044.26677.arnd@arndb.de>
Message-ID: <CAD=GYpY4koXd9f6_ijQfDHsiULD4d53cdu=9X421WXSAit_YQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Jun 21, 2013 at 1:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 21 June 2013, Joel A Fernandes wrote:
>> I think we are talking about different things, I agree the 'select
>> DMADEVICES' can be dropped but lets please keep the default y option
>> (not adding new select statements, just saying that if someone select
>> DMADEVICES in menuconfig and if they're ARCH_OMAP=1 , then default to
>> EDMA). This will simply allow people to have a default. Thanks.
>
> Yes, that's ok.

Ok, thanks. I will follow up with a patch in my next submissions that builds it.

Perhaps a:
default y if 'ARCH_OMAP2PLUS'

and leave the existing as it is...
default n if  'ARCH_DAVINCI || ARCH_OMAP1 || ARCH_OMAP2'

would make most sense to me. Basically EDMA is seen on current and all
new OMAP2PLUS.

>
> config TI_EDMA
>         tristate "TI EDMA support"
>         default m if 'ARCH_DAVINCI || ARCH_OMAP1 || ARCH_OMAP2
>         select DMA_ENGINE
>         select DMA_VIRTUAL_CHANNELS



MMC depends on EDMA specially on AM33xx there's no PIO mode AFAIK. The
'm' option will require some initramfs to load the module when needing
to MMC boot, I suggest lets leave it as y.

Thanks,
Joel

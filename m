From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Sat, 21 Jun 2014 22:53:14 +0530
Subject: [PATCH 1/3 v5] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <20140621095149.GY5099@sirena.org.uk>
References: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
 <CAD=FV=Ua+P0CBAfNj4SWWMWRKcEFdmh=akwy1-ZWoGOt2P9=cQ@mail.gmail.com>
 <20140621095149.GY5099@sirena.org.uk>
Message-ID: <CAHfPSqCvHRMxPAVgRDrP-BSwuwJRP5O8Z+xy5Xot8t8mASNyAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 21 June 2014 15:21, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jun 20, 2014 at 02:18:08PM -0700, Doug Anderson wrote:
>
>> Is one of you two planning to apply (parts 1 and 2)?  I know that
>> Kukjin needs to handle the part 3 (the .dts files)...
>
>> Ideally it seems like it could go to 3.16 since it is a bugfix...
>
> Don't nag, it just means yet more mail to look at which makes things
> worse not better.  Given all the problems the DT code for this driver
> has I need to review carefully, and the fact that this has got to v5
> before I had a chance to look at it sets off alarm bells too.

The revisions were pretty quick
v1 to v2 : Updated DT Documentation for the change
v2 to v3 : use spi->cs_gpio in the driver
v3 to v4 : use gpio_is_valid() instead of using sdd->cs_gpio (local variable,
              also remove sdd->cs_gpio)
v4 to v5 : Added Acked-by and Revewied-by from Javier and Rob Herring

Major discussion in this thread was about keeping the old DT bindings
to support legacy or move on with the new bindings.

Tomasz Figa, Javier Martinez Canillas, Doug Anderson and
Rob Herring agreed with the latter.

Kindly review and let us know your comments.

Thanks
>
> There's a couple of months to get bug fixes in yet.



-- 
Shine bright,
(: Nav :)

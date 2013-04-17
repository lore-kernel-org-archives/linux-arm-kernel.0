From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Apr 2013 17:21:25 -0300
Subject: [PATCH] ARM: mach-imx6q: Remove code for setting up cko clock
In-Reply-To: <20130417195744.GX1906@pengutronix.de>
References: <1366224182-29285-1-git-send-email-festevam@gmail.com>
 <20130417195744.GX1906@pengutronix.de>
Message-ID: <CAOMZO5AynVOfSq_duGrAkaUtwyx1XjGQQY4558b4GOoMqa7TiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Wed, Apr 17, 2013 at 4:57 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Apr 17, 2013 at 03:43:02PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Let the bootloader setup the cko clock that drives the audio codec.
>>
>
> I really don't like such stuff. Where is documented what's expected from
> the bootloader? Which versions of which bootloader do implement this?

As far as I know such documentation does not exist. It would be nice
to have it, especially now that
we are recently moving some ARM errata stuff out of the multi plaform kernel.

I sent patches today for enabling CLKO for sabrelite in Barebox and U-boot.

> The code you remove is not particularly nice, but just removing it is no
> solution to the problem.

Please let me know what is your preferred solution then.

There was some discussion here:
https://patchwork.kernel.org/patch/2303011/

,but I didn't see this come into any conclusion of what is the
preferred way to handle this.

>
>> This simplifies a lot the code and when a new board needs to add audio support,
>> it will not have to add all this amount of code again.
>
> It shouldn't be necessary to duplicate the code for each board.

Yes, some code could be factored out, but every time we need to add
audio support for a new board we would need to keep polluting
arch/arm/mach-imx/mach-imx6q.c with things like:

if (of_machine_is_compatible("fsl,imx6q-xxx"))
    cko_setup()

Regards,

Fabio Estevam

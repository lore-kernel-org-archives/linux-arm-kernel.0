From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Apr 2013 09:54:39 +0200
Subject: [PATCH] gpio/omap: ensure gpio context is initialised
In-Reply-To: <51709499.8030208@ti.com>
References: <1366230707-32681-1-git-send-email-jon-hunter@ti.com>
 <871ua734mv.fsf@linaro.org> <51707D7C.1050600@ti.com>
 <5170911C.6010507@ti.com> <51709499.8030208@ti.com>
Message-ID: <CACRpkdZ=xdOnVVxEdTALJN-xpsoKGJufirV2EJCbJtGTEmjdVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 2:49 AM, Jon Hunter <jon-hunter@ti.com> wrote:

> From d02ef7b7dfcf8e13bf019aedfdecb38ca3c6749f Mon Sep 17 00:00:00 2001
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Mon, 15 Apr 2013 13:06:54 -0500
> Subject: [PATCH] gpio/omap: ensure gpio context is initialised
>
> Commit a2797be (gpio/omap: force restore if context loss is not
> detectable) broke gpio support for OMAP when booting with device-tree
> because a restore of the gpio context being performed without ever
> initialising the gpio context. In other words, the context restored was
> bad.
>
> This problem could also occur in the non device-tree case, however, it
> is much less likely because when booting without device-tree we can
> detect context loss via a platform specific API and so context restore
> is performed less often.
>
> Nevertheless we should ensure that the gpio context is initialised
> on the first pm-runtime resume for gpio banks that could lose their
> state regardless of whether we are booting with device-tree or not.
>
> The context loss count was being initialised on the first pm-runtime
> suspend following a resume, by populating the get_count_loss_count()
> function pointer after the first pm-runtime resume. To make the code
> more readable and logical, initialise the context loss count on the
> first pm-runtime resume if the context is not yet valid.
>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Applied this version with Santosh's and Kevin's ACKs and
Tony's Tested-by, thanks!

Yours,
Linus Walleij

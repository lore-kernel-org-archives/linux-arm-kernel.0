From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 10 Jul 2017 09:40:46 +0200
Subject: [RESEND PATCH v6 0/8] mfd: Add OF device table to I2C drivers
 that are missing it
In-Reply-To: <20170615184928.12007-1-javier@dowhile0.org>
References: <20170615184928.12007-1-javier@dowhile0.org>
Message-ID: <CABxcv=k8g8c3KmLK+ZqQiG+-+j2Y=FuRpadQ=xguXG5qGGWwhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

On Thu, Jun 15, 2017 at 8:49 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
>
> This series add OF device ID tables to mfd I2C drivers whose devices are
> either used in Device Tree source files or are listed in binding docs as
> a compatible string.
>
> That's done because the plan is to change the I2C core to report proper OF
> modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
> a device was registered via DT or using the legacy platform data mechanism.
>
> So these patches will make sure that mfd I2C drivers modules will continue
> to be autoloaded once the I2C core is changed to report proper OF modalias.
>
> Users didn't have a vendor prefix in the used compatible strings, but since
> there wasn't a DT binding document for these drivers, it can be said that
> were working for mere luck and so this series fixes the users and add a DT
> binding doc for the drivers.
>
> Most patches can be applied independently, with the exception of patches
> 2 to 4 that should be applied in the same tree to keep bisect-ability. I
> suggest these to go through the MFD subsystem tree.
>
> Best regards,
> Javier
>

Are you planning to pick this series? It has been in the list for
months and were resent many times...

Best regards,
Javier

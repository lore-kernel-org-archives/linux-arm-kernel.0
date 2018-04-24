From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 24 Apr 2018 19:24:33 +0300
Subject: [RESEND PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
In-Reply-To: <20180424074459.7215-1-k.marinushkin@gmail.com>
References: <20180424071618.GB17825@kroah.com>
 <20180424074459.7215-1-k.marinushkin@gmail.com>
Message-ID: <CAHp75VecPW_v0r+L01jWubASMAQ4iCoUX4G3pcyfzn9Gf21CtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 10:44 AM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:
> In the current implementation, vchi_instance is inited during the first
> call of bcm2835_audio_open_connection(), and is never freed. It causes a
> memory leak when the module `snd_bcm2835` is removed.


> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devel at driverdev.osuosl.org
> Cc: linux-kernel at vger.kernel.org

AFAIR I gave you a tag and you again missed it.
Before sending anything just check twice if all prerequisites are fulfilled.

And yes, kbuild bot is right. You need to return known value.

-- 
With Best Regards,
Andy Shevchenko

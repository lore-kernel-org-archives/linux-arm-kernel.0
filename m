From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 24 Sep 2009 03:03:17 +0800
Subject: Problem with s3c24xx pwm driver
In-Reply-To: <200909231824.11671.anarsoul@gmail.com>
References: <200909231824.11671.anarsoul@gmail.com>
Message-ID: <f17812d70909231203v198aafberd00ce35bd7ba7f6b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2009 at 11:24 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> Hi,
>
> I'm encountering very strange problem with s3c24xx pwm driver. I'm using it
> with pwm-bl driver. When backlight level is 0, pwm-bl calls pwm_config(0,
> period); pwm_disable(), otherwise it calls pwm_config(duty, period);
> pwm_enable().
>
> Problem is that after pwm was disabled, it can't be enabled with
> pwm_config(duty, period); pwm_enable() for some (but not all) _valid_
> duty/period combinations.
>
> pwm-bl works fine if pwm_disable() call is commented out.
>
> Does anybody know how to solve this problem? Any suggestions?
>

Sounds like there are cases where the pwm_enable() and pwm_disable()
are not paired? You may want to print out the reference count each time
to see if this is true.

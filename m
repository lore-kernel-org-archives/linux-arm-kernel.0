From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 2 Jun 2013 19:30:53 -0700
Subject: [PATCHv3 0/3] Add G762/G763 PWM fan controller
In-Reply-To: <cover.1370202835.git.arno@natisbad.org>
References: <cover.1370202835.git.arno@natisbad.org>
Message-ID: <20130603023053.GA11723@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 10:14:05PM +0200, Arnaud Ebalard wrote:
> Hi,
> 
> This series adds support for GMT G762/G763. This work is based on a
> basic version for 2.6.31 kernel developed Olivier Mouchet for LaCie
> NAS. Updates have been performed to run on recent kernels. Support has
> been completed and additional features added: ability to configure
> various characteristics from .dts file, better initialization, alarms
> and error reporting support, gear mode, polarity, fan pulse per
> revolution, fan startup voltage control. The following detailed
> datasheet has been used as a basis for this work:
> 
>   http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf
> 
> The patch was developed for and tested against the GMT G762 fan
> controller used in a Netgear ReadyNAS Duo v2 (kirkwood 88F6282-based
> NAS). This is the main reason for the device tree bindings provided in
> first patch. The driver also support init via board file. The patches
> are against current ARM tree; tell me if you need me to rebase it
> against something else. Patch 2 and 3 provides documentation for the
> driver and DT bindings, respectively.
> 
> As discussed in a previous email:
> 
>  - A macro is defined to pass values of platform data structure in
>    board setup files. If one has a better approach ...
>  - This v3 still has support for pwm1 sysfs entry in closed-loop mode.
>    Guenter, if you still think it is a bad idea, I will change that
>    in v4.
> 

If you want me to accept your code, I would suggest to change it such that
pwm1 sets the FAN_SET_OUT register, and fan1_target sets the SET_CNT register,
both unconditionally. Redefining the pwm1 attribute to set the fan target
speed instead of a pwm / voltage value is not acceptable.

> note: this should not be an issue but this v3 is based on
>       jcooper/mvebu/fixes branch. 
> 
I don't know about this branch/repository. If there are hwmon fixes in it,
they should be submitted to the lm-sensors mailing list.

Thanks,
Guenter

From: mine260309@gmail.com (Lei YU)
Date: Wed, 9 May 2018 11:50:34 +0800
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Use 24MHz clock
In-Reply-To: <c5770e4a-9445-d4ef-cc1f-a7a84599c4a1@roeck-us.net>
References: <1525772367-20627-1-git-send-email-mine260309@gmail.com>
 <8a801894-4293-d2e8-4673-3d9ff5c2a5bb@roeck-us.net>
 <CAARXrtmO=wsPK6bfO0E7fvAkqEJUV1kQSYK1gWXkUhmKytq42A@mail.gmail.com>
 <c5770e4a-9445-d4ef-cc1f-a7a84599c4a1@roeck-us.net>
Message-ID: <CAARXrt=ZA7sz_CvNUxHRvie3YfErU-5d5ewHry=mgxb6Uz-+TA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2018 at 11:43 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>
> I am not going to accept this change, period. This is not one, it is five
> steps
> backward. If "aspeed_set_clock_source(priv->regmap, 0)" changes the clock
> speed,
> or the clock source, read it later, and attach to the correct clock. If that
> doesn't work, fix the problem in the clock subsystem. Hacking the driver is
> just
> plain wrong.
>
> Also, if the idea in DT is to provide a different clock to the watchdog on
> purpose,
> maybe the call to "aspeed_set_clock_source(priv->regmap, 0)" is wrong.

Exactly!
My first change (not sent to mailing list) is to remove the call of
"aspeed_set_clock_source(priv->regmap, 0)", instead, checking the clock
source, and use either 24M or the memory controller clock.
But that make things a bit more complicated and Aspeed suggests to use 24M
clock. So I sent this simplified change.

It's OK to not accept this change, the fix in DT will fix the issue as well.
Please drop this.
Thanks!

From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 29 Jun 2017 14:49:22 -0700
Subject: [PATCH] pinctrl: qcom: qdf2xxx: expose only some GPIO pins
In-Reply-To: <d5cb17b6-083a-58a0-caa6-01ee06ff1fd4@codeaurora.org>
References: <1498164850-4738-1-git-send-email-timur@codeaurora.org>
 <CACRpkdZeDjS_g27=1e7uCmFpjnqX+sDSu5G2VAuwFr_GJW1mug@mail.gmail.com>
 <d5cb17b6-083a-58a0-caa6-01ee06ff1fd4@codeaurora.org>
Message-ID: <20170629214922.GC18666@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 29 Jun 12:37 PDT 2017, Timur Tabi wrote:

> On 06/23/2017 07:33 AM, Linus Walleij wrote:
> > I think using "lsgpio" fron tools/gpio/lsgpio.c is better to inspect
> > the available GPIOs.
> > 
> > If you haven't tested the GPIO tools, please try it out.
> 
> Unfortunately, this tool isn't very useful:
> 

I believe you have to come up with a separate array of names and attach
that to the gpio_chip in msm_gpio_init() for the _gpio_ pins to have
names. The names we specify in the pin driver is only the name of the
pinctrl pin...

Regards,
Bjorn

> $ sudo ./lsgpio
> GPIO chip: gpiochip0, "QCOM8001:00", 150 GPIO lines
>         line  0: unnamed unused [output]
>         line  1: unnamed unused [output]
>         line  2: unnamed unused [output]
>         line  3: unnamed unused [output]
>         line  4: unnamed unused [output]
>         line  5: unnamed unused [output]
>         line  6: unnamed unused [output]
>         line  7: unnamed unused [output]
>         line  8: unnamed unused [output]
>         line  9: unnamed unused [output]
>         line 10: unnamed unused [output]
>         line 11: unnamed unused [output]
>         line 12: unnamed unused [output]
>         line 13: unnamed unused [output]
>         line 14: unnamed unused [output]
>         line 15: unnamed unused [output]
>         line 16: unnamed unused [output]
>         line 17: unnamed unused [output]
>         line 18: unnamed unused [output]
>         line 19: unnamed unused [output]
>         line 20: unnamed unused [output]
>         line 21: unnamed unused [output]
>         line 22: unnamed unused [output]
>         line 23: unnamed unused [output]
>         line 24: unnamed unused [output]
>         line 25: unnamed unused [output]
>         line 26: unnamed unused [output]
>         line 27: unnamed unused [output]
>         line 28: unnamed unused [output]
>         line 29: unnamed unused [output]
>         line 30: unnamed unused [output]
>         line 31: unnamed unused [output]
>         line 32: unnamed unused [output]
>         line 33: unnamed unused [output]
>         line 34: unnamed unused [output]
>         line 35: unnamed unused [output]
>         line 36: unnamed unused
>         line 37: unnamed "sysfs" [kernel]
>         line 38: unnamed unused
>         line 39: unnamed unused
>         line 40: unnamed unused [output]
> 	...
> 
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.

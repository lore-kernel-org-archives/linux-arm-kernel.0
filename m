From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 18 Feb 2014 15:20:49 -0300
Subject: PMIC driver prevents gpio-leds to work
Message-ID: <CAOMZO5D0fa0yzwQbNLG_=oJ_8_WBBqWBF=D9QzSwLwC0jh+deQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am running into the following issue on imx6sl-evk.dts:

- I can only get the user GPIO LED to work if I unselect the PFUZE100
PMIC driver

- This happens on linux-next as well as in the internal FSL kernel based on 3.10

With CONFIG_REGULATOR_PFUZE100=y then the LED blinks only once and
stops instead of blinking at the heartbeat rate.

Changing to CONFIG_REGULATOR_PFUZE100=n then the LED blinks normally.

I am not sure how the PMIC driver could interact and make the
gpio-leds driver to fail.

Any suggestions?

Thanks,

Fabio Estevam

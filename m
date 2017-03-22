From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Wed, 22 Mar 2017 11:21:01 +0100
Subject: [PATCH 4/6] gpio: gemini: rename to match Faraday IP
In-Reply-To: <CACRpkda0TpcUsEW6wiHzhueSckz_WTfbDgpixdgCNvodHDmpyw@mail.gmail.com>
References: <20170312232818.26304-1-linus.walleij@linaro.org>
 <20170312232818.26304-4-linus.walleij@linaro.org>
 <CACmBeS2OC6X_Rb5qaVEGMY4mPyHwnib-=pm-g=+73J6ZSRDgLw@mail.gmail.com>
 <CACRpkda0TpcUsEW6wiHzhueSckz_WTfbDgpixdgCNvodHDmpyw@mail.gmail.com>
Message-ID: <CACmBeS23APp1=+0Cypyx9OujhekUTF7w5QbwE_9zt_go3GdUPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 March 2017 at 09:42, Linus Walleij <linus.walleij@linaro.org> wrote:
> Nice! Have you tested my new GPIO character device tools from
> tools/gpio/* in the kernel tree?

I had not and thanks for pointing that out, lsgpio lists all available
gpios (though most of them are unnamed), and gpio-hammer successfully
toggled buzzer on/off.

uname -a
Linux zurkon 4.11.0-rc1-next-20170310-00004-gc63f3c2 #4466 PREEMPT Wed
Mar 22 11:05:28 CET 2017 armv4l GNU/Linux

./lsgpio
GPIO chip: gpiochip0, "FTGPIO010", 32 GPIO lines
        line  0: unnamed unused [output]
        line  1: unnamed unused [output]
        line  2: unnamed unused [output]
        line  3: unnamed unused [output]
        line  4: unnamed unused
        line  5: unnamed "rtc_sclk" [kernel output]
        line  6: unnamed "rtc_data" [kernel]
        line  7: unnamed "rtc_reset" [kernel output]
        line  8: unnamed unused
        line  9: unnamed unused
        line 10: unnamed unused
        line 11: unnamed unused [output]
        line 12: unnamed unused
        line 13: unnamed unused [output]
        line 14: unnamed unused
        line 15: unnamed unused [output]
        line 16: unnamed unused
        line 17: unnamed unused [output]
        line 18: unnamed unused
        line 19: unnamed unused
        line 20: unnamed unused
        line 21: unnamed unused
        line 22: unnamed unused
        line 23: unnamed unused
        line 24: unnamed unused [output]
        line 25: unnamed unused
        line 26: unnamed unused
        line 27: unnamed "ready-led" [kernel output active-low]
        line 28: unnamed unused
        line 29: unnamed unused
        line 30: unnamed unused
        line 31: unnamed unused [output]

./gpio-hammer -n gpiochip0 -o 24
Hammer lines [24] on gpiochip0, initial states: [0]
[|] [24: 1]

./gpio-hammer -n gpiochip0 -o 27
Failed to issue GET LINEHANDLE IOCTL (-16)


   Jonas

From: rogershimizu@gmail.com (Roger Shimizu)
Date: Thu, 21 Jan 2016 09:16:01 +0900
Subject: [PATCH v2 3/7] ARM: dts: kirkwood: gpio-leds fixes for
 linkstation ls-wxl/wsxl
In-Reply-To: <20160120171614.GP28750@lunn.ch>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-4-git-send-email-rogershimizu@gmail.com>
 <20160120171614.GP28750@lunn.ch>
Message-ID: <CAEQ9gEkH5zgRZdXg_jrXgXmu-7VcLETUr_insoFFqPGFYR20Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 2:16 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Thu, Jan 21, 2016 at 12:33:54AM +0900, Roger Shimizu wrote:
>> Make all leds initially to "off" state except power indicator, so pins below
>> change from active_low to active_high:
>
> So what happens when you echo 1 to /sys/class/led/lswxl:red:func/brightness ?
>
> 1 should turn the LED on, 0 off. This is what
> GPIO_ACTIVE_LOW/GPIO_ACTIVE_HIGH is about, and these are independent
> of the initial off/on state.

after reboot,
# cat /sys/class/leds/lswxl\:red\:func/brightness
0
# echo 1 > /sys/class/leds/lswxl\:red\:func/brightness

1st command shows the initial value is 0.
2nd command will turn the LED to on state.

I guess board will set the value to 0 when boot, so as
GPIO_ACTIVE_LOW/GPIO_ACTIVE_HIGH can change the initial state of LED.

Cheers,
Roger

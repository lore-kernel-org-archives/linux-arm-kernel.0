From: horms@verge.net.au (Simon Horman)
Date: Thu, 14 Nov 2013 15:27:37 +0900
Subject: [PATCH] ARM: shmobile: Enable DSW2 with gpio-keys on KZM9D
In-Reply-To: <20131114052204.GD22870@verge.net.au>
References: <20131113230345.21482.36997.sendpatchset@w520>
 <20131114052204.GD22870@verge.net.au>
Message-ID: <20131114062735.GF22870@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 02:22:06PM +0900, Simon Horman wrote:
> On Thu, Nov 14, 2013 at 08:03:45AM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Use the gpio-keys driver to support the 4 pins on the
> > dip switch DSW2 which is mounted on the KZM9D board.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Hi Magnus,
> 
> I have tried enabling the following on a config produced
> using the kzm9d_defconfig:
> 
> CONFIG_INPUT_KEYBOARD
> CONFIG_INPUT_EVDEV
> CONFIG_KEYBOARD_GPIO
> 
> But all I see so far in dmsg is:
> 
> # dmesg | grep gpio 
> platform gpio_keys.3: Driver gpio-keys requests probe deferral
> 
> I was expecting something more along the lines of:
> input: gpio-keys as /devices/platform/gpio-keys/input/input0
> 
> Could you give me some guidance on how to test this?

I now notice that I also need
"[PATCH 00/03] gpio: R-Car and EM GPIO update"

But with that applied I now see:

# dmesg  | grep gpio 
gpio-keys gpio_keys.3: Failed to request GPIO 14, error -517
platform gpio_keys.3: Driver gpio-keys requests probe deferral

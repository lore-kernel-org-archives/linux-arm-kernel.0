From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Dec 2015 14:10:31 +0100
Subject: [PATCH] gpio: zynq: Do PM initialization earlier to support gpio
 hogs
In-Reply-To: <fc67101afc0d10efbaeeb6bc3d881ab49e3f4671.1449745801.git.michal.simek@xilinx.com>
References: <fc67101afc0d10efbaeeb6bc3d881ab49e3f4671.1449745801.git.michal.simek@xilinx.com>
Message-ID: <CACRpkdYsOtzc_TnRA=CuvQMFNpgrMHhUvLu1kRQFynk5wLNz0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 12:10 PM, Michal Simek <michal.simek@xilinx.com> wrote:

> GPIO hogs registration is call at the end of gpiochip_add() function.
> Calling sequence is:
> gpiochip_add -> of_gpiochip_add -> of_gpiochip_scan_hogs ->
> gpiod_hog -> gpiochip_request_own_desc -> __gpiod_request ->
> chip->request -> zynq_gpio_request which calls pm_runtime_get_sync()
> which returns -13 because PM is not initialized yet.
>
> Initialize PM before gpiochip_add is called to fix this issue.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Patch applied!

Yours,
Linus Walleij

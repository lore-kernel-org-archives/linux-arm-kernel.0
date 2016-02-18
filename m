From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 18 Feb 2016 23:07:35 +0100
Subject: [PATCH 0/2] arm: lpc32xx: restart: add support for soft reset
In-Reply-To: <1455831324-8909-1-git-send-email-slemieux.tyco@gmail.com>
References: <1455831324-8909-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <CAGhQ9VwPc0RA0n8JmpcqJuV6SmdFZbBjgVCz5iExBA+z74LH_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 18 February 2016 at 22:35,  <slemieux.tyco@gmail.com> wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
>
> The LPC32xx provide the capability to perform a soft or hard reset;
> a soft reset will no reset the external peripheral
> (i.e. RESOUT_N output not asserted).
>
> The default behavior (i.e. hard reset) remain unchanged.
>
> Sylvain Lemieux (2):
>   arm: lpc32xx: restart: add support for soft reset
>   arm: lpc32xx: restart: support "cmd" from userspace
>
>  arch/arm/mach-lpc32xx/common.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)

Instead of adding more code to mach-lpc32xx could this code be moved
to the watchdog driver (pnx4008_wdt.c) ?
See register_restart_handler() and how it's used in other watchdog drivers.

Then maybe the restart hook in phy3250.c could be removed all together.


regards,
Joachim Eastwood

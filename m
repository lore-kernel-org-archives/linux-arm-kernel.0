From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Jan 2014 07:19:52 -0200
Subject: [PATCH v2 03/15] watchdog: orion: Use atomic access for shared
 registers
In-Reply-To: <1390295561-3466-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CAOMZO5BKjpkjQGOOAQ5fwmxhg1SYTmTq4Y9tUCZaDSQiosGYyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 7:12 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Since the timer control register is shared with the clocksource driver,
> use the recently introduced atomic_io_clear_set() to access such register.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/watchdog/orion_wdt.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index f7722a4..cf64510 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -61,8 +61,6 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
>
>  static int orion_wdt_start(struct watchdog_device *wdt_dev)
>  {
> -       u32 reg;
> -
>         spin_lock(&wdt_lock);

Shouldn't this spin_lock be dropped now?

Regards,

Fabio Estevam

From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 3 Dec 2012 10:13:38 +0800
Subject: [PATCH] [ARM] pxa/spitz: Disable usb port 1 and 3
In-Reply-To: <1354232481-32168-1-git-send-email-dromede@gmail.com>
References: <1354232481-32168-1-git-send-email-dromede@gmail.com>
Message-ID: <CAMPhdO88Ydx7ghWK=Brzg=xn8YmFKdCyE3QNw9FaeZY+qNT8dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The port could be not routed to external, but used internally. I cannot
remember the details of spitz as there isn't too much public detail around,
just want to make sure no other devices are connected to port 1 and 3.

On Fri, Nov 30, 2012 at 7:41 AM,  <dromede@gmail.com> wrote:
> From: Marko Katic <dromede.gmail.com>
>
> Spitz devices only have a single mini usb a/b plug
> connected to usb port 2.
> This patch disables ports 1 and 3 since they are not used.
>
> Signed-off-by: Marko Katic <dromede@gmail.com>
> ---
>  arch/arm/mach-pxa/spitz.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index 0f92264..4443540 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -651,7 +651,7 @@ static struct pxaohci_platform_data spitz_ohci_platform_data = {
>         .port_mode      = PMM_NPS_MODE,
>         .init           = spitz_ohci_init,
>         .exit           = spitz_ohci_exit,
> -       .flags          = ENABLE_PORT_ALL | NO_OC_PROTECTION,
> +       .flags          = ENABLE_PORT2 | NO_OC_PROTECTION,
>         .power_budget   = 150,
>  };
>
> --
> 1.7.10.4
>

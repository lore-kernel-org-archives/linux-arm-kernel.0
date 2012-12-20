From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 20 Dec 2012 09:18:43 -0200
Subject: 3.7 kernel hangs when doing scp
In-Reply-To: <CAOMZO5B5hv+oG+8fQYyFxRb=VLOiPmC8+0LhAFLOOzBY4z6PZA@mail.gmail.com>
References: <CAOMZO5Bc5stXXviuf3OL9vAHw+ER=GzzV1q=5Yr5q=AnfoGiGw@mail.gmail.com>
 <20121218024353.GA17118@kroah.com>
 <CAOMZO5DTB79e3W1_i2NLin7RWXVzraoysEGVLxv9_aoRS39D4Q@mail.gmail.com>
 <20121220043943.GA992@nchen-desktop>
 <CAOMZO5B1DyktHa0Vfb4+-H9bdxaoacas6ZCHEH0bDLuKiCB6hA@mail.gmail.com>
 <CAOMZO5B5hv+oG+8fQYyFxRb=VLOiPmC8+0LhAFLOOzBY4z6PZA@mail.gmail.com>
Message-ID: <CAOMZO5Dhasq11fyJj73_UcyVdoz-N0MAHBu0=PQUxRn42VOdkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 8:45 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Would this be the correct fix?
>
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -18,7 +18,7 @@ struct ci13xxx_platform_data {
>  #define CI13XXX_REGS_SHARED            BIT(0)
>  #define CI13XXX_REQUIRE_TRANSCEIVER    BIT(1)
>  #define CI13XXX_PULLUP_ON_VBUS         BIT(2)
> -#define CI13XXX_DISABLE_STREAMING      BIT(3)
> +#define CI13XXX_DISABLE_STREAMING      BIT(4)

Ops, these are just the platform data flags.

I will take a look on why the chipidea driver is not properly
disabling stream mode.

Regards,

Fabio Estevam

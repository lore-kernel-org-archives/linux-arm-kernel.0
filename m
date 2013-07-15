From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Jul 2013 13:08:23 -0300
Subject: [PATCH 19/22] Input: tsc2007: Add device tree support.
In-Reply-To: <1373900227-341-20-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-20-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5B169k+6f0G388xne4dUTNiEAb9Zpx1_XJH8TMv5FTLLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 11:57 AM, Denis Carikli <denis@eukrea.com> wrote:
> Set the of_match_table for this driver so that devices can be described
>   in the device tree.
>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../bindings/input/touchscreen/tsc2007.txt         |   44 +++++
>  drivers/input/touchscreen/tsc2007.c                |  205 ++++++++++++++++----

You should have Cc'ed linux-input list and its maintainer Dmitry
Torokhov <dmitry.torokhov@gmail.com>

> +static int tsc2007_get_pendown_state_dt(struct tsc2007  *ts)
> +{
> +       if (ts->gpio >= 0)

What about
if (gpio_is_valid(ts->gpio)) instead?

From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 24 Jul 2014 21:19:18 +0800
Subject: [PATCH 2/2] pinctrl: sunxi: number gpio ranges starting from 0
In-Reply-To: <1405358677-23657-3-git-send-email-wens@csie.org>
References: <1405358677-23657-1-git-send-email-wens@csie.org>
 <1405358677-23657-3-git-send-email-wens@csie.org>
Message-ID: <CAGb2v64mZjmB+ftQ7yM5LzhUyPVGtCXq6DOUQ-pumLb73_DYLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Tue, Jul 15, 2014 at 1:24 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> The pinctrl-sunxi driver originally used the pin number as the gpio
> range offset. This resulted in large, bogus gpio numbers for the
> new sun6i-a31-r pinctrl devices.
>
> This patch makes the driver number the gpios ranges starting from an
> offset of 0, by subtracting the pin_base number from the pin number.
> This also makes the system-wide gpio number match the pin number.
>
> Tested on sun8i with sysfs exported gpios.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>
> This patch also changes the GPIO bindings for R_PIO:
>
>     gpios = <&r_pio B N flag>;
>
> Where B originally was the pinbank label (L or M) counted from A,
> with this patch it becomes (L or M) counted from its pinbank base (L).
>
> Thus
>
>     gpios = <&r_pio 10 11 0>; /* PL11 */
>
> becomes
>
>     gpios = <&r_pio 0 11 0>; /* PL11 */
>
> IMO this is correct, as the binding shows the bank offset and pin offset
> within the bank for the GPIO controller. But I'm worried it might be a
> bit confusing.

I see you Acked this patch, but also in your reply to my cover letter,
you mentioned that you want absolute pin numbers matching the datasheets.
What about the GPIO DT bindings, as I explained above?

Just double checking. Thanks.

ChenYu

From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Mon, 22 Jun 2015 16:33:03 +0200
Subject: [RESEND PATCH 3/4] leds: leds-ns2: handle can_sleep GPIOs
In-Reply-To: <1434640650-28086-4-git-send-email-simon.guinot@sequanux.org>
References: <1434640650-28086-1-git-send-email-simon.guinot@sequanux.org>
 <1434640650-28086-4-git-send-email-simon.guinot@sequanux.org>
Message-ID: <55881C9F.5060608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On 06/18/2015 05:17 PM, Simon Guinot wrote:
> On the board n090401 (Seagate NAS 4-Bay), some of the LEDs are handled
> by the leds-ns2 driver. This LEDs are connected to an I2C GPIO expander
> (PCA95554PW) which means that GPIO access may sleep. This patch makes
> leds-ns2 compatible with such GPIOs by using the *_cansleep() variant of
> the GPIO functions. As a drawback this functions can't be used safely in
> a timer context (with the timer LED trigger for example). To fix this
> issue, a workqueue mechanism (copied from the leds-gpio driver) is used.
>
> Note that this patch also updates slightly the ns2_led_sata_store
> function. The LED state is now retrieved from cached values instead of
> reading the GPIOs previously. This prevents ns2_led_sata_store from
> working with a stale LED state (which may happen when a delayed work
> is pending).
>
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
> ---
>   drivers/leds/leds-ns2.c | 56 ++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 42 insertions(+), 14 deletions(-)

Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best Regards,
Jacek Anaszewski

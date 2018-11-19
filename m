From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 20 Nov 2018 02:37:41 +0530
Subject: [PATCH 3/3] ARM: davinci: fix da850-evm boot in legacy mode
In-Reply-To: <20181113135051.15308-4-brgl@bgdev.pl>
References: <20181113135051.15308-1-brgl@bgdev.pl>
 <20181113135051.15308-4-brgl@bgdev.pl>
Message-ID: <fc80e910-40fa-bb9c-e3ea-f53387bc055a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,


On 13/11/18 7:20 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
> automatic base selection") broke the network support in legacy boot
> mode for da850-evm since we can no longer request the MDIO clock GPIO.
> 
> We now have the option to specify the GPIO base manually for davinci,
> so add the relevant fields to platform data.
> 
> Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
> Cc: stable at vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>


> ---
>  arch/arm/mach-davinci/da850.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Similar changes are needed for other 5 DaVinci SoCs too. Can you do
those in this patch itself?

Thanks,
Sekhar

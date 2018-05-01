From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 14:55:50 +0530
Subject: [PATCH 01/12] mtd: nand: davinci: store the core chipselect
 number in platform data
In-Reply-To: <20180430082453.8091-2-brgl@bgdev.pl>
References: <20180430082453.8091-1-brgl@bgdev.pl>
 <20180430082453.8091-2-brgl@bgdev.pl>
Message-ID: <3dccc5af-2df1-8374-e4e8-0a8b9ea1ae99@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 April 2018 01:54 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We have the 'ti,davinci-chipselect' property in the device tree, but
> when using platform data the driver silently uses the id field of
> struct platform_device as the chipselect. This is confusing and we
> almost broke the nand support again recently after converting the
> platform to common clock framework (which changed the device id in the
> clock lookup - the problem is gone now that we no longer acquire the
> clock in the nand driver.
> 
> This patch adds a new filed - core_chipsel - to the platform_data.

s/filed/field

> Subsequent patches will convert the platforms to using this new field.

Can you add a comment for this new field too, like how we have for most
other fields?

Curious on what 'core' in core_chipsel means. Something to do with
chip-select offset we have on DA850?

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks,
Sekhar

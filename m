From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 4 Feb 2015 14:44:56 +0100
Subject: [PATCH v3 03/20] power_supply: Add API for safe access of power
 supply function attrs
In-Reply-To: <1422629278-12202-4-git-send-email-k.kozlowski@samsung.com>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150204134456.GA8312@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2015-01-30 15:47:41, Krzysztof Kozlowski wrote:
> Add simple wrappers for accessing power supply's function attributes:
>  - get_property -> power_supply_get_property
>  - set_property -> power_supply_set_property
>  - property_is_writeable -> power_supply_property_is_writeable
>  - external_power_changed -> power_supply_external_power_changed
> 
> This API along with atomic usage counter adds a safe way of accessing a
> power supply from another driver. If power supply is unregistered after
> obtaining reference to it by some driver, then the API wrappers won't be
> executed in invalid (freed) context.
> 
> Next patch changing the ownership of power supply class is still needed
> to fully fix race conditions in accessing freed power supply.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>

For 1-3: Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

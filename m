From: broonie@kernel.org (Mark Brown)
Date: Sat, 12 Dec 2015 23:01:50 +0000
Subject: [PATCH v2 2/4] ASoC: sun4i-codec: Add support for PA gpio pin
In-Reply-To: <1449859439-30875-2-git-send-email-hdegoede@redhat.com>
References: <1449859439-30875-1-git-send-email-hdegoede@redhat.com>
 <1449859439-30875-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20151212230150.GH579@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 07:43:57PM +0100, Hans de Goede wrote:

> +		gpiod_set_value_cansleep(scodec->gpio_pa,
> +					 !!SND_SOC_DAPM_EVENT_ON(event));

Why the double negation here?  The macro is already supposed to give you
a boolean and gpiod_set_value_cansleep() ought to cope with a C logic
value.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151212/59f039d3/attachment.sig>

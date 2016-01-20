From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Jan 2016 10:45:55 +0000
Subject: [PATCH] ASoC: avoid unused variable warning for rt5659_acpi_match
In-Reply-To: <2238845.aZnycJVYKR@wuerfel>
References: <2238845.aZnycJVYKR@wuerfel>
Message-ID: <20160120104555.GY6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 11:43:48AM +0100, Arnd Bergmann wrote:
> The newly added rt5659 codec driver unconditionally defines an
> ACPI device match table but then uses ACPI_PTR() to remove the
> only reference to it, so we get a harmless build warning:

> sound/soc/codecs/rt5659.c:4200:30: warning: 'rt5659_acpi_match' defined but not used [-Wunused-variable]
>  static struct acpi_device_id rt5659_acpi_match[] = {

> This removes the ACPI_PTR() to avoid the warning.

Why is this a better fix than conditionally defining the table?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160120/ce9df5db/attachment.sig>

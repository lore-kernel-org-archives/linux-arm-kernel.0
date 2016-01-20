From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jan 2016 11:58:51 +0100
Subject: [PATCH] ASoC: avoid unused variable warning for rt5659_acpi_match
In-Reply-To: <20160120104555.GY6588@sirena.org.uk>
References: <2238845.aZnycJVYKR@wuerfel> <20160120104555.GY6588@sirena.org.uk>
Message-ID: <20191003.vNJkcIvuCq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 January 2016 10:45:55 Mark Brown wrote:
> On Wed, Jan 20, 2016 at 11:43:48AM +0100, Arnd Bergmann wrote:
> > The newly added rt5659 codec driver unconditionally defines an
> > ACPI device match table but then uses ACPI_PTR() to remove the
> > only reference to it, so we get a harmless build warning:
> 
> > sound/soc/codecs/rt5659.c:4200:30: warning: 'rt5659_acpi_match' defined but not used [-Wunused-variable]
> >  static struct acpi_device_id rt5659_acpi_match[] = {
> 
> > This removes the ACPI_PTR() to avoid the warning.
> 
> Why is this a better fix than conditionally defining the table?

I'm not overly fond of adding #ifdef if it can be avoided. In this case,
both approaches seemed reasonable (either add an #ifdef or waste a couple
of bytes), and I picked at random. I'll send you the alternative as well,
please apply whichever one you prefer.

	Arnd

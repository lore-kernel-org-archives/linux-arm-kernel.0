From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 9 Aug 2012 11:19:47 +0100
Subject: [PATCH] efikamx: reintroduce Genesi Efika MX Smarttop via
 device tree
In-Reply-To: <1344375978-29981-1-git-send-email-matt@genesi-usa.com>
References: <1344375978-29981-1-git-send-email-matt@genesi-usa.com>
Message-ID: <20120809101947.GA8474@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 04:46:18PM -0500, Matt Sealey wrote:

Yay for indentation!  It'd be good to rewrite your DT so you could cut
down on that, at the minute it's not good for legibility.

> +							sw1_reg: sw1 {
> +								regulator-min-microvolt = <600000>;
> +								regulator-max-microvolt = <1375000>;
> +								regulator-boot-on;
> +								regulator-always-on;
> +							};

This and many of your other regulators have voltage ranges specified but
no consumers which doesn't make sense.  It looks awfully like you've
just typed in the maximum range supported by the regulator which is most
likely broken.

You're also specifying both boot_on and always_on which again doesn't
seem to make a lot of sense - boot_on mainly exists to help autoprobe,
using it quite this routinely isn't too clever.

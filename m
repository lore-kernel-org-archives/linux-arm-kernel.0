From: broonie@kernel.org (Mark Brown)
Date: Thu, 13 Jun 2013 15:47:26 +0100
Subject: [RFC PATCH 1/4] regulator: Introduce OMAP regulator to control
 PMIC over VC/VP
In-Reply-To: <20130613133950.GA32174@kahuna>
References: <1369246717-4167-1-git-send-email-nm@ti.com>
 <1369246717-4167-2-git-send-email-nm@ti.com>
 <20130610103131.GR31367@sirena.org.uk>
 <CAGo_u6qTiPpd0DDe3jnPh_UxTwox22azhcMGy=fftL8H+DGeyw@mail.gmail.com>
 <20130610164905.GJ1403@sirena.org.uk>
 <CAGo_u6ov=yaCwt8apbvW57ErAvhgUBHHw9gwADBC1fJUrfucUQ@mail.gmail.com>
 <20130610180150.GQ1403@sirena.org.uk>
 <20130613133950.GA32174@kahuna>
Message-ID: <20130613144726.GY1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 08:39:50AM -0500, Nishanth Menon wrote:

> I am having a bit of a difficulty trying to understand your concern
> here.

Your device tree for this stuff appears to mostly consist of repeating
the description of the PMIC that we already have - this really doesn't
seem like a great result.

> Problem statement:

> OMAP has this weird custom h/w where one programs the voltage and that
> voltage is send over i2c - this is not same as Tegra's lookup table
> array which automatically sends out entries, in OMAP, software has to trigger
> the voltage transition

The basic idea that's important here is that you need to figure out how
to tell the hardware what to write - how those writes get triggered is a
separate problem.

> If your concern was describing PMIC parameters in dts, I can easily move
> them inside the omap_pmic driver and provide required compatible flags.
> If, on the other hand, the entire approach followed is flawed, I'd like to
> understand the rationale for the same.

That's the biggest problem I saw so far but to be honest I've not
drilled down too much into the specifics.  From my point of view the
main thing is how this fits into the frameworks and so on, having the
register information in the DT was an alarm flag that suggested the
overall approach was a concern.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130613/09ae5905/attachment.sig>

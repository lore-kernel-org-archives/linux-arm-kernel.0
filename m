From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 1 Dec 2015 22:30:42 +0100
Subject: [PATCH 1/2] regulator: Add coupled regulator
In-Reply-To: <CABxcv=kn+jkQV2g=a+Sz8TdhMcvcQiBWsBuPejA159mm8WWB=w@mail.gmail.com>
References: <1448897346-17780-1-git-send-email-maxime.ripard@free-electrons.com>
 <1448897346-17780-2-git-send-email-maxime.ripard@free-electrons.com>
 <CABxcv=kn+jkQV2g=a+Sz8TdhMcvcQiBWsBuPejA159mm8WWB=w@mail.gmail.com>
Message-ID: <20151201213042.GR29263@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Mon, Nov 30, 2015 at 04:06:14PM -0300, Javier Martinez Canillas wrote:
> Hello Maxime,
> 
> On Mon, Nov 30, 2015 at 12:29 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> [snip]
> 
> >
> > +config REGULATOR_COUPLED_VOLTAGE
> 
> Shouldn't this depend on OF?
> 
> > +       tristate "Coupled voltage regulator support"
> 
> the Kconfig symbol is tristate so the driver can be built as a module...
> 
> > +
> > +static struct of_device_id coupled_regulator_of_match[] = {
> > +       { .compatible = "coupled-voltage-regulator" },
> > +       { /* Sentinel */ },
> > +};
> > +
> 
> ...but the driver is missing a MODULE_DEVICE_TABLE(of, ...) so module
> autoloading won't work.

You're right, it will be in the v2.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/a6140099/attachment.sig>

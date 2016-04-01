From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 1 Apr 2016 09:39:38 +0800
Subject: [PATCH v4 1/2] watchdog: imx2_wdt: add external reset support
 via 'ext-reset-output' dt prop
In-Reply-To: <CAJ+vNU2zBCAF8hJfmSa31CyD9XcOCxYWqH9LKRm1S_sunqkgOg@mail.gmail.com>
References: <CAJ+vNU00Bf97HUqkkW9KqOUzHXh482R9O1gasz6ju3Pn-_5chA@mail.gmail.com>
 <CAJ+vNU2qHQPSJ1KWp_3f3vAdeuOcF0ooZHmHsdafabZLXJv=Bw@mail.gmail.com>
 <20151228162923.GA31680@spo001.leaseweb.nl>
 <56AA79DA.2010305@timesys.com>
 <CAOMZO5DrTY3ho0Z_jXxeYMqbd6GmUKRwD1LB61vM1ZTGQAYOrg@mail.gmail.com>
 <56F991C3.8030201@timesys.com> <20160330012226.GD28207@tiger>
 <20160330210916.GB21993@roeck-us.net>
 <20160331015714.GM28207@tiger>
 <CAJ+vNU2zBCAF8hJfmSa31CyD9XcOCxYWqH9LKRm1S_sunqkgOg@mail.gmail.com>
Message-ID: <20160401013938.GE18833@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 11:01:58AM -0700, Tim Harvey wrote:
> On Wed, Mar 30, 2016 at 6:57 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Wed, Mar 30, 2016 at 02:09:16PM -0700, Guenter Roeck wrote:
> >> The question was if the property name should be ext-reset-output or
> >> fsl,ext-reset-output. In my opinion, it should be fsl,ext-reset-output
> >> because it is not a generic property. Tim disagrees.
> >>
> 
> Guenter,
> 
> My issue regarding the vendor prefix was not a hard dissagreement but
> was more about me understanding the rational behind using vendor
> prefixes. In this case the imx2_wdt driver 'is' a vendor specific
> driver as its compatible strings are prefixed with 'fsl,' so isn't
> 'any' property added to devicetree/bindings/watchdog/fsl-imx-wdt.txt
> inherently a vendor specific properly already? I assume that is why
> the 'big-endian' property isn't 'fsl,big-endian'.

We should read it as that 'big-endian' is a generic property defined by
generic bindings - bindings/regmap/regmap.txt, and we just reference the
bindings in fsl-imx-wdt.txt.

Taking mmc bindings as example, bindings/mmc/mmc.txt defines generic
bindings, while bindings/mmc/fsl-imx-esdhc.txt defines i.MX vendor
specific properties, which should ideally have vendor prefix.

Shawn

From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 18 Jan 2018 12:31:41 +0000
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20180109130012.GA27447@lunn.ch>
References: <20180104160939.GA7785@xora-haswell>
 <20180104162036.GL3401@lunn.ch>
 <20180108144548.GA31502@xora-haswell>
 <20180108145312.GH10940@lunn.ch>
 <20180108151453.GB31502@xora-haswell>
 <20180108154243.GA30962@lunn.ch>
 <CAPv3WKewA+7WabMYN1w=9fOxe6zOKDbxcjX0VipumQmfZtJKjQ@mail.gmail.com>
 <20180109101941.GD31502@xora-haswell>
 <CAPv3WKehwsrxuxemgL_5fKtUT2xjqkE6yf9DMcCcO2WRJ6nQaQ@mail.gmail.com>
 <20180109130012.GA27447@lunn.ch>
Message-ID: <20180118123141.GA2839@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Mika]

On Tue, Jan 09, 2018 at 02:00:12PM +0100, Andrew Lunn wrote:
> On Tue, Jan 09, 2018 at 11:22:00AM +0100, Marcin Wojtas wrote:
> > 2018-01-09 11:19 GMT+01:00 Graeme Gregory <graeme.gregory@linaro.org>:
> > > On Mon, Jan 08, 2018 at 06:17:06PM +0100, Marcin Wojtas wrote:
> > >> Hi Andrew,
> > >>
> > >>
> > >>
> > >> 2018-01-08 16:42 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
> > >> > w> I am not familiar with MDIO, but if its similar or a specific
> > >> >> implementation of a serial bus that does sound sane!
> > >> >
> > >>
> > >> Thanks for digging, I will check if and how we can use
> > >> GenericSerialBus with MDIO.
> > >>
> > > Maybe Lorenzo, Hanjun, Sudeep can comment here they might have come
> > > across similar on other ARM boards.
> > >
> > 
> > I'm looking forward to their feedback, however, what I've noticed,
> > each driver handles mdio/phys on its own, not using any generic
> > solution, which is what I need to actually avoid :)
> 
> Agreed. Lets define it once for all drivers using phylib/phylink.

To start with, I am not entirely familiar with MDIO, apologies in
advance. Building something on top of GenericSerialBus sounds correct
but if I am not mistaken you would need a new bus type in the ACPI
specs.

I CC'ed Mika since he is more familiar with handling these bits of ACPI
specs - I wonder whether this is a problem that cropped up on x86
systems too.

I do not think there is one and only answer but there must be a single
set of bindings and if the ACPI specs already cater for some of them
we have to reuse them.

Please take some time to ensure the solution you are pushing is widely
deployable.

Thanks,
Lorenzo

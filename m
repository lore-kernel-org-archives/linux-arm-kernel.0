From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 14:58:32 -0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <20120111230110.GE20968@S2101-09.ap.freescale.net>
References: <74CDBE0F657A3D45AFBB94109FB122FF176BE92F00@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508AC65@039-SN2MPN1-013.039d.mgd.msft.net>
 <20120110130511.GA26599@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A74D@HQMAIL01.nvidia.com>
 <20120111230110.GE20968@S2101-09.ap.freescale.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A7FD@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote at Wednesday, January 11, 2012 4:01 PM:
> On Wed, Jan 11, 2012 at 11:41:56AM -0800, Stephen Warren wrote:
> > Shawn Guo wrote at Tuesday, January 10, 2012 6:05 AM:
> > > On Tue, Jan 10, 2012 at 08:21:05AM +0000, Dong Aisheng-B29396 wrote:
> > > > Here what I wonder is that do we need to allow the platform to use a func-name
> > > > property in their pinmux func node or pinmux group node to specify the name.
> > >
> > > I do not see the necessity.
> > >
> > > > If it is allowed, then it could be flexible for soc to define their names.
> > > > If not there may be limitations on their node names since we can only get it from
> > > > the node name.
> > >
> > > To me, the node name is perfectly fine to be used for that purpose.
> >
> > I'd prefer if we could use integers over strings if at all possible, but
> > that does have a dependency on dtc getting a syntax to define named
> > constants, or the kernel pre-processing the .dts files before passing
> > them to dtc.
> >
> > But if we have to use strings, I will point out that the pin names I
> > chose for Tegra may not be suitable as DT node names; I don't /think/
> > the DT node names can contain spaces, but I chose to name the Tegra
> > pinctrl pins after both their pin name and GPIO name so that it's
> > easier to correlate the two:
> >
> >         PINCTRL_PIN(TEGRA_PIN_SDIO3_CLK_PA6, "SDIO3_CLK PA6"),
> >
> > Now, I could change that, but I'd prefer not to.
>
> Hmm, we are talking about function name and pingroup name instead of
> individual pin name. In your pinctrl-tegra20.c, they are .name and
> .groups as below.

OK, I guess that's true; my function and group names are just [a-z0-9].

> #define FUNCTION(fname)                                \
>        {                                               \
>                .name = #fname,                         \
>                .groups = fname##_groups,               \
>                .ngroups = ARRAY_SIZE(fname##_groups),  \
>        }

-- 
nvpublic

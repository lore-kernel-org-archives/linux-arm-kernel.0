From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 17 Jan 2012 11:35:50 -0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <20120114011029.GC1810@S2101-09.ap.freescale.net>
References: <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508AC65@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A76A@HQMAIL01.nvidia.com>
 <CAA+hA=RCmctmQJU4-k7YhzQDMi8KuyisBqOFhuMd3RV4_E=gCA@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D1FAB@HQMAIL01.nvidia.com>
 <20120114011029.GC1810@S2101-09.ap.freescale.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17801D22FB@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote at Friday, January 13, 2012 6:11 PM:
> On Fri, Jan 13, 2012 at 10:33:21AM -0800, Stephen Warren wrote:
> > So of_device_alloc(), which is called by of_platform_populate() for each
> > device, already parses basic DT content such as reg and interrupts, and
> > converts them to Linux resources. I'd consider parsing any pinmux properties
> > and registering them with the pinctrl subsystem to be of a similar nature,
> > so adding some code to of_device_alloc() that calls a core pinmux function
> > to parse the DT node seems reasonable to me.
>
> I hardly believe that device tree maintainers would agree here.
> Grant, Rob?

I'm explicitly putting Grant and Rob on the To line here to make this
question stand out to them.

-- 
nvpublic

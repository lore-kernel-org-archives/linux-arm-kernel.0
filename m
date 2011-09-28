From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 28 Sep 2011 10:28:43 -0700
Subject: [PATCH 2/2 v7] pinmux: add a driver for the U300 pinmux
In-Reply-To: <CACRpkdYx-iKPJisP7PgNynu9z3tu7s6KieFAoAOU2YO_5X2iqA@mail.gmail.com>
References: <1316175249-10780-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B7321777@HQMAIL01.nvidia.com>
	<CACRpkdY5ETbJxSpwJL-7KZhjOnhwrdT1=djwByek75ye=S9L9w@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF1738180164@HQMAIL01.nvidia.com>
	<CACRpkdbiWUFPfF9vKV5YpSW68ZTdjwb8NhWZ_9WDoY5Q+aVfvQ@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17395556DC@HQMAIL01.nvidia.com>
	<CACRpkdYx-iKPJisP7PgNynu9z3tu7s6KieFAoAOU2YO_5X2iqA@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17395557FD@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Wednesday, September 28, 2011 5:59 AM:
> On Wed, Sep 28, 2011 at 2:15 AM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> > But can't debugfs just get its information from the device name field in
> > the mapping table? I'm not sure why the need to use that information for
> > debugfs prevents the having entries with both the hog flag set and a
> > device name set?
> 
> That feels unsafe - then you have some string claiming to represent the
> device for that pinmux, but the system has not matched that string
> against dev_name() for any real device, so it could be a lie, any string
> like "foo" would do.
> 
> What I do now for U300 is complete resolution by matching dev_name
> in the mapping to dev_name(device) on the struct device * actually
> instantiated, which means you're 100% sure it is really mapped
> to that very device.
> 
> I like this since it's much more stringent...

OK, I can see the advantage, and I suppose one could still move
u300_pinmux_fetch() into the pinmux core as a helper function in the
future if needed without too much issue. If it's hard for some other
machine to set up the .dev entries in the table the function uses, one
can always fall back on system/non-device hog entries in the main
mapping table.

So I'll drop my objection to this.

-- 
nvpublic

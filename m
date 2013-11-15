From: robherring2@gmail.com (Rob Herring)
Date: Fri, 15 Nov 2013 14:16:55 -0600
Subject: [PATCH v2] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <20131115191359.GS16735@n2100.arm.linux.org.uk>
References: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
 <CAOesGMg7Mt+p8U7Z5sLQDqoFG-QEUi94Vt=pxXM0NqyefBLxVA@mail.gmail.com>
 <5283DB34.9050301@gmail.com> <201311141332.58498.arnd@arndb.de>
 <CACxGe6uMWjfmB4WDKs+vu05224jqpbDZBHT_ZXnqxw17JzUqvw@mail.gmail.com>
 <5284E236.1000606@gmail.com>
 <20131115191359.GS16735@n2100.arm.linux.org.uk>
Message-ID: <CAL_Jsq+3NgWHEjtZO-Dwsf-Xc2wbMP9e8z5yc-HbviDQhRuBZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 1:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Nov 14, 2013 at 08:46:14AM -0600, Rob Herring wrote:
>> We probably have at least a dozen machine_desc's we are close to being
>> able to remove (sunxi, picoxcell, highbank, dove, rockchip, virt,
>> several sh-mobile). There's also more that probably can be combined
>> together which will change the string in /proc/cpuinfo.
>
> I hope not (for dove) because it's one of the few ARM platforms I have
> here which run a "modern" distribution.  That's rather important,
> because I seem to find things that no one else finds, not even Olof's
> wonderful build system when running against distro stuff.
>
> It also means that work on sorting out the componentising of DRM stuff
> loses a test platform.
>
> Yes, I boot non-DT kernels on the Cubox because its the only way to get
> full support there.  Yes, I maintain a separate kernel tree for doing
> this but removing non-DT support for Dove will cripple my efforts to
> keep that up to date, and continue pushing forward on getting the various
> drivers into shape.
>
> However, maybe the whole point _is_ to keep all the fun stuff on these
> platforms out of the kernel tree...

I was referring only to DT enabled machine_desc's. I don't think we'll
touch non-DT machine_desc's. An example is combining several per SoC
DT based machine_desc's into a single SoC family machine_desc.
Ideally, we'd get rid of the machine_desc altogether, but that may not
be possible.

Rob

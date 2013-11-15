From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Nov 2013 19:13:59 +0000
Subject: [PATCH v2] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <5284E236.1000606@gmail.com>
References: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
 <CAOesGMg7Mt+p8U7Z5sLQDqoFG-QEUi94Vt=pxXM0NqyefBLxVA@mail.gmail.com>
 <5283DB34.9050301@gmail.com> <201311141332.58498.arnd@arndb.de>
 <CACxGe6uMWjfmB4WDKs+vu05224jqpbDZBHT_ZXnqxw17JzUqvw@mail.gmail.com>
 <5284E236.1000606@gmail.com>
Message-ID: <20131115191359.GS16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 08:46:14AM -0600, Rob Herring wrote:
> We probably have at least a dozen machine_desc's we are close to being
> able to remove (sunxi, picoxcell, highbank, dove, rockchip, virt,
> several sh-mobile). There's also more that probably can be combined
> together which will change the string in /proc/cpuinfo.

I hope not (for dove) because it's one of the few ARM platforms I have
here which run a "modern" distribution.  That's rather important,
because I seem to find things that no one else finds, not even Olof's
wonderful build system when running against distro stuff.

It also means that work on sorting out the componentising of DRM stuff
loses a test platform.

Yes, I boot non-DT kernels on the Cubox because its the only way to get
full support there.  Yes, I maintain a separate kernel tree for doing
this but removing non-DT support for Dove will cripple my efforts to
keep that up to date, and continue pushing forward on getting the various
drivers into shape.

However, maybe the whole point _is_ to keep all the fun stuff on these
platforms out of the kernel tree...

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2015 14:58:41 +0100
Subject: Build regressions/improvements in v4.3-rc3
In-Reply-To: <CAMuHMdU5UGfDSzfNWsZvsgLvJJYK-5VWEZ841Zc4GYfey6RdtA@mail.gmail.com>
References: <1443382476-12171-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWrBYnQ0CRYmBgO3xNZMqCY42OtNwhryqzi+Tv+KGj6Lg@mail.gmail.com>
 <20150928093006.GT21513@n2100.arm.linux.org.uk>
 <20150928094836.GU21513@n2100.arm.linux.org.uk>
 <CAMuHMdU5UGfDSzfNWsZvsgLvJJYK-5VWEZ841Zc4GYfey6RdtA@mail.gmail.com>
Message-ID: <20150928135841.GV21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 03:50:16PM +0200, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Mon, Sep 28, 2015 at 11:48 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Also, a great many of the failures are due to the build toolchain not
> > supporting -fstack-protector-strong.  I think it's absolutely right
> > for the build to error out if you enable a kernel feature which requires
> > toolchain support, but the toolchain does not support that feature.
> >
> > What this means is that the build results from kissb are less than
> > useful - without spending ages looking at every single build, it's
> > hard to find the real failures we care about.
> >
> > I'd suggest that either the randconfig is seeded to ensure that
> > CONFIG_CC_STACKPROTECTOR_STRONG is always disabled in ARM randconfigs,
> > or that the ARM toolchain is updated to support this feature.
> 
> Or that it's impossible to enable this feature if your toolchain doesn't
> support it?

I think that would require kconfig to call out to the compiler to run
a test build.  This kind of thing has been talked about in the past
but the feature never seems to appear - probably because it would end
up increasing the kconfig startup time in every case.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Dec 2013 19:50:09 +0100
Subject: [PATCH v4 1/2] ARM: mach-moxart: add MOXA ART SoC platform files
In-Reply-To: <CACmBeS3Xse5KkFqkM5Ye+qaaxpVCjyeGz7Oc9sr0PN+pZ9sztQ@mail.gmail.com>
References: <1386945188-8316-1-git-send-email-jonas.jensen@gmail.com>
 <52AC7E41.7050201@roeck-us.net>
 <CACmBeS3Xse5KkFqkM5Ye+qaaxpVCjyeGz7Oc9sr0PN+pZ9sztQ@mail.gmail.com>
Message-ID: <201312141950.09447.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 December 2013, Jonas Jensen wrote:
> >
> > Conceptually it might be cleaner to write a separate driver, for example
> > in drivers/power/restart, than plugging the functionality into
> > the watchdog driver, at least if you don't want it in architecture
> > or platform code. The xgene restart driver is a good example.
> >
> 
> Moving it to a new power/restart driver seems reasonable to me, I'm
> really just looking for a home for it, I would have preferred a
> hardware with reset in a separate register though.
> 
> I now plan to remove it for v5 and submit a separate driver.

I still think it's better to leave it in the watchdog driver: This
driver attaches to the watchdog device, and adding a separate driver
for reset means we have to trick the core Linux code into attaching
two drivers to one device in some way, or the device tree has to fake
a second device that doesn't exist in hardware but is only needed
because of Linux implementation details.

	Arnd

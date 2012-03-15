From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 17:46:56 +0000
Subject: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
In-Reply-To: <20120315173714.GF15988@n2100.arm.linux.org.uk>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <4F622884.6060807@linaro.org> <20120315173714.GF15988@n2100.arm.linux.org.uk>
Message-ID: <201203151746.56678.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> On Thu, Mar 15, 2012 at 05:36:04PM +0000, Lee Jones wrote:
> > On 15/03/12 17:32, Russell King - ARM Linux wrote:
> > > On Wed, Mar 14, 2012 at 02:20:00PM +0000, Lee Jones wrote:
> > >> This is a step in the right direction for future Device
> > >> Tree support. It will allow variant specific attributes
> > >> to be collected from a Device Tree without overloading
> > >> the MMCI core. It will also provide additional future
> > >> variants a cleaner way to add support.
> > > 
> > > NAK.  You can't have two driver structures with the same name.  The names
> > > are sysfs object names.
> > 
> > Well spotted.
> > 
> > I've already changed this in v2. :)
> 
> I'm not in favour of splitting the two variants either btw.

Can you elaborate? I suggested the split in order to keep the ux500
specific parts local to one file. With the device tree conversion,
we really want to have them out of the platform code, but sticking them
into the main driver seems wrong, too.

I don't mind leaving the ARM and u300 specific bits in the main driver,
but I think having the ux500 parts separate does indeed help.

	Arnd

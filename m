From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 6 May 2014 10:15:57 -0700
Subject: [PATCH v2 05/12] ARM: lpc32xx: add MTD_SPI_NOR (new dependency
 for M25P80)
In-Reply-To: <53628282.10201@antcom.de>
References: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
 <1398925607-7482-6-git-send-email-computersforpeace@gmail.com>
 <53628282.10201@antcom.de>
Message-ID: <20140506171557.GB28907@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 07:21:06PM +0200, Roland Stigge wrote:
> On 01/05/14 08:26, Brian Norris wrote:
> > This defconfig contains the CONFIG_M25P80 symbol, which is now
> > dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to satisfy
> > the new dependency.
> 
> Can't the CONFIG_M25P80 declare its dependency on CONFIG_MTD_SPI_NOR
> itself, or put CONFIG_M25P80 etc. into a submenu under CONFIG_MTD_SPI_NOR?

It does declared the dependency already. And I plan to move it under the
SPI-NOR submenu too.

But as I stated in the cover letter (I'm not sure if it made it through
to all the cross-posted ML's):

  http://article.gmane.org/gmane.linux.ports.ppc.embedded/69885

  "Note that without the new CONFIG_MTD_SPI_NOR symbol in your
  defconfig, Kconfig will automatically drop M25P80 for you."

So declaring the dependency is half the battle, but you still have to
include your dependencies in your defconfig.

Brian

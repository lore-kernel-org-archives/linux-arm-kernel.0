From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 5 Jun 2013 12:53:08 +0200
Subject: [PATCH 1/2] hwmon: mc13783-adc: Refactor source to indicate
 various mc13xxx chips
In-Reply-To: <1370423952.906453652@f168.mail.ru>
References: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
 <20130605110206.02fc09f3@endymion.delvare>
 <1370423952.906453652@f168.mail.ru>
Message-ID: <20130605125308.36ba40ab@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 05 Jun 2013 13:19:12 +0400, Alexander Shiyan wrote:
> > On Wed,  5 Jun 2013 12:57:07 +0400, Alexander Shiyan wrote:
> > > This patch renames structures, variables and functions to indicate support
> > > for various MC13xxx chips.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  drivers/hwmon/mc13783-adc.c | 135 +++++++++++++++++++++-----------------------
> > >  1 file changed, 63 insertions(+), 72 deletions(-)
> > 
> > Nack. This change serves absolutely no purpose, all it's doing it make
> > everyone's life harder. Just don't do that, thanks.
> 
> I do not understand stubbornness here.
> The driver works for different chips, it should be reflected in the code.

Let's look at it from another angle. What problem are you trying to
solve? I see absolutely no problem with the current function and file
names. Almost all Linux kernel drivers support more chips than their
name says.

On the other hand, changing all function names makes backporting fixes
harder, and changing Kconfig symbol names makes upgrading to the new
kernel version harder for everyone.

So the cost of your proposal far outweighs the benefits.

-- 
Jean Delvare

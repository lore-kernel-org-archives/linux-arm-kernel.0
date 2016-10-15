From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 15 Oct 2016 13:27:40 +0200
Subject: [PATCH 4/4] staging/vchi: Remove dependency on CONFIG_BROKEN.
In-Reply-To: <886598225.386698.0cc5acd0-af27-4ef7-892f-3c2dd86176ba.open-xchange@email.1und1.de>
References: <20161003185209.27733-1-eric@anholt.net>
 <20161003185209.27733-5-eric@anholt.net>
 <20161013070535.GA23147@kroah.com>
 <886598225.386698.0cc5acd0-af27-4ef7-892f-3c2dd86176ba.open-xchange@email.1und1.de>
Message-ID: <20161015112740.GB11674@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 15, 2016 at 10:35:25AM +0200, Stefan Wahren wrote:
> 
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> hat am 13. Oktober 2016 um
> > 09:05 geschrieben:
> > 
> > 
> > On Mon, Oct 03, 2016 at 11:52:09AM -0700, Eric Anholt wrote:
> > > The driver builds now.
> > > 
> > > Signed-off-by: Eric Anholt <eric@anholt.net>
> > > ---
> > >  drivers/staging/vc04_services/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/vc04_services/Kconfig
> > > b/drivers/staging/vc04_services/Kconfig
> > > index 9676fb29075a..db8e1beb89f9 100644
> > > --- a/drivers/staging/vc04_services/Kconfig
> > > +++ b/drivers/staging/vc04_services/Kconfig
> > > @@ -1,6 +1,6 @@
> > >  config BCM2708_VCHIQ
> > >  	tristate "Videocore VCHIQ"
> > > -	depends on RASPBERRYPI_FIRMWARE && BROKEN
> > > +	depends on RASPBERRYPI_FIRMWARE
> > >  	default y
> > >  	help
> > >  		Kernel to VideoCore communication interface for the
> > 
> > I've dropped this patch from my branch as there are build errors on
> > arm64 systems still, and we don't want regressions like that.
> > 
> > I've forwarded you the error messages, and I'll be glad to add this
> > patch back once these issues are fixed.
> 
> I ask the author of this downstream pull request [1] to send the VHCIQ part as
> indiviual patches.
> He is interested to submit them upstream.
> 
> [1] - https://github.com/raspberrypi/linux/pull/1611

Ok, but what does that mean for us here?  The code should be all now
merged into our "upstream" trees, it just needs to be cleaned up
properly.

confused,

greg k-h

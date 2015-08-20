From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 23:18:50 +0200
Subject: [PATCH 1/9] spi: sunxi: fix transfer timeout
In-Reply-To: <20150820210830.GS12027@sirena.org.uk>
References: <cover.1440080122.git.hramrach@gmail.com>
 <0e0b52774a48ddb71dc8095b66942451cd31ff7d.1440080122.git.hramrach@gmail.com>
 <20150820184132.GO12027@sirena.org.uk>
 <20150820193433.GH30520@lukather>
 <20150820210830.GS12027@sirena.org.uk>
Message-ID: <20150820211850.GI30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 02:08:30PM -0700, Mark Brown wrote:
> On Thu, Aug 20, 2015 at 09:34:33PM +0200, Maxime Ripard wrote:
> > On Thu, Aug 20, 2015 at 11:41:32AM -0700, Mark Brown wrote:
> > > On Thu, Aug 20, 2015 at 02:19:45PM -0000, Michal Suchanek wrote:
> 
> > > >  drivers/spi/spi-sun4i.c | 10 +++++++++-
> > > >  drivers/spi/spi-sun6i.c | 10 +++++++++-
> 
> > > Are we *sure* we can't work on merging these drivers :(
> 
> > Those are two different IPs, that don't really share anything but
> > their author...
> 
> I seem to be seeing a number of changes like this one which make
> apparently very similar modifications to both.  Perhaps there is more
> core usage that should be happening instead?

Yeah, because I wrote the two at the same time, and they share the
same flaws. But that doesn't really mean that you can share anything
at the driver level. And I'm not really sure that we can do much more
at the framework level either, except maybe handling the timeout
directly (but then the drivers would have to handle the recovering
after a timeout too).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/6f6ae098/attachment.sig>

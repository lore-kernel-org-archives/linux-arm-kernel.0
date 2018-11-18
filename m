From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 18 Nov 2018 13:48:44 +0100 (CET)
Subject: [PATCH v3] firmware: raspberrypi: Fix firmware calls with large
 buffers
In-Reply-To: <877ehcd897.fsf@anholt.net>
References: <20181116143907.6149-1-james.hughes@raspberrypi.org>
 <877ehcd897.fsf@anholt.net>
Message-ID: <149516209.38310.1542545324454@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Eric Anholt <eric@anholt.net> hat am 16. November 2018 um 22:26 geschrieben:
> 
> 
> James Hughes <james.hughes@raspberrypi.org> writes:
> 
> > Commit a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")
> > moved away from VLA's to a fixed maximum size for mailbox data.
> > However, some mailbox calls use larger data buffers
> > than the maximum allowed in that change. This fix therefor
> > moves from using fixed buffers to kmalloc to ensure all sizes
> > are catered for.
> >
> > There is some documentation, which is somewhat out of date,
> > on the mailbox calls here :
> > https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
> >
> > Fixes: a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")
> >
> > Signed-off-by: James Hughes <james.hughes@raspberrypi.org>
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>

Applied to bcm2835-drivers-next

Thanks

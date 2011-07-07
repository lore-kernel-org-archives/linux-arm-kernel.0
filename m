From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 19:40:24 +0200
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <81e4ac16-db7b-47a0-9f93-632a5d9f898d@VA3EHSMHS028.ehs.local>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<201107071817.11842.arnd@arndb.de>
	<81e4ac16-db7b-47a0-9f93-632a5d9f898d@VA3EHSMHS028.ehs.local>
Message-ID: <201107071940.24964.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011 19:08:38 John Linn wrote:
> > There is a way to specify DMA address ranges in the device tree,
> though
> > I forgot the exact format. It comes down to saying the device sees
> > memory range XXX to YYY as its local address AAA to BBB. We could use
> > that information at boot time to determine what the largest range
> > of memory is that is visible by all devices (and hope that it's at
> > the start of physical memory).
> 
> If I'm following this right....
> 
> We have a hole at the start of physical memory (when it's at 0) so that
> DMA can't DMA into it.  Sounds like that won't work for us?

A whole in physical memory should not be a problem. It's only a problem
if you have a device that can do DMA only to to some memory range that
is not the start of your RAM, e.g. only the second 256MB but not the first.

	Arnd

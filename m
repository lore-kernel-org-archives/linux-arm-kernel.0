From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Oct 2010 21:16:31 +0200
Subject: [PATCH] dma/coh901318: use simple_read_from_buffer
In-Reply-To: <20101022203039.7b353056@absol.kitzblitz>
References: <20101022192953.1f67b10a@absol.kitzblitz>
	<201010221938.12591.arnd@arndb.de>
	<20101022203039.7b353056@absol.kitzblitz>
Message-ID: <201010222116.32069.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 October 2010 20:30:39 Nicolas Kaiser wrote:
> * Arnd Bergmann <arnd@arndb.de>:
> > On Friday 22 October 2010 19:29:53 Nicolas Kaiser wrote:
> > > If copy_to_user fails, the assigned error code instantly gets
> > > overwritten, and the failure apparently ignored. Moreover,
> > > shouldn't the error code be -EFAULT instead of -EINVAL?
> > 
> > Looks good, but it would be even better to just use
> > simple_read_from_buffer in this function, which takes care of
> > a lot the other complexities as well.
> 
> Like this? (Sorry, untested.)
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>

Yes, exactly. For stable kernels, your smaller fix is probably good
enough though and it's obviously correct.

	Arnd

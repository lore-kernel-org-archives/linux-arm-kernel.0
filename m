From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 24 Feb 2017 22:57:31 +0300
Subject: [PATCH] staging: bcm2835: Fix a memory leak in error handling path
In-Reply-To: <6585ca42-71f4-1517-c6fc-b9ed2f23c687@i2se.com>
References: <20170219103412.10092-1-christophe.jaillet@wanadoo.fr>
 <6585ca42-71f4-1517-c6fc-b9ed2f23c687@i2se.com>
Message-ID: <20170224195731.GB4480@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 01:37:30PM +0100, Stefan Wahren wrote:
> Hi Christophe,
> 
> Am 19.02.2017 um 11:34 schrieb Christophe JAILLET:
> >If 'kzalloc()' fails, we should release resources allocated so far, just as
> >done in all other cases in this function.
> >
> >Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >---
> >Not sure that the error handling path is correct.
> >Is 'gdev[0]' freed? Should it be?
> 

Yes, but I already sent a patch to fix this and your leak as well and
Greg merged it.

> sorry, didn't checked your patch yet.

It takes like 30 seconds to review this patch.  Do you use mutt?  I have
a macro that applies patches and loads vim at the right line.

regards,
dan carpenter

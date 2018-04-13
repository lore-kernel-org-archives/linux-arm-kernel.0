From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 13 Apr 2018 15:41:00 +0000
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <20180412215149.GA27802@saruman>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman>
Message-ID: <e38a329dfb9c461ab3e91de7b96db3dc@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Hogan
> Sent: 12 April 2018 22:52
> On Tue, Apr 03, 2018 at 08:55:04AM -0400, Sinan Kaya wrote:
> > While a barrier is present in writeX() function before the register write,
> > a similar barrier is missing in the readX() function after the register
> > read. This could allow memory accesses following readX() to observe
> > stale data.
> >
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> 
> Both patches look like obvious improvements to me, so I'm happy to apply
> to my fixes branch.

Don't you also need at least barrier() between the register write in writeX()
and the register read in readX()?
On ppc you probably need eieio.
Or are drivers expected to insert that one?
If they need to insert that one then why not all the others??

	David

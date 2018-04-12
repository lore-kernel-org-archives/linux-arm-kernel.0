From: jhogan@kernel.org (James Hogan)
Date: Thu, 12 Apr 2018 22:58:55 +0100
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <20180412215149.GA27802@saruman>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman>
Message-ID: <20180412215855.GB27802@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2018 at 10:51:49PM +0100, James Hogan wrote:
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

Though having said that, a comment to go with the rmb() (as suggested by
checkpatch) to detail the situation we're concerned about would be nice
to have.

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/f9f87e90/attachment.sig>

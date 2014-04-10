From: msalter@redhat.com (Mark Salter)
Date: Thu, 10 Apr 2014 08:54:02 -0400
Subject: [PATCH v3 06/10] arm64: efi: add EFI stub
In-Reply-To: <20140409142013.GC26210@e106331-lin.cambridge.arm.com>
References: <1396637113-22790-1-git-send-email-leif.lindholm@linaro.org>
 <1396637113-22790-7-git-send-email-leif.lindholm@linaro.org>
 <20140409142013.GC26210@e106331-lin.cambridge.arm.com>
Message-ID: <1397134442.31272.38.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-04-09 at 15:20 +0100, Mark Rutland wrote:
> >
> > +config EFI
> > +       bool "UEFI firmware support"
> > +       depends on OF
> 
> I note we're not depending on !CPU_BIG_ENDIAN here, and it looks like
> the implementation is not endian-clean (I've pointed out a few issues
> below).
> 
> We need to fix that up for CPU_BIG_ENDIAN. For the moment we could
> depend on !CPU_BIG_ENDIAN which would at least to make it clear we don't
> support EFI && CPU_BIG_ENDIAN yet. The commit message should be updated
> to mention that.
> 

Yes, the !CPU_BIG_ENDIAN was there at one point but got lost along
the way. It may be best to put it back for now, but I'll take a
stab at getting the stub part sorted out based on your comments.
Full runtime services will be trickier and need a followup patch in
the future after the initial patch series goes in.

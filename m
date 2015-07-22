From: mpe@ellerman.id.au (Michael Ellerman)
Date: Wed, 22 Jul 2015 11:25:16 +1000
Subject: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and
 munlockall system calls
In-Reply-To: <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-3-git-send-email-emunson@akamai.com>
 <20150721134441.d69e4e1099bd43e56835b3c5@linux-foundation.org>
Message-ID: <1437528316.16792.7.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-07-21 at 13:44 -0700, Andrew Morton wrote:
> On Tue, 21 Jul 2015 15:59:37 -0400 Eric B Munson <emunson@akamai.com> wrote:
> 
> > With the refactored mlock code, introduce new system calls for mlock,
> > munlock, and munlockall.  The new calls will allow the user to specify
> > what lock states are being added or cleared.  mlock2 and munlock2 are
> > trivial at the moment, but a follow on patch will add a new mlock state
> > making them useful.
> > 
> > munlock2 addresses a limitation of the current implementation.  If a
> > user calls mlockall(MCL_CURRENT | MCL_FUTURE) and then later decides
> > that MCL_FUTURE should be removed, they would have to call munlockall()
> > followed by mlockall(MCL_CURRENT) which could potentially be very
> > expensive.  The new munlockall2 system call allows a user to simply
> > clear the MCL_FUTURE flag.
> 
> This is hard.  Maybe we shouldn't have wired up anything other than
> x86.  That's what we usually do with new syscalls.

Yeah I think so.

You haven't wired it up properly on powerpc, but I haven't mentioned it because
I'd rather we did it.

cheers

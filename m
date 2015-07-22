From: vbabka@suse.cz (Vlastimil Babka)
Date: Wed, 22 Jul 2015 11:16:10 +0200
Subject: [PATCH V4 2/6] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
In-Reply-To: <1437508781-28655-3-git-send-email-emunson@akamai.com>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-3-git-send-email-emunson@akamai.com>
Message-ID: <55AF5F5A.3000707@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2015 09:59 PM, Eric B Munson wrote:
> With the refactored mlock code, introduce new system calls for mlock,
> munlock, and munlockall.  The new calls will allow the user to specify
> what lock states are being added or cleared.  mlock2 and munlock2 are
> trivial at the moment, but a follow on patch will add a new mlock state
> making them useful.
>
> munlock2 addresses a limitation of the current implementation.  If a

   ^ munlockall2?

> user calls mlockall(MCL_CURRENT | MCL_FUTURE) and then later decides
> that MCL_FUTURE should be removed, they would have to call munlockall()
> followed by mlockall(MCL_CURRENT) which could potentially be very
> expensive.  The new munlockall2 system call allows a user to simply
> clear the MCL_FUTURE flag.
>

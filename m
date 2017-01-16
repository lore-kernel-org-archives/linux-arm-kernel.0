From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 16 Jan 2017 13:34:44 +0000
Subject: [RFC PATCH 07/10] arm64/sve: Add vector length inheritance control
In-Reply-To: <20170116122755.GH28060@E107787-LIN>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-8-git-send-email-Dave.Martin@arm.com>
 <20170116122755.GH28060@E107787-LIN>
Message-ID: <20170116133443.GP3699@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 12:27:55PM +0000, Yao Qi wrote:
> On 17-01-12 11:26:06, Dave Martin wrote:
> > Currently the vector length is inherited across both fork() and
> > exec().
> > 
> > Inheritance across fork() is desirable both for creating a copy of
> > a process (traditional fork) or creating a thread (where we want
> > all threads to share the same VL by default).
> > 
> > Inheritance across exec() is less desirable, because of the ABI
> > impact of large vector lengths on the size of the signal frame --
> > when running a new binary, there is no guarantee that the new
> > binary is compatible with these ABI changes.
> > 
> > This flag makes the vector length non-inherited by default.
> 
> Can we make vector length inherited across fork but non-inherited
> across exec by default?

That is the behaviour: I always inherit across fork/clone, since
you are still running the same binary after those.

I could word the commit message a bit more clearly here.

Cheers
---Dave 

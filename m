From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Wed, 25 Feb 2015 21:45:00 +0000
Subject: build warning on v4.0-rc1
In-Reply-To: <20150225175143.GE11136@saruman.tx.rr.com>
References: <20150225175143.GE11136@saruman.tx.rr.com>
Message-ID: <20150225214500.GM29656@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 11:51:43AM -0600, Felipe Balbi wrote:
> Hi Al,
> 
> commit 3b994d98a815d934ab6a77a380882865982c14f9 (get rid of the second
> argument of acct_kill()) added a new build warning when building
> kernel/acct.c. Warning can be seen below. Revert of that commit is
> non-trivial, so I haven't tried to check if reverting it fixes the
> warning.

Warning is a false positive; we really do not care about the return
value here.

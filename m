From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Feb 2015 10:06:13 +0000
Subject: [RFC PATCH] ARM64: cmpxchg.h: Clear the exclusive access bit on
 fail
In-Reply-To: <1425016026-19766-1-git-send-email-bobby.prani@gmail.com>
References: <1425016026-19766-1-git-send-email-bobby.prani@gmail.com>
Message-ID: <20150227100612.GB3628@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 05:46:55AM +0000, Pranith Kumar wrote:
> In cmpxchg(), we do a load exclusive on an address and upon a comparison fail,
> we skip the store exclusive instruction. This can result in the exclusive bit
> still set. If there was a store exclusive after this to the same address, that
> will see the exclusive bit set. This should not happen.

... and the problem with that is?

> We need to clear the exclusive bit in these cases.

Why?

Will

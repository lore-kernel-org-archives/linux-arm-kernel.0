From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 20:34:16 +0000
Subject: [GIT PULL v2] Linux support for ARM LPAE
In-Reply-To: <20111206152955.GC31720@arm.com>
References: <20111206152955.GC31720@arm.com>
Message-ID: <20111206203416.GV14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 03:29:55PM +0000, Catalin Marinas wrote:
> I updated the series with an additional signed-off-by to your patch. The
> code is unchanged. Could you please pull it again?

I will for this time only, but note - last time you said:

> If there are no further comments, could you please pull the ARM LPAE
> branch below? They should be merged after Will's idmap patches (no real
> conflict, just correctly functioning setup_mm_for_reboot).

Now, the thing is, merging it after Will's patches won't solve that in
any shape or form - it really does not matter what order I do the merges
in, the fact of the matter is that there is no ordering or dependence
between your patches and Will's, so there's no guarantee that your code
will see a properly functioning setup_mm_for_reboot.

If you actually depend on something in some other tree, you need to have
it merged into your tree _before_ the objects which depend on it.

So, what the above comment admits to me is that "what I'm asking you to
pull is known to be broken if a git-bisect hits one of these commits,
but I don't care."

As I said, I will merge it this time around, but next time I won't.

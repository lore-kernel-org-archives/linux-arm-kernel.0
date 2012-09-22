From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Sep 2012 22:17:25 -0700
Subject: [GIT PULL V3 4/5] ARM: Kirkwood: cleanup for v3.7
In-Reply-To: <20120921195714.GY5469@titan.lakedaemon.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120921195714.GY5469@titan.lakedaemon.net>
Message-ID: <20120922051725.GB32245@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 03:57:14PM -0400, Jason Cooper wrote:
> 
> NOTE:  This branch depends on both kirkwood/boards and kirkwood/dt (and,
> by extension, kirkwood/addr_decode).  Some of that got pulled into this
> summary (kirkwood/boards).  Is this correct?  Sould I be basing the
> pullreq on v3.6-rc5?  That would summarize all three branches.  Doesn't
> seem as useful.

What I tend to do in these cases is that I merge the dependent branches into
a temporary working branch, then merge in the "new" branch on top, and get the
diffstat from the last merge there.

It also looks like the base for this branch is something that is not a full
-rc, please only base your branches on -rcs since that makes merge history much
cleaner and easier to deal with on our side.

So, for example:

git checkout v3.6-rc5
git merge kirkwood/boards
git merge kirkwood/dt

And then you can use that HEAD as the reference in request-pull.


-Olof

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Dec 2013 23:17:56 +0000
Subject: Boot time errors/warnings on snowball
In-Reply-To: <20131204175119.GD26581@lee--X1>
References: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
 <CACRpkda3V4bK3_QO76=++Gcm3pJp78G2L3pgAdaJb2NDcAJG6Q@mail.gmail.com>
 <20131204172626.GB26581@lee--X1>
 <CAOesGMjMWqPtJXh7-VAhyA1a95h7mKV8_UZhyTtxgEbUhU8_5Q@mail.gmail.com>
 <20131204175119.GD26581@lee--X1>
Message-ID: <20131204231756.GX16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 05:51:19PM +0000, Lee Jones wrote:
> I know that you've had a bee in your bonnet about the rate of which I
> sent patches for a while, but this instance has nothing to do with
> rushing. This is merely an ordering issue and the speed in which
> varying subsystems are merged into -next.
> 
> This is what -next is for though right? To identify these kinds of
> decencies before they're merged into Mainline. So let's do something
> about it now. I'm not sure what though, as I know that Mark isn't fond
> of rebasing his tree.

You can't solve dependencies by "tree X needs to merge before tree Y
otherwise Z breaks", period.

It gives the _illusion_ that it solves it, but it doesn't.  Just try
doing a git bisect and hitting commits in tree Y without tree X being
merged.  By doing it this way, you're basically telling people that
you can't bisect a merge window.  The merge window is _precisely_ the
period where we need bisectability to find bugs.

> It might not even be an issue though. We just need to ensure that
> Linus pulls from ARM-SoC prior to ASoC during the next merge
> window.

No you don't.  People need to understand how git works and realise that
"tree X merges before tree Y" is never a solution to a dependency
problem.

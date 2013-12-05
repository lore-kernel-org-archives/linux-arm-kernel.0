From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 5 Dec 2013 08:04:06 +0000
Subject: Boot time errors/warnings on snowball
In-Reply-To: <20131204231756.GX16735@n2100.arm.linux.org.uk>
References: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
 <CACRpkda3V4bK3_QO76=++Gcm3pJp78G2L3pgAdaJb2NDcAJG6Q@mail.gmail.com>
 <20131204172626.GB26581@lee--X1>
 <CAOesGMjMWqPtJXh7-VAhyA1a95h7mKV8_UZhyTtxgEbUhU8_5Q@mail.gmail.com>
 <20131204175119.GD26581@lee--X1>
 <20131204231756.GX16735@n2100.arm.linux.org.uk>
Message-ID: <20131205080406.GH26581@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I know that you've had a bee in your bonnet about the rate of which I
> > sent patches for a while, but this instance has nothing to do with
> > rushing. This is merely an ordering issue and the speed in which
> > varying subsystems are merged into -next.
> > 
> > This is what -next is for though right? To identify these kinds of
> > decencies before they're merged into Mainline. So let's do something
> > about it now. I'm not sure what though, as I know that Mark isn't fond
> > of rebasing his tree.
> 
> You can't solve dependencies by "tree X needs to merge before tree Y
> otherwise Z breaks", period.
> 
> It gives the _illusion_ that it solves it, but it doesn't.  Just try
> doing a git bisect and hitting commits in tree Y without tree X being
> merged.  By doing it this way, you're basically telling people that
> you can't bisect a merge window.  The merge window is _precisely_ the
> period where we need bisectability to find bugs.

Right, Olof was already kind enough to point this out:

 "It can be done. It's unfortunate to lose bisectability though (since
  when you bisect you can end up in a state where the ASoC patches are
  enabled but not the ux500 counterparts. Setting up a shared branch
  is indeed the best (only) way to solve that. Next time around we
  should do so."
 
Which reminded me of "how git works"; non-linear history, yada yada.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

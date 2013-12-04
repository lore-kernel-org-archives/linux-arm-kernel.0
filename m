From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Dec 2013 18:10:47 +0000
Subject: Boot time errors/warnings on snowball
In-Reply-To: <CAOesGMh7+r9vUvtH_pwJeMyQJGo3u-uJRJ8-OBidzzO1pC5RDA@mail.gmail.com>
References: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
 <CACRpkda3V4bK3_QO76=++Gcm3pJp78G2L3pgAdaJb2NDcAJG6Q@mail.gmail.com>
 <20131204172626.GB26581@lee--X1>
 <CAOesGMjMWqPtJXh7-VAhyA1a95h7mKV8_UZhyTtxgEbUhU8_5Q@mail.gmail.com>
 <20131204175119.GD26581@lee--X1>
 <CAOesGMh7+r9vUvtH_pwJeMyQJGo3u-uJRJ8-OBidzzO1pC5RDA@mail.gmail.com>
Message-ID: <20131204181047.GF26581@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> By the way, if these things keep happening, then it's an indicator
> >> that you should slow down the rate of change a bit and make sure
> >> things are tested properly. You get a lot of patches produced quickly,
> >> which is awesome, but please make sure things are coordinated and
> >> tested especially for the more complex and inter-dependent changes
> >> like these. If it needs to take another release (or just another week
> >> or two) to get something staged in the right order, then that's OK.
> >
> > I know that you've had a bee in your bonnet about the rate of which I
> > sent patches for a while, but this instance has nothing to do with
> > rushing. This is merely an ordering issue and the speed in which
> > varying subsystems are merged into -next.
> 
> I don't have a problem with the rate of change, but it can easily
> become error prone with too many patches in flight which is my main
> concern. I'm just asking you to be careful, I'm not saying you're
> doing anything wrong. It's great to see these conversions happening!
> 
> > This is what -next is for though right? To identify these kinds of
> > decencies before they're merged into Mainline. So let's do something
> > about it now. I'm not sure what though, as I know that Mark isn't fond
> > of rebasing his tree.
> 
> This is exactly what -next is for, and that's why I'm reporting the
> issue so it can be resolved. Since it's been fixed by an existing
> patch, all is good. But it does bring up the below, which is good to
> cover here:
> 
> > Ideally we should have setup an immutable branch between ASoC and
> > either ux500 or ARM-SoC where both parties can pull from. That's what
> > Mark and I usually do when ASoC/Regulators and MFD have dependencies
> > on one another.
> >
> > It might not even be an issue though. We just need to ensure that
> > Linus pulls from ARM-SoC prior to ASoC during the next merge
> > window. Can that be done?
> 
> It can be done. It's unfortunate to lose bisectability though (since
> when you bisect you can end up in a state where the ASoC patches are
> enabled but not the ux500 counterparts. Setting up a shared branch is
> indeed the best (only) way to solve that. Next time around we should
> do so.
> 
> We're usually fairly quick at merging our branches during the merge
> window, so sequencing should be fine. Even if Mark does his pull
> requests before us, the window of breakage should be minimal (and
> we're now aware of it).

FWIW, I agree with everything you said.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

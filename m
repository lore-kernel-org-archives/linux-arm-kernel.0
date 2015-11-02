From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 2 Nov 2015 11:41:57 -0800
Subject: [GIT PULL] Allwinner DT changes for 4.4, round 3
In-Reply-To: <CAOesGMhb4Y6UQ=OqT8fVZaBP6pA1XCsHD5zG0HmKyzosd5F0ZQ@mail.gmail.com>
References: <4745252.gLSrJNQ42D@wuerfel> <9946613.K7Ehp1DEiL@wuerfel>
 <20151025201308.GS10947@lukather>
 <20151026010752.GG14238@localhost>
 <CAGb2v671MmpRHkWKpOd8kmEbvfTKTU9k7AU_bP+AgRuguodWkQ@mail.gmail.com>
 <20151026054828.GD4216@localhost> <20151026103409.GX10947@lukather>
 <CAOesGMjNQeaA0etj0fk0E_QPNLYA3WTaRCfWE7YFz50RoDXu-w@mail.gmail.com>
 <20151102191923.GO19782@codeaurora.org>
 <CAOesGMhb4Y6UQ=OqT8fVZaBP6pA1XCsHD5zG0HmKyzosd5F0ZQ@mail.gmail.com>
Message-ID: <20151102194157.GR19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02, Olof Johansson wrote:
> On Mon, Nov 2, 2015 at 11:19 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 10/31, Olof Johansson wrote:
> >> On Mon, Oct 26, 2015 at 3:34 AM, Maxime Ripard
> >> >
> >> > Gaah, sorry...
> >> >
> >> >> I've merged this in now. Note that this has resulted in a tree that won't
> >> >> misect cleanly, since having the clk contents merged instead of used as a base
> >> >> for the dt branch means that you could end up in a bisect state that has the DT
> >> >> branch but not the clk branch.
> >> >
> >> > Even if it has been merged before the DT patches have been applied?
> >> > That's not really what I'd expect from bisect :/
> >>
> >> Yeah, due to the way bisect works, the only way to guarantee
> >> bisectability is if you base the DT branch on top of the clk branch
> >> when you build it. Otherwise the bisect can come down the path of only
> >> having the DT contents not the clk contents.
> >
> > Why can't the dts changes be applied directly on top of the
> > branch that's in the clk tree and then sent off to arm-soc? The
> > git merge && git commit technique also works, but it introduces
> > an unnecessary merge commit into the history.
> 
> "base the DT branch on top of the clk branch" is exactly that, isn't it?
> 

Yes. I mostly wanted to point out that you don't need to do the
git merge part when building that branch.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

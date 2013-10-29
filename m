From: dwalker@fifo99.com (Daniel Walker)
Date: Tue, 29 Oct 2013 10:08:17 -0700
Subject: [PATCH 2/4] ARM: msm: Remove 7x00 support
In-Reply-To: <CAOesGMhg8HN4Su9FXSeoAgmH6NVKXW+wmnreUvWH+1G6GWkkaA@mail.gmail.com>
References: <1382993006-27359-1-git-send-email-davidb@codeaurora.org>
 <1382993006-27359-3-git-send-email-davidb@codeaurora.org>
 <20131029132043.GA28165@fifo99.com>
 <CAOesGMhg8HN4Su9FXSeoAgmH6NVKXW+wmnreUvWH+1G6GWkkaA@mail.gmail.com>
Message-ID: <20131029170817.GA13047@fifo99.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 08:37:28AM -0700, Olof Johansson wrote:
> Daniel,
> 
> I would be very happy to take more code for the older Qualcomm chipset
> to enable full functionality for them, but it's been my impression
> that far from all that is needed to make it a useful platform is in
> the upstream kernel, and there's been no signs of more of it showing
> up at least in the last two years.

Some of the platform code he's removing is not compiled right now. I
would have liked to make it compile, but I don't care that much (and
they don't either) ..

> So we have a bit of a stalemate here -- the current Qualcomm team
> wants to avoid having to deal too much with the legacy platforms --
> they are technically quite different from the current platforms and
> the divergence makes it hard to deal with supporting it all in a
> modern way without risking regressions. I tend to agree with them.

Oh what a sob story .. They can't claim to maintain msm except for the
parts they don't like that much, thats not how it works. If you
have a technical reason why you think hard to maintain code is
"hard to deal with", please put that forth .

If they want they can start submitting their patches to me, and I can
deal with their "hard to deal with" stuff..

> Just like omap split between omap1 and omap2plus, I think it's a time
> to create a mach-qcom instead, and move the modern (v7, most likely)
> platforms there -- enable them with device tree, modern framework
> infrastructure, etc. That way you can keep older platforms in mach-msm
> without risk of regressions, and they have a clean base to start on
> with their later platforms.

Personally I think splitting mach- stuff isn't very useful or
interesting.. There's just no technical reason for it, for example x86
and x86_64 was a win from my perspective , there's a lot more reason to
keep similar things together than to split things up.

The whole risking regressions, do you have proof of why you think that's
happening ? The inverse seems more likely..

Daniel

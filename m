From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 30 Oct 2013 16:08:27 -0700
Subject: [PATCH 2/4] ARM: msm: Remove 7x00 support
In-Reply-To: <CAOesGMhg8HN4Su9FXSeoAgmH6NVKXW+wmnreUvWH+1G6GWkkaA@mail.gmail.com>
 (Olof Johansson's message of "Tue, 29 Oct 2013 08:37:28 -0700")
References: <1382993006-27359-1-git-send-email-davidb@codeaurora.org>
 <1382993006-27359-3-git-send-email-davidb@codeaurora.org>
 <20131029132043.GA28165@fifo99.com>
 <CAOesGMhg8HN4Su9FXSeoAgmH6NVKXW+wmnreUvWH+1G6GWkkaA@mail.gmail.com>
Message-ID: <87ob66nyqc.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> I would be very happy to take more code for the older Qualcomm chipset
> to enable full functionality for them, but it's been my impression
> that far from all that is needed to make it a useful platform is in
> the upstream kernel, and there's been no signs of more of it showing
> up at least in the last two years.
>
> So we have a bit of a stalemate here -- the current Qualcomm team
> wants to avoid having to deal too much with the legacy platforms --
> they are technically quite different from the current platforms and
> the divergence makes it hard to deal with supporting it all in a
> modern way without risking regressions. I tend to agree with them.

As do I.

> Just like omap split between omap1 and omap2plus, I think it's a time
> to create a mach-qcom instead, and move the modern (v7, most likely)
> platforms there -- enable them with device tree, modern framework
> infrastructure, etc. That way you can keep older platforms in mach-msm
> without risk of regressions, and they have a clean base to start on
> with their later platforms.

I think this split approach is a good compromise.

If the maintainers of the current older platforms wish to bring them up
to modern frameworks, we can consider combining again.  If not, they the
older platforms will take the same path as the rest of the older
platforms that slowly fade away.

Kevin

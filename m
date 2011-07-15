From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jul 2011 15:06:29 +0200
Subject: [GIT PULL] Tegra updates for v3.1
In-Reply-To: <CAMbhsRQoZ7vJGchkXLUOrOH4rpKJzJe-iGvLjTfBmz4R=8HtVw@mail.gmail.com>
References: <CAMbhsRQoZ7vJGchkXLUOrOH4rpKJzJe-iGvLjTfBmz4R=8HtVw@mail.gmail.com>
Message-ID: <201107151506.29281.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 July 2011, Colin Cross wrote:
> Please pull Tegra updates from:
> 
> git://android.git.kernel.org/kernel/tegra.git for-next
> 
> Mostly peripheral support in existing boards, but also a few fixes and
> code reduction.
> 

Hi Colin,

I've browsed over the patches, and I had the impression that there are
still a number of issues that should be resolved before I pull this.

Specifically, what I noticed is:

* The cpufreq driver should now live in drivers/cpufreq/
* The DMA driver uses its own interface instead of the regular
  dma-engine API. I don't want to merge any more drivers like this.
* The legacy-irq code is essentially dead code, it's not being used
  anywhere. My impression is that it would need to look differently
  if you actually want to use it.
* The pinmux code is getting largely replaced with new code, but
  the new version does not use the new pinmux API from Linus Walleij.
* The commit named "[ARM] tegra: clock: Add dvfs support, bug fixes,
  and cleanups" puts a lot of stuff into a single patch that doesn't
  even belong into the same pull request.

I would very much like to at least pull the cleanups and bug fixes,
but it doesn't work like this, sorry.

Please remove the controversial patches and submit separate pull
requests for the bug fixes and cleanups. It's probably a good idea
to also  have the patches that add features reviewed on the mailing
lists again and then decide how to proceed with each one..

	Arnd

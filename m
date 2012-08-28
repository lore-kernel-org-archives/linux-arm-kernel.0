From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 Aug 2012 13:45:02 -0700
Subject: [GIT PULL] msm fixes for v3.6
In-Reply-To: <20120828165532.GA20947@codeaurora.org>
References: <20120828165532.GA20947@codeaurora.org>
Message-ID: <20120828204502.GA24149@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 28, 2012 at 09:55:32AM -0700, David Brown wrote:
> The following changes since commit 28a33cbc24e4256c143dce96c7d93bf423229f92:
> 
>   Linux 3.5 (2012-07-21 13:58:29 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-fix-for3.6
> 
> for you to fetch changes up to e7501de53aa1a551526872f6c95901a00705f942:
> 
>   ARM: msm: Remove call to missing FPGA init on 8660 (2012-08-28 09:39:28 -0700)
> 
> ----------------------------------------------------------------
> Fixes for two problems with MSM:
> 
>   - Mapping issue on 7x00 targets.
>   - Compilation problems with devicetree on 8660.

Thanks for using a tag with a description of the pull request contents,
but it seems like you're missing a bit here -- it has a patch for the dtbs
target, and the handle_irq fix isn't technically breaking compilation,
I believe?

> ----------------------------------------------------------------
> David Brown (1):
>       ARM: msm: Remove call to missing FPGA init on 8660

So, this seems to be breaking builds, seems appropriate as a fix.

> Rohit Vaswani (2):
>       ARM: msm: io: Remove 7x30 iomap region from 7x00
>       ARM: msm: io: Change the default static iomappings to be shared

These two patches lack your Signed-off-by, even though you seem to have been
the committer. Please add it.

But also, it's not clear to me if the second of the two patches actually causes
problems, or if it's just that the mapping won't be reused from the static
range. If it's the latter, then I'd say it's 3.7 material instead. Also see my
separate comment on the posted patch about the format of it.

> Stephen Boyd (2):
>       ARM: msm: Add handle_irq handler for 8660 DT machine

Clearly a bug fix, no problem.

>       ARM: msm: Add msm8660-surf.dts to Makefile.boot

This one looks like 3.7 material.


-Olof

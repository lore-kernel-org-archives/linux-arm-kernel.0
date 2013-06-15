From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 18:26:17 -0700
Subject: [GIT PULL 2/3] msm fixes for 3.11
In-Reply-To: <1371232615-30731-4-git-send-email-davidb@codeaurora.org>
References: <1371232615-30731-1-git-send-email-davidb@codeaurora.org>
 <1371232615-30731-4-git-send-email-davidb@codeaurora.org>
Message-ID: <20130615012617.GU18124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 10:56:55AM -0700, David Brown wrote:
> The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:
> 
>   Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-fix-for-3.11
> 
> for you to fetch changes up to 7ba655fc965b073292349fa49fb9d16d701185bc:
> 
>   gpio: msm-v1: Remove errant __devinit to fix compile (2013-06-12 14:49:06 -0700)
> 
> ----------------------------------------------------------------
> Some minor fixes for MSM for 3.11
> 
> I don't expect these to be necessary for stable, since the fixes are
> to recently added code.  The strncpy fix is only in debug code that
> isn't normally compiled or used (and is being removed in upcoming
> patches).
> 
> ----------------------------------------------------------------
> Chen Gang (1):
>       arch: arm: mach-msm: using strlcpy instead of strncpy
> 
> Stephen Boyd (3):
>       ARM: dts: msm: Fix bad register addresses

Hmm. I see that the msm-hsuart device nodes completely lack reg entries. That's
considerably more important to fix than the cosmetic unit address that's not
even needed unless two nodes happen to have the same name.

I ended up pulling this in underneath of the cleanup branch to resolve the
add/change conflicts there. 

-Olof

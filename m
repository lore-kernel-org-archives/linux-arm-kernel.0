From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Dec 2017 17:04:35 -0800
Subject: [GIT PULL] revert ARM SCPI changes for v4.15-rc1
In-Reply-To: <7hlgimns2m.fsf@baylibre.com>
References: <7hlgimns2m.fsf@baylibre.com>
Message-ID: <20171203010435.6ycn75rxss5yiixe@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 11:53:05AM -0800, Kevin Hilman wrote:
> Arnd, Olof,
> 
> These ARM SCPI changes caused SCPI regressions resulting in CPUfreq
> failures on most Amlogic SoCs (found by kernelci.org.)
> 
> Unfortunately, this was not caught in linux-next due to other
> bugs/panics on these platforms masking this problem so we've only found
> it since we've fixed the other issues.
> 
> Since we're already in the -rc cycle, I'd prefer to revert to a known
> working state (that of v4.14) rather than finding/reverting a subset,
> which would just lead to another untested state.
> 
> These changes can then have some time to be better reviewed and tested
> and resubmitted for v4.16.
> 
> I've tested this revert on the affect Amlogic SoCs and verified that
> we're back to the previous (working) condition.
> 
> Also, I'm sending the pull directly to arm-soc instead of Sudeeep
> because I understand that Sudeep is currently out-of-office and unlikely
> to be able to address this himself during the -rc cycle.
> 

Sounds like the right approach here. I've merged this and added the above text
to the merge commit as well.


-Olof

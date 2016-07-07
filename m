From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Jul 2016 22:28:27 -0700
Subject: [GIT PULL] STi DT updates for v4.8
In-Reply-To: <5776701A.1000808@st.com>
References: <5776701A.1000808@st.com>
Message-ID: <20160707052827.GL32389@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrice,


On Fri, Jul 01, 2016 at 03:28:58PM +0200, Patrice Chotard wrote:
> Hi Olof, Arnd and Kevin,
> 
> Please consider this first round of STi DT updates for v4.8:
> 
> The following changes since commit 6ca59e6e1fc3a8d7ccbf85ff036bd6ff40847c1a:
> 
>   clk: st: clkgen-pll: Detect critical clocks (2016-06-30 12:17:11 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
> sti-dt-for-v4.8

This specifies a branch, not a tag.

> 
> for you to fetch changes up to 4543976eaf9ca9f379ac3a0bb8c5c8c84fe0a965:
> 
>   spi: st-ssc4: Remove 'no clocking' hack (2016-07-01 11:58:10 +0200)
> 
> ----------------------------------------------------------------
> Highlights:
> -----------
>  -add STi critical clocks
> - as discussed on IRC with Lee Jones, remove SPI hack wich has dependecy
> with critical clocks
> 
> ----------------------------------------------------------------
> Lee Jones (3):
>       ARM: sti: stih407-family: Supply defines for CLOCKGEN A0
>       ARM: sti: stih410-clocks: Identify critical clocks
>       spi: st-ssc4: Remove 'no clocking' hack

THere are more patches than this in this branch -- there are three clock
branches that by the look of it have been applied by Stephen Boyd.

However, since they have been brought in without doing a merge, it's hard for
us to tell where they came form, and/or if they're in a shared branch
somewhere. Therefore, I recommend doing a --no-ff merge of the branch, so it's
obvious from the merge commit where they came form. They also need to be part
of the diffstat.

Finally, the clk patch doesn't really belong in the DT branch here. It's
probably a suitable patch to send to the clk maintainers after the DT changes
have gone in, i.e. for 4.9.

Please respin this pull request and we'll take another look! 


Thanks,

-Olof

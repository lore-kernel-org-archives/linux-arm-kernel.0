From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 15:23:56 +0200
Subject: [GIT PULL 2/3] ARM: berlin: DT changes for v4.4 (round 1)
In-Reply-To: <561F9F24.1050801@gmail.com>
References: <1444416494-3117-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <6053924.4novCdxIMG@wuerfel> <561F9F24.1050801@gmail.com>
Message-ID: <5441220.dfRGQN11VB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 14:42:12 Sebastian Hesselbarth wrote:
> On 14.10.2015 17:44, Arnd Bergmann wrote:
> > On Friday 09 October 2015 20:48:13 Sebastian Hesselbarth wrote:
> >> this is round 1 of Marvell Berlin DT changes for v4.4. There is
> >> some improvement in serial aliases/stdout path, cpufreq properties,
> >> and PWM nodes for all SoCs. The cpufreq properties depend on cpuclk
> >> being available, therefore this branch has a dependency with the
> >> cpuclk topic PR sent earlier.
> >>
> >
> > Pulled into next/dt, thanks!
> 
> Hi Arnd,
> 
> the prerequisite cpuclk topic branch didn't make it into arm-soc causing
> a build failure on bg2q dts files.
> 
> Unfortunately, cpuclk topic branch touches both, dt-includes and driver
> code. I was hoping you could also pull the topic branch with berlin/dt.
> 
> I am open for suggestions how to deal with it now and in the future.

Oops, I should have checked this better. In general, you should never
submit a branch that does not by itself build and work. Even if I had
merged your other pull request into the next/drivers branch, I would
still have a broken next/dt branch that I could not submit to Linus.

Can you create a pull request with just one patch that adds the
CLKID_CPU definition so I can merge that into next/dt to get a working
branch again?

After that, please rebase the "clk: berlin: add cpuclk" patch on top
of this one, so we can avoid conflicting commits.

Regarding the MAX_CLKS definition, please leave that out of the
dt-bindings header, it doesn't really belong in there as it has
no significance to the dts files and its definition apparently is
not stable.

	Arnd

From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 24 Aug 2017 11:52:24 -0700
Subject: [GIT PULL] bcm2835-soc-next-2017-08-24
In-Reply-To: <20170824184259.24537-1-eric@anholt.net>
References: <20170824184259.24537-1-eric@anholt.net>
Message-ID: <1ce1c89c-eca6-a329-5925-c09d0880d17f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2017 11:42 AM, Eric Anholt wrote:
> Hi Florian,
> 
> Here's the new PR for the soc-next code, with the rewrite so that we
> can drop the DT merge.  I think we can rewind soc-next to 4.13-rc1 and
> merge this instead.
> 
> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
> 
>   Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-soc-next-2017-08-24
> 
> for you to fetch changes up to b37f5361d22ab867fa6519a7f06b416cd46aee6c:
> 
>   ARM: bcm2836: Send event when onlining other cores (2017-08-24 11:31:55 -0700)
> 
> ----------------------------------------------------------------
> This pull request brings in a move of the bcm2836/7 SMP init code from
> the irqchip driver to platsmp.c (general move acked by the maintainer,
> v2 of the patch including a squashed in fix to prevent a dependency on
> updated DT compatibles) and an added sev() to wake up the secondary
> CPUs on newer firmware.  It also garbage collects some stub clock code
> from before we had a proper clock driver, which has been acked by the
> clk maintainers to go through the ARM trees.
> 
> ----------------------------------------------------------------
> Danilo Krummrich (1):
>       clk: bcm2835: remove remains from stub clk driver
> 
> Phil Elwell (1):
>       ARM: bcm2836: Send event when onlining other cores
> 
> Stefan Wahren (1):
>       irqchip: bcm2836: Move SMP startup code to arch/arm (v2)

Merged! Thanks for the quick turn around, I will get that submitted in a
few minutes.
-- 
Florian

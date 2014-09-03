From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 03 Sep 2014 10:03:39 -0700
Subject: [PATCH V2 0/4] clk: mvebu: Improve clock drift
In-Reply-To: <902cee907da9c532822dcf5db722b47c@doppler.thel33t.co.uk>
References: <1409645719-20003-1-git-send-email-gregory.clement@free-electrons.com>
 <902cee907da9c532822dcf5db722b47c@doppler.thel33t.co.uk>
Message-ID: <20140903170339.11368.17168@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Leigh Brown (2014-09-03 07:40:56)
> On 2014-09-02 09:15, Gregory CLEMENT wrote:
> > Few users reported a timer drift on the Armada 370 based board such as
> > the mirabox or the Netgear ReadyNAS 102. This is the second series
> > with few improvements after the review of the 1st version.
> > 
> > The reason is that when the SSCG (Spread Spectrum Clock Generator) is
> > enabled, it shifts the frequency of the clock. The percentage is no
> > more than 1% but when the clock is used for a timer it leads to a
> > clock drift.
> > 
> > This series allows to correct the affected clock when the SSCG is
> > enabled. This drift can happen on all the mvebu SoC on the cpu clock
> > block (ie cpu, ddr and l2 cache). Currently the only notable effect is
> > for the Armada 370 because this SoC use the l2cache clock as source
> > for the timer. That's why even if the series allow any of the mvebu
> > SoC to benefit to this correction, Armada 370 is the only user of it.
> > 
> > The first 2 patches should go through the clk subsystem, whereas the
> > third one should go to the arm-soc through the mvebu tree.
> > 
> > The last one is just to fix a typo I found while I was reading the clk
> > code.
> 
> This is working superbly for me on my Mirabox, and ntpd is now 
> completely stable.
> 
> Tested-by: Leigh Brown <leigh@solinno.co.uk>
> 

Clock patches look good to me.

Regards,
Mike

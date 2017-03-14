From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 14 Mar 2017 11:27:17 +0100
Subject: [PATCH v2] ARM: at91: pm: cpu_idle: switch DDR to power-down mode
In-Reply-To: <20170314083804.1756-1-nicolas.ferre@microchip.com>
References: <20170314083804.1756-1-nicolas.ferre@microchip.com>
Message-ID: <20170314102717.itygahokl7xlr62u@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/2017 at 09:38:04 +0100, Nicolas Ferre wrote:
> On some DDR controllers, compatible with the sama5d3 one,
> the sequence to enter/exit/re-enter the self-refresh mode adds
> more constrains than what is currently written in the at91_idle
> driver. An actual access to the DDR chip is needed between exit
> and re-enter of this mode which is somehow difficult to implement.
> This sequence can completely hang the SoC. It is particularly
> experienced on parts which embed a L2 cache if the code run
> between IDLE calls fits in it...
> 
> Moreover, as the intention is to enter and exit pretty rapidly
> from IDLE, the power-down mode is a good candidate.
> 
> So now we use power-down instead of self-refresh. As we can
> simplify the code for sama5d3 compatible DDR controllers,
> we instantiate a new sama5d3_ddr_standby() function.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: <stable@vger.kernel.org> # v4.1+
> Fixes: 017b5522d5e3 ("ARM: at91: Add new binding for sama5d3-ddramc")

Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

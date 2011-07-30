From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Jul 2011 13:07:40 +0100
Subject: [PATCH 07/18] dmaengine/amba-pl08x: Enable/Disable amba_pclk
	with channel requests
In-Reply-To: <96781d46e41fa6ffc04b88527a25d73f5a59eda8.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<96781d46e41fa6ffc04b88527a25d73f5a59eda8.1311936524.git.viresh.kumar@st.com>
Message-ID: <20110730120740.GA15791@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 04:19:17PM +0530, Viresh Kumar wrote:
> Amba devices have interface clocks attached as adev->pclk. This is the only
> clock associated with DMAC and it can be disabled when DMAC is not in use. This
> patch adds support to enable/disable this clk as and when channels are requested
> and freed. Also it disables this clock at the end of probe.

It may make better sense to convert this to runtime PM.  I suspect
that there's core support which the amba/bus.c can do to help in that
respect (eg, managing the apb pclk itself) so that we don't have to
add the same code to every primecell driver.

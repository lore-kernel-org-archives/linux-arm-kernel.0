From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Aug 2015 13:40:43 +0100
Subject: [PATCH] ARM: enable imprecise aborts during early kernel startup
In-Reply-To: <1440501845-25723-1-git-send-email-l.stach@pengutronix.de>
References: <1440501845-25723-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20150825124042.GR7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 01:24:05PM +0200, Lucas Stach wrote:
> From: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> This patch adds imprecise abort enable/disable macros and uses them to
> enable imprecise aborts early when starting the kernel.
> 
> This helps in tracking down the real cause for such imprecise abort, as
> they are handled as soon as they occur. Until now those aborts would
> only be enabled when entering the userspace and as a consequence crash
> the first userspace process if any abort had been raised during kernel
> startup.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Looks fine to me.  I think as we know Keystone2 definitely has issues
with this, I'd like to delay it to the v4.4 merge window, but please
consider putting it in the patch system anyway so it doesn't get
forgotten about.  I'll queue it after 4.3-rc1 is out.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

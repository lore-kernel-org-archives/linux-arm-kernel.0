From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jun 2016 10:49:14 +0100
Subject: [PATCH] ARM: sti: Implement dummy L2 cache's write_sec
In-Reply-To: <1467106837-20996-1-git-send-email-patrice.chotard@st.com>
References: <1467106837-20996-1-git-send-email-patrice.chotard@st.com>
Message-ID: <20160628094914.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 11:40:37AM +0200, patrice.chotard at st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This patch implements the write_sec callback that handle PL310
> secure registers writes.
> This callback is just a stub for now, to avoid system crash.
> Later, it could handle SMC calls so that TZ handles the needed writes.

Is there much point having the L2 cache DT node enabled if you have
no support for the writes, which are required for the hardware to be
enabled?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

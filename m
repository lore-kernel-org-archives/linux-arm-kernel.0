From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Feb 2015 22:58:53 +0000
Subject: [PATCH v2] coresight-stm: adding driver for CoreSight STM
 component
In-Reply-To: <CAL_Jsq+JYc5DBXqEcpJ0O=RdO-uuz_-GR99YsgVqT=uG6CLqJg@mail.gmail.com>
References: <1424907152-18808-1-git-send-email-mathieu.poirier@linaro.org>
 <CAL_Jsq+JYc5DBXqEcpJ0O=RdO-uuz_-GR99YsgVqT=uG6CLqJg@mail.gmail.com>
Message-ID: <20150226225853.GM8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 04:24:53PM -0600, Rob Herring wrote:
> We really shouldn't do private implementation here. It there really
> any reason not to allow readq/writeq generically for 32-bit or just
> for arm32?

My argument has always been that drivers should do the emulation of
64-bit accesses when there is no native support.

IO registers tend to have side effects when read/written.  How do we
know whether the low-half or the high-half should be written first?
This isn't something that an architecture can really dictate.  What
may be right for one hardware device may not be correct for another.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

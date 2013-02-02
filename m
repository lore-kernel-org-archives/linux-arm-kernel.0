From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 3 Feb 2013 00:49:20 +0100
Subject: [PATCH v2 2/2] ARM: kirkwood: fix to retain gbe MAC addresses
 for DT kernels
In-Reply-To: <1359577799-23351-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20130130183049.GR7717@titan.lakedaemon.net>
 <1359577799-23351-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130202234919.GB17361@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian, Jason,

On Wed, Jan 30, 2013 at 09:29:58PM +0100, Sebastian Hesselbarth wrote:
> The ethernet controller used on kirkwood looses its MAC address
> register contents when the corresponding clock is gated. As soon as
> mv643xx_eth is built as module, the clock gets gated and when loading
> the module, the MAC address is gone.
> 
> Proper DT support for the mv643xx_eth driver is expected soon, so we add
> a workaround to always enable ge0/ge1 clocks on kirkwood. This workaround
> is also already used on non-DT kirkwood kernels.
> 
> Reported-by: Simon Baatz <gmbnomis@gmail.com>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Tested this on IB-NAS6210 (kirkwood, single GBE interface). Using
mv643xx_eth as a module works again now and yields

# cat /sys/kernel/debug/clk/tclk/ge[01]/clk_enable_count 
2
1

as expected.

- Simon

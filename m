From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Aug 2014 16:17:14 +0100
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140802144925.GJ3952@lukather>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
 <20140731115628.GQ8181@intel.com> <20140731162330.GE3952@lukather>
 <20140801171306.GF8181@intel.com> <20140802144925.GJ3952@lukather>
Message-ID: <20140802151714.GB30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 02, 2014 at 04:49:25PM +0200, Maxime Ripard wrote:
> In the case of the call to device_control, especially in the
> DMA_SLAVE_CONFIG case, but that also applies to pause/resume, are the
> changes supposed to be immediates or can they happen later?

pause/resume are expected to operate synchronously on the channel.
When asking for the channel to pause, the channel must be stopped
before the call returns.

In the case of channel configuration, that should have no effect on
any previously queued transfer - in other words, changing the channel
configuration only has an effect when subsequent transactions are
prepared.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

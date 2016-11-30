From: davem@davemloft.net (David Miller)
Date: Tue, 29 Nov 2016 19:38:53 -0500 (EST)
Subject: [PATCH net-next v3 0/4] Fix OdroidC2 Gigabit Tx link issue
In-Reply-To: <1480326409-25419-1-git-send-email-jbrunet@baylibre.com>
References: <1480326409-25419-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <20161129.193853.827524417068912706.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 28 Nov 2016 10:46:45 +0100

> This patchset fixes an issue with the OdroidC2 board (DWMAC + RTL8211F).
> The platform seems to enter LPI on the Rx path too often while performing
> relatively high TX transfer. This eventually break the link (both Tx and
> Rx), and require to bring the interface down and up again to get the Rx
> path working again.
> 
> The root cause of this issue is not fully understood yet but disabling EEE
> advertisement on the PHY prevent this feature to be negotiated.
> With this change, the link is stable and reliable, with the expected
> throughput performance.
> 
> The patchset adds options in the generic phy driver to disable EEE
> advertisement, through device tree. The way it is done is very similar
> to the handling of the max-speed property.

Patches 1-3 applied to net-next, thanks.

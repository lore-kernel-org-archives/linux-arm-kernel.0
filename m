From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Mar 2016 12:38:39 +0000
Subject: [PATCH 1/2] serial: amba-pl011: make platform driver generic
In-Reply-To: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
Message-ID: <20160322123839.GO19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 09:51:21AM +0800, Jun Nie wrote:
> make sbsa uart platform driver more generic so that platform
> driver code can be reused by ZTE uart platform driver.

I think it's known that I don't like the platform driver in here, and
I'm less than happy seeing it get extended.  Can we try to come up with
a better solution which allows ZTE to use the AMBA bus support while
still allowing it to be properly detected?

The reason is that the platform bus behaves in a completely different
way to the amba bus - platform bus does no runtime PM support whereas
amba bus does, and I don't want to see that difference eventually
impacting on this driver.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

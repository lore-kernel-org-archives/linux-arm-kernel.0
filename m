From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Apr 2016 09:40:34 +0100
Subject: [PATCH v7 1/2] drivers: base: add support for registering
 notifier about deferred probe
In-Reply-To: <570F4886.20203@samsung.com>
References: <1460540160-18762-1-git-send-email-m.szyprowski@samsung.com>
 <1460540160-18762-2-git-send-email-m.szyprowski@samsung.com>
 <20160413141254.GB12749@kroah.com> <570F4886.20203@samsung.com>
Message-ID: <20160414084034.GR19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 09:36:38AM +0200, Marek Szyprowski wrote:
> This CID/PID reading has to be done during device registration time because
> of the already deployed userspace ABI. CID/PID values are reported to
> userspace, which might rely on them to load proper driver modules.

There is no "might" about it - the CID/PID are the way drivers get
matched, and it's what is in the module device tables exported for
modprobe/udev to use.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

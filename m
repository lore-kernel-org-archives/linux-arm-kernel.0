From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Aug 2015 10:44:30 +0100
Subject: [PATCH v3 5/8] ARM: mediatek: add smp bringup code for MT6580
In-Reply-To: <1438696464-59858-6-git-send-email-scott.shu@mediatek.com>
References: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
 <1438696464-59858-6-git-send-email-scott.shu@mediatek.com>
Message-ID: <20150805094429.GU7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 04, 2015 at 09:54:21PM +0800, Scott Shu wrote:
> Add support for cpu enable-method "mediatek,mt6580-smp" for booting
> secondary CPUs on MT6580.

If you have CPU power domain support, and you power up and power down the
CPUs, why do you need the boot_lock and pen_release stuff?  Isn't keeping
the power off on a CPU sufficient to prevent it entering the kernel?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

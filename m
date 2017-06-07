From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Jun 2017 10:33:50 +0100
Subject: [PATCH] Revert "ARM: 8433/1: add a VMSPLIT_3G_OPT config option"
In-Reply-To: <1496825972-26829-1-git-send-email-xieyisheng1@huawei.com>
References: <1496825972-26829-1-git-send-email-xieyisheng1@huawei.com>
Message-ID: <20170607093350.GJ4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 04:59:32PM +0800, Yisheng Xie wrote:
> This reverts commit 63ce446c9b5787a94ed875bab20772e1a2b3092f.

There's no real reason to revert this, thereby removing it from non-LPAE
cases where it does work.  You've already shown adding a dependency for
LPAE on this option (or even vice versa) is enough to stop the problem
occuring.

IMHO, It would be better to make VMSPLIT_3G_OPT depend on !ARM_LPAE.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

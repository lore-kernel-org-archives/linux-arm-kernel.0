From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Sep 2014 10:47:47 +0100
Subject: [PATCH 1/2] gpio: Add driver for AXM55xx SSP chip selects
In-Reply-To: <1409576021-24828-2-git-send-email-anders.berg@avagotech.com>
References: <1409576021-24828-1-git-send-email-anders.berg@avagotech.com>
 <1409576021-24828-2-git-send-email-anders.berg@avagotech.com>
Message-ID: <20140905094747.GE30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 02:53:40PM +0200, Anders Berg wrote:
> The AXM55xx device has a ARM PL022 SSP controller with an extension that
> enables the control of up to five chip select signals. This driver implements
> the logic to control these signals and exports them as GPIOs.
> 
> Signed-off-by: Anders Berg <anders.berg@avagotech.com>

So, what happens if the GPIO driver binds first, followed by the SSP
device?  Please test that scenario out before this patch gets merged.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

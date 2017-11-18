From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Nov 2017 08:21:22 +0000
Subject: [PATCH 5/10 v2] Input: cpcap-pwrbutton: Handle return value of
 platform_get_irq
In-Reply-To: <ae8e2bcc48ceeb7cf04f4ec19e7cc76d51fcf58f.1510952504.git.arvind.yadav.cs@gmail.com>
References: <ae8e2bcc48ceeb7cf04f4ec19e7cc76d51fcf58f.1510952504.git.arvind.yadav.cs@gmail.com>
Message-ID: <20171118082122.GB31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 18, 2017 at 02:36:53AM +0530, Arvind Yadav wrote:
> platform_get_irq() can fail here and we must check its return value.

The test should be <= 0, and you need to return an error code for the
0 case.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jul 2015 22:43:54 +0200
Subject: [PATCH] ARM: BCM: Restrict Broadcom BCM470X / BCM5301X to non-LPAE
In-Reply-To: <1436897535-3782-1-git-send-email-f.fainelli@gmail.com>
References: <1436897535-3782-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <4793510.M34v5PmKgi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 July 2015 11:12:15 Florian Fainelli wrote:
> Cortex-A9 on at least BCM4708 SoCs are not LPAE capable, booting such a
> kernel will result in the following:
> 
> Error: Kernel with LPAE support, but CPU does not support LPAE.
> 
> Restrict such SoCs to be built in a configuration that does not enable
> ARM_LPAE.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 

This is an old problem for all platforms, I think we want a more
generic solution though, instead of adding the !LPAE dependency
for each Cortex-A5/8/9 platform.

	Arnd

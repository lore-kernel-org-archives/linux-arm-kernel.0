From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Mar 2012 09:58:50 -0700
Subject: [PATCH/RFC 2/2] arm/tegra: add timeout to PCIe PLL lock detection
 loop
In-Reply-To: <1331023544-6439-3-git-send-email-mad_soft@inbox.ru>
References: <1331023544-6439-1-git-send-email-mad_soft@inbox.ru>
 <1331023544-6439-3-git-send-email-mad_soft@inbox.ru>
Message-ID: <4F56424A.3020305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2012 01:45 AM, Dmitry Artamonow wrote:
> Tegra PCIe driver waits for PLL to lock using busy loop.
> If PLL fails to lock for some reason, this leads to silent lockup
> while booting (as PCIe code is not modular).
> 
> Fix by adding timeout, so if PLL doesn't lock in a couple
> of seconds, just PCIe driver fails and machine continues to boot.
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

That seems reasonable. So once the mdelay discussion is resolved,

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Any idea why the PLL doesn't lock sometimes?

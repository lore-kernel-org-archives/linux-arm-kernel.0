From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 6 Mar 2012 20:09:12 +0100
Subject: [PATCH/RFC 2/2] arm/tegra: add timeout to PCIe PLL lock
 detection loop
In-Reply-To: <4F56424A.3020305@wwwdotorg.org>
References: <1331023544-6439-1-git-send-email-mad_soft@inbox.ru>
 <1331023544-6439-3-git-send-email-mad_soft@inbox.ru>
 <4F56424A.3020305@wwwdotorg.org>
Message-ID: <20120306190912.GA13882@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 03/06/2012 01:45 AM, Dmitry Artamonow wrote:
> > Tegra PCIe driver waits for PLL to lock using busy loop.
> > If PLL fails to lock for some reason, this leads to silent lockup
> > while booting (as PCIe code is not modular).
> > 
> > Fix by adding timeout, so if PLL doesn't lock in a couple
> > of seconds, just PCIe driver fails and machine continues to boot.
> > 
> > Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> 
> That seems reasonable. So once the mdelay discussion is resolved,
> 
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> 
> Any idea why the PLL doesn't lock sometimes?

I've seen this happen when the 1.05V regulator (GPIO#2 of the PMU on Harmony)
isn't enabled.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/187b2856/attachment.sig>

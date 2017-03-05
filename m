From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 6 Mar 2017 00:07:41 +0100
Subject: [PATCH] Revert "ARM: at91/dt: sama5d2: Use new compatible for
 ohci node"
In-Reply-To: <20170217151250.8572-1-romain.izard.pro@gmail.com>
References: <20170217151250.8572-1-romain.izard.pro@gmail.com>
Message-ID: <20170305230741.f2hq3iiwgakhsynl@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/2017 at 16:12:50 +0100, Romain Izard wrote:
> This reverts commit cab43282682e ("ARM: at91/dt: sama5d2: Use new
> compatible for ohci node")
> 
> It depends from commit 7150bc9b4d43 ("usb: ohci-at91: Forcibly suspend
> ports while USB suspend") which was reverted and implemented
> differently. With the new implementation, the compatible string must
> remain the same.
> 
> The compatible string introduced by this commit has been used in the
> default SAMA5D2 dtsi starting from Linux 4.8. As it has never been
> working correctly in an official release, removing it should not be
> breaking the stability rules.
> 
> Fixes: cab43282682e ("ARM: at91/dt: sama5d2: Use new compatible for ohci node")
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> cc: <stable@vger.kernel.org>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

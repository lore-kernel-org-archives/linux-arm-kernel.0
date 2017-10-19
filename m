From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Oct 2017 13:34:53 +0100
Subject: [PATCH 03/11] arm: Kconfig: enable KASan
In-Reply-To: <a3902e32-0141-9616-ba3e-9cbbd396b99a@gmail.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-4-liuwenliang@huawei.com>
 <a3902e32-0141-9616-ba3e-9cbbd396b99a@gmail.com>
Message-ID: <20171019123453.GV20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 12:15:44PM -0700, Florian Fainelli wrote:
> On 10/11/2017 01:22 AM, Abbott Liu wrote:
> > From: Andrey Ryabinin <a.ryabinin@samsung.com>
> > 
> > This patch enable kernel address sanitizer for arm.
> > 
> > Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
> > Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
> 
> This needs to be the last patch in the series, otherwise you allow
> people between patch 3 and 11 to have varying degrees of experience with
> this patch series depending on their system type (LPAE or not, etc.)

As the series stands, if patches 1-3 are applied, and KASAN is enabled,
there are various constants that end up being undefined, and the kernel
build will fail.  That is, of course, not acceptable.

KASAN must not be available until support for it is functionally
complete.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

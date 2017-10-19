From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Oct 2017 13:55:52 +0100
Subject: [PATCH 09/11] Don't need to map the shadow of KASan's shadow
 memory
In-Reply-To: <20171011082227.20546-10-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-10-liuwenliang@huawei.com>
Message-ID: <20171019125552.GB20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 04:22:25PM +0800, Abbott Liu wrote:
>  Because the KASan's shadow memory don't need to track,so remove the
>  mapping code in kasan_init.

Is there a reason why this isn't part of the earlier patch that
introduced the code below?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

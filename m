From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Oct 2017 13:43:57 +0100
Subject: [PATCH 04/11] Define the virtual space of KASan's shadow region
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C005CAC2@dggemm510-mbx.china.huawei.com>
References: <20171011082227.20546-5-liuwenliang@huawei.com>
 <201710141957.mbxeZJHB%fengguang.wu@intel.com>
 <B8AC3E80E903784988AB3003E3E97330C005B9BF@dggemm510-mbx.china.huawei.com>
 <CAKv+Gu98M9PZk3qm0PYC8nQ3zMvLZmNmOn4=hNdFE7NTBuHbgg@mail.gmail.com>
 <B8AC3E80E903784988AB3003E3E97330C005CAC2@dggemm510-mbx.china.huawei.com>
Message-ID: <20171019124357.GY20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 11:27:19AM +0000, Liuwenliang (Lamb) wrote:
> ---c0a3b198:       b6e00000        .word   0xb6e00000   //TASK_SIZE:0xb6e00000

It's probably going to be better all round to round TASK_SIZE down
to something that fits in an 8-bit rotated constant anyway (like
we already guarantee) which would mean this patch is not necessary.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

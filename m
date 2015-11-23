From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 23 Nov 2015 10:17:03 -0800
Subject: [PATCH] ARM: dts: keystone: k2l: fix kernel crash when
 clk_ignore_unused is not in bootargs
In-Reply-To: <1448297649-22122-1-git-send-email-m-karicheri2@ti.com>
References: <1448297649-22122-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <5653581F.4060902@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2015 8:54 AM, Murali Karicheri wrote:
> Currently kernel crash randomly when K2L EVM is booted without
> clk_ignore_unused in the bootargs. This workaround is not needed
> on other K2 devices such as K2HK and K2E and with this fix, we can
> remove the workaround altogether. netcp driver on K2L uses linked
> ram on OSR (On chip Static RAM) and requires the clock to this peripheral
> enabled for proper functioning. This is the reason for the kernel crash.
> So add the clock node to fix this issue.
>
> While at it, remove the workaround documentation as well.
>
> With the fix applied, clk_summary dump shows the clock to OSR enabled.
>
> cat /sys/kernel/debug/clk/clk_summary
>   ------cut--------------
>     tcp3d-1                   0            0   399360000          0 0
>     tcp3d-0                   0            0   399360000          0 0
>     osr                       1            1   399360000          0 0
>     fftc-0                    0            0   399360000          0 0
>   -----cut----------------
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
Nice !!
I will queue this up for fixes. Thanks.

Regards,
Santosh

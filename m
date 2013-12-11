From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 11 Dec 2013 09:24:35 +0000
Subject: [PATCH 1/3] mfd: always assign of_node in mfd_add_device()
In-Reply-To: <1386626809-6251-1-git-send-email-swarren@wwwdotorg.org>
References: <1386626809-6251-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131211092435.GC16780@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Stephen Warren <swarren@nvidia.com>
> 
> mfd_add_device() assigns .of_node in the device objects it creates only
> if the mfd_cell for the device has the .of_compatible field set and the
> DT node for the top-level MFD device contains a child whose compatible
> property matches the cell's .of_compatible field.
> 
> This leaves .of_node unset in many cases. When this happens, entries in
> the DT /aliases property which refer to the top-level MFD DT node will
> never match the MFD child devices, hence causing the requested alias not
> to be honored.
> 
> Solve this by setting each MFD child device's .of_node equal to the top-
> level MFD device's .of_node field in the cases where it would otherwise
> remain unset.
> 
> The first use-case for this will be aliases for the TPS6586x's RTC
> device.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  drivers/mfd/mfd-core.c | 2 ++
>  1 file changed, 2 insertions(+)

I've tentatively applied this patch, but if it starts to cause more
problems than it solves we'll have to endeavour to find a different
solution.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

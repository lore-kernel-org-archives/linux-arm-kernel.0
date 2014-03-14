From: mporter@linaro.org (Matt Porter)
Date: Fri, 14 Mar 2014 12:55:33 -0400
Subject: [PATCH] ARM: dts: bcm28155-ap: leave camldo1 on to fix reboot
In-Reply-To: <1394630079-12063-1-git-send-email-mporter@linaro.org>
References: <1394630079-12063-1-git-send-email-mporter@linaro.org>
Message-ID: <20140314165533.GD25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 09:14:39AM -0400, Matt Porter wrote:
> The BCM28155-AP board has a bootloader that expects the camldo1
> regulator to be enabled on entry. Currently, the camldo1 regulator
> is disabled when no longer in use as is the case during a reboot /
> warm reset. This causes the early bootloader to hang upon entry. Add
> regulator-always-on to the camldo1 constraint to fix reboot.
> 
> Reported-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Matt Porter <mporter@linaro.org>
> ---
> [Depends on BCM59056 regulator series dts support:
>  http://www.gossamer-threads.com/lists/linux/kernel/1885489]

Applied to mach-bcm armsoc/for-3.15/dt

-Matt

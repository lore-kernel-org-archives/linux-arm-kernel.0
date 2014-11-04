From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 04 Nov 2014 10:17:52 +0100
Subject: [PATCH 08/17] bus: mvebu-mbus: provide a mechanism to save SDRAM
 window configuration
In-Reply-To: <1414151970-6626-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <545899C0.9030301@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 24/10/2014 13:59, Thomas Petazzoni wrote:
> On Marvell EBU platforms, when doing suspend/resume, the SDRAM window
> configuration must be saved on suspend, and restored on
> resume. However, it needs to be restored on resume *before*
> re-entering the kernel, because the SDRAM window configuration defines
> the layout of the memory. For this reason, it cannot simply be done in
> the ->suspend() and ->resume() hooks of the mvebu-mbus driver.
> 
> Instead, it needs to be restored by the bootloader "boot info"
> mechanism used when resuming. This mechanism allows the kernel to
> define a list of (address, value) pairs when suspending, that the
> bootloader will restore on resume before jumping back into the kernel.
> 
> This commit therefore adds a new function to the mvebu-mbus driver,
> called mvebu_mbus_save_cpu_target(), which will be called by the
> platform code to make the mvebu-mbus driver save the SDRAM window
> configuration in a way that can be understood by the bootloader "boot
> info" mechanism.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/bus/mvebu-mbus.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mbus.h     |  1 +
>  2 files changed, 57 insertions(+)

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

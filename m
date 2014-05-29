From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 29 May 2014 09:55:34 -0600
Subject: [PATCH] scripts/dtc: pad DTBs to facilitate later modification
In-Reply-To: <1400888507-11637-1-git-send-email-khilman@linaro.org>
References: <1400888507-11637-1-git-send-email-khilman@linaro.org>
Message-ID: <53875876.2020001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2014 05:41 PM, Kevin Hilman wrote:
> By default, add some padding to the DT blobs to facilitate later
> patching.
> 
> An example need for DTB patching is the need to modifiy the command
> line on platforms where ATAGS are not (or cannot) be used to pass the
> commandline.  For example, we do not support a big-endian kernel
> reading ATAGS from a little-endian u-boot, so the only way to pass a
> command line in the DT.
> 
> Also, without ATAG support (or if u-boot was built without
> CONFIG_INITRD_TAG) the only way to pass an initrd is by adding an
> initrd= option to command line (in the DT).
> 
> Therefore, to facilitate adding to the DT command line directly in the
> DTB, add some padding.
> 
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
> I kinda pulled 64 bytes out of the air here since it's enough to add
> some common things to the commandline like debug, earlyprink
> initrd=<addr>,<size>, etc., but I'm certainlly not opposed to more
> padding.

Conceptually,
Acked-by: Stephen Warren <swarren@nvidia.com>

But I would expect a pad of something like 4KB to be more future-proof.
U-Boot appears to use 4KB on ARM at least:

./arch/arm/dts/Makefile:37:DTC_FLAGS += -R 4 -p 0x1000

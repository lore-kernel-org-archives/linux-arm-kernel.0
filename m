From: olof@lixom.net (Olof Johansson)
Date: Fri, 17 Jul 2015 10:44:10 -0700
Subject: [PATCH v2 0/2] Add support for PL172 memory-controller
In-Reply-To: <1436822412-20171-1-git-send-email-manabian@gmail.com>
References: <1436822412-20171-1-git-send-email-manabian@gmail.com>
Message-ID: <20150717174410.GO21691@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 11:20:10PM +0200, Joachim Eastwood wrote:
> This patch set adds a memory driver and documentation for the ARM
> PL172. This driver  makes it possible to configure the static
> memory chip selects on the ARM PL172 MultiPort Memory Controller
> from a set of properties in DT. Configuration of dynamic memory
> (SDRAM) is not supported and is left to the boot loader. The
> intended usage is to setup timing and configuration for static
> memory devices like NAND and NOR Flash before they are probed by
> a driver. Pretty much what like all the other memory drivers do.
> 
> As drivers/memory doesn't seem to have a maintainer of it's own
> I hope this patch set can go through the armsoc-drivers branch.
> 
> The previous version of the patch set didn't recive recivce much
> feedback and the cover letter can be found here:
> http://marc.info/?l=devicetree&m=143024189625522&w=2
> 
> DT bindings for PL172 is based on the bindings for the TI AEMIF
> memory controller. PL172 can be found on a number of NXP devices
> like the LPC18xx family.
> 
> Tested on Embedded Artists' LPC4357 Developer's Kit with NOR Flash
> (SST39VF320) and 74LCV16374 (gpio-74x164) on MPMC.
> 
> Changes since v1:
>  - Add proper commit messages
>  - Misc clean ups
> 
> Joachim Eastwood (2):
>   memory: add ARM PL172 MultiPort Memory Controller driver
>   doc: dt: add documentation for pl172 memory bindings

Thanks, I've applied both patches to next/drivers.


-Olof

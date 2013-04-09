From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 9 Apr 2013 05:44:10 +0000
Subject: [PATCH v5 0/5] Patch enables support for m25p64 SPI flash
 support on da850-EVM.
In-Reply-To: <1364998150-5980-1-git-send-email-prakash.pm@ti.com>
References: <1364998150-5980-1-git-send-email-prakash.pm@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4C560@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Wed, Apr 03, 2013 at 19:39:05, Manjunathappa, Prakash wrote:
> Testing information:
> da850-evm comes with partitions specified in DT blob.
> Able to mount/umount and create/delete files on filesystem partition.
> 

Could you please ack the driver(1/5) and documentation(2/5) changes so
that Sekhar can merge the platform changes, he doesn't have any
objection on this series.
http://marc.info/?l=linux-doc&m=136489750130615&w=1

Thanks,
Prakash

> Applies on top of linux_davinci/master tree:
> git://gitorious.org/linux-davinci/linux-davinci.git
> 
> Since v4:
> Separate out chip_select pinmuxing so as to allow boards choose
> accordingly.
> 
> Since v3:
> Minor nit, fix tabs and commit message of 2/5.
> 
> Since v2:
> Fix compatible property DT naming convention.
> 
> Since v1:
> Look for m25p64 instead of m25p80 flash chip and correct partition information.
> Dropped below accepted patch:
> "spi/davinci: fix module build error"
> Considered below missed out patch:
> spi/davinci: add DT binding documentation
> 
> Manjunathappa, Prakash (4):
>   spi/davinci: no wildcards in DT compatible property
>   ARM: davinci: da850: add SPI1 DT node
>   ARM: davinci: da850: override SPI DT node device name
>   ARM: davinci: da850-evm: add SPI flash support
> 
> Murali Karicheri (1):
>   spi/davinci: add DT binding documentation
> 
>  .../devicetree/bindings/spi/spi-davinci.txt        |   51 ++++++++++++++++++++
>  arch/arm/boot/dts/da850-evm.dts                    |   40 +++++++++++++++
>  arch/arm/boot/dts/da850.dtsi                       |   22 ++++++++
>  arch/arm/mach-davinci/da8xx-dt.c                   |    1 +
>  drivers/spi/spi-davinci.c                          |    4 +-
>  5 files changed, 116 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt
> 
> -- 
> 1.7.4.1
> 
> 

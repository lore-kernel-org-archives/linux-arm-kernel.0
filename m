From: otavio.salvador@ossystems.com.br (Otavio Salvador)
Date: Sat, 25 Nov 2017 07:55:53 -0200
Subject: [PATCH v2] ARM: dts: imx6qdl-nitrogen6x: Add SPI NOR partitions
In-Reply-To: <20171124170004.31133-1-otavio@ossystems.com.br>
References: <20171124170004.31133-1-otavio@ossystems.com.br>
Message-ID: <CAP9ODKoefNEcQtrCCLEa7hzx2D_2vJTit0t8ooQGTx7Uyds1mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 3:00 PM, Otavio Salvador
<otavio@ossystems.com.br> wrote:
> This adds the partitions definition for the SPI NOR to provide
> backward compatibility with the documented[1] layout used with
> Boundary Devices BSP.
>
> 1. https://boundarydevices.com/boot-flash-access-linux/
>
> It exports to Linux:
>
>  mtd0: bootloader
>  mtd1: env
>  mtd2: splash
>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

After thinking a bit about Fabio's recommendation to use 'read-only'
to protect the partitions, I think it'd be better to use 'lock' so it
is still possible to write them on Linux but it requires a unlock
prior changing it.

In my case, I am interested in being capable of upgrading the
bootloader from Linux.

What people think?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750

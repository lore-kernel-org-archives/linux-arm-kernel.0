From: sbabic@denx.de (Stefano Babic)
Date: Tue, 08 Nov 2011 07:30:19 +0100
Subject: Error for machine_is_m28evk
In-Reply-To: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
References: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
Message-ID: <4EB8CC7B.5060503@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2011 02:49 AM, Fabio Estevam wrote:
> Hi,
> 

Hi Fabio,

> On a 3.2-rc1 kernel I get the following error when trying to build
> mxs_defconfig:
> 
>   CHK     include/generated/compile.h
>   CC      arch/arm/mach-mxs/clock-mx28.o
> arch/arm/mach-mxs/clock-mx28.c: In function 'clk_misc_init':
> arch/arm/mach-mxs/clock-mx28.c:748: error: implicit declaration of
> function 'machine_is_m28evk'
> make[1]: *** [arch/arm/mach-mxs/clock-mx28.o] Error 1
> make: *** [arch/arm/mach-mxs] Error 2

This is due to the missing mach-id for the M28. The mach-id for this
board was requested and it is 3613, already set as "mainlined" at
http://www.arm.linux.org.uk/developer/machines/. We need an update of
mach-types.

Regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
=====================================================================

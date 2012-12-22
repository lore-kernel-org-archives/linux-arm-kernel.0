From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Sat, 22 Dec 2012 11:17:44 -0300
Subject: [PATCH] arm: omap3: igep0020: Add console default kernel arguments
In-Reply-To: <CAAwP0s1snYU7FR-BVM=GLg0oopT6NkBVLOysffia0dadsxW+BQ@mail.gmail.com>
References: <1356018118-29852-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAFqH_50ELkdXhVwW8atG0VsXU85S3pZqCVf9cytQRGk5SocFXw@mail.gmail.com>
 <CAAwP0s1snYU7FR-BVM=GLg0oopT6NkBVLOysffia0dadsxW+BQ@mail.gmail.com>
Message-ID: <CALF0-+UWx-cP7tcZ_L3dHaJREgi9R7-hD23z2wjD5N5ftROQpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric and Javier,

>> The u-boot 'bootargs' env overwrites the one from chosen ?
>>
>
> I just tested and U-Boot 'bootargs' has precedence over DT bootargs
> but I didn't find a way to append boot parameters from U-Boot. You can
> either overwrite it completely or not.
>

Yes. That seems to be the current case.
Perhaps we can merge
ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER
and CMDLINE_EXTEND in one generic config stating
the desired bootargs behavior.

Does this sound sane?

> That been said I think that is a good idea to have some default
> bootargs on the DT but since you can't append any boot option from
> U-Boot I would also add root=/dev/mmcblk0p2 rw rootwait so at least it
> will be able to mount the rootfs from the uSD/MMC.
>

True. Will re-send with those.

> Also, many IGEP COM Module base boards also have serial consoles that
> are connected to the OMAP3 UART3 (ttyO2), so maybe is better to add
> this to omap3-igep.dtsi instead of omap3-igep0020.dts to avoid future
> duplication.
>

Ok.

Thanks and merry xmas,

    Ezequiel

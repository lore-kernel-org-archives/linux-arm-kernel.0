From: martinez.javier@gmail.com (Javier Martinez Canillas)
Date: Sun, 23 Dec 2012 19:22:19 +0100
Subject: [PATCH] arm: omap3: igep0020: Add console default kernel arguments
In-Reply-To: <CALF0-+UWx-cP7tcZ_L3dHaJREgi9R7-hD23z2wjD5N5ftROQpw@mail.gmail.com>
References: <1356018118-29852-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CAFqH_50ELkdXhVwW8atG0VsXU85S3pZqCVf9cytQRGk5SocFXw@mail.gmail.com>
 <CAAwP0s1snYU7FR-BVM=GLg0oopT6NkBVLOysffia0dadsxW+BQ@mail.gmail.com>
 <CALF0-+UWx-cP7tcZ_L3dHaJREgi9R7-hD23z2wjD5N5ftROQpw@mail.gmail.com>
Message-ID: <CAAwP0s1vgrsho12CtejnoBo4biTN-VF_m_oqm+CD95AemhEHyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 22, 2012 at 3:17 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
> Hi Enric and Javier,
>
>>> The u-boot 'bootargs' env overwrites the one from chosen ?
>>>
>>
>> I just tested and U-Boot 'bootargs' has precedence over DT bootargs
>> but I didn't find a way to append boot parameters from U-Boot. You can
>> either overwrite it completely or not.
>>
>
> Yes. That seems to be the current case.
> Perhaps we can merge
> ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER
> and CMDLINE_EXTEND in one generic config stating
> the desired bootargs behavior.
>
> Does this sound sane?
>

Hi Ezequiel,

You could enable ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER on
omap2plus_defconfig but just having a sane DTB bootargs default value
is better IMHO.

Best regards,
Javier

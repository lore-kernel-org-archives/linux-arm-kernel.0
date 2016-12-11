From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 11 Dec 2016 10:36:14 -0200
Subject: i.MX31 3DS board not booting after commit 1c2f87c22... ARM:
 8025/1: Get rid of meminfo
In-Reply-To: <27bbaa4c-7c8d-cf76-c98f-e8edc89367db@gmail.com>
References: <27bbaa4c-7c8d-cf76-c98f-e8edc89367db@gmail.com>
Message-ID: <CAOMZO5ChFGrOfgnmaCxw=KwB7ZSp=ZOsmKb_v12_ti48U1NwgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Sun, Dec 11, 2016 at 8:34 AM, Magnus Lilja <lilja.magnus@gmail.com> wrote:
> Hi,
>
> I'm trying to get current modern Linux kernels to boot on the i.MX31 PDK
> board (a.k.a MX31_3DS).
>
> One problem I've noticed is that I have to comment out the following code
> from mach-mx31_3ds.c, the reserve function is registered as
> mach_desc->reserve . If I leave this function as is the kernel stops very
> early in the boot (see end of the mail).
>
> static void __init mx31_3ds_reserve(void)
> {
>         /* reserve MX31_3DS_CAMERA_BUF_SIZE bytes for mx3-camera */
>         mx3_camera_base = arm_memblock_steal(MX31_3DS_CAMERA_BUF_SIZE,
>                                          MX31_3DS_CAMERA_BUF_SIZE);
> }

The mx31_3ds_reserve() was used for reserving the buffer for the old
mx3_camera driver.

The mx3_camera driver has been removed since c93cc61475ebbe6 ("[media]
staging/media: remove deprecated mx3 driver"), so I would suggest you
to send a patch that just removes mx31_3ds_reserve().

Thanks

From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Aug 2017 12:11:04 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Add
 CONFIG_FW_LOADER_USER_HELPER_FALLBACK
In-Reply-To: <20170817140424.4614-1-gary.bisson@boundarydevices.com>
References: <20170817140424.4614-1-gary.bisson@boundarydevices.com>
Message-ID: <CAOMZO5DF8qfdraG8V1_ZuS393hqoU+fd1=Chiw7sTiK_gKaZVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gary,

On Thu, Aug 17, 2017 at 11:04 AM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:
> Allows to load firmware files which aren't built inside the kernel.
>
> Especially useful for CODA firmware (vpu_fw_imx6q.bin) which is usually
> located in the rootfs.
>
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
> Hi Shawn,
>
> I'm not sure if this patch is acceptable since I've noticed that no
> configuration currently has that option enabled (why?).
>
> As mentioned in the commit, I had to enable that in order to have CODA
> load the VPU firmware properly.
>
> Another option would be to make the CODA driver a module...

Yes, that's what we have currently:

commit a5a56f07c2726cc801efccd23f8df29af04d6d19
Author: Fabio Estevam <fabio.estevam@nxp.com>
Date:   Fri Jul 7 12:06:45 2017 -0300

    ARM: imx_v6_v7_defconfig: Select the coda driver as module

    The coda driver may be probed prior to the rootfs being available, leading
    to firmware loading failure.

    To avoid such problem, select the coda driver as module.

    Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

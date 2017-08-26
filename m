From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Sat, 26 Aug 2017 08:59:42 -0300
Subject: [PATCH 00/10] [media] platform: make video_device const
In-Reply-To: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
References: <1503742812-16139-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170826085942.78e0d222@vento.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Sat, 26 Aug 2017 15:50:02 +0530
Bhumika Goyal <bhumirks@gmail.com> escreveu:

> Make make video_device const.
> 
> Bhumika Goyal (10):
>   [media] cx88: make video_device const
>   [media] dt3155: make video_device const
>   [media]: marvell-ccic: make video_device const
>   [media] mx2-emmaprp: make video_device const
>   [media]: s5p-g2d: make video_device const
>   [media]: ti-vpe:  make video_device const
>   [media] via-camera: make video_device const
>   [media]: fsl-viu: make video_device const
>   [media] m2m-deinterlace: make video_device const
>   [media] vim2m: make video_device const
> 
>  drivers/media/pci/cx88/cx88-blackbird.c         | 2 +-
>  drivers/media/pci/dt3155/dt3155.c               | 2 +-
>  drivers/media/platform/fsl-viu.c                | 2 +-
>  drivers/media/platform/m2m-deinterlace.c        | 2 +-
>  drivers/media/platform/marvell-ccic/mcam-core.c | 2 +-
>  drivers/media/platform/mx2_emmaprp.c            | 2 +-
>  drivers/media/platform/s5p-g2d/g2d.c            | 2 +-
>  drivers/media/platform/ti-vpe/cal.c             | 2 +-
>  drivers/media/platform/ti-vpe/vpe.c             | 2 +-
>  drivers/media/platform/via-camera.c             | 2 +-
>  drivers/media/platform/vim2m.c                  | 2 +-

Please, don't do one such cleanup patch per file. Instead, group
it per subdirectory, e. g. on e patch for:
	drivers/media/platform/

and another one for:
	drivers/media/pci/

That makes a lot easier to review and apply.

Thanks,
Mauro

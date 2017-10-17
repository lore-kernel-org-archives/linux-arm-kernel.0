From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 17 Oct 2017 15:32:30 +0200
Subject: [PATCH 0/8] sa1100fb updates
In-Reply-To: <20170929105004.GY20805@n2100.armlinux.org.uk>
References: <CGME20170929105024epcas5p336177e386c65b530c4cb5fac379cedfa@epcas5p3.samsung.com>
 <20170929105004.GY20805@n2100.armlinux.org.uk>
Message-ID: <2590375.JKTUJ5JGIV@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 29, 2017 11:50:04 AM Russell King - ARM Linux wrote:
> Hi Bart,

Hi Russell,

> This series updates the sa1100fb fbdev driver's initialisation paths
> to be more robust.  In doing these updates, I realised that we omitted
> to free some memory which was allocated for the framebuffer if
> initialisation fails - something that was hidden due to the complex
> cleanup that the driver performs.  Switching to managed resources made
> this more obvious.
> 
> Tested on H3600 iPAQ and Assabet.
> 
>  drivers/video/fbdev/sa1100fb.c | 75 +++++++++++++++---------------------------
>  drivers/video/fbdev/sa1100fb.h |  2 ++
>  2 files changed, 29 insertions(+), 48 deletions(-)

I queued all patches for 4.15, thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

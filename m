From: niej0001@gmail.com (Jun Nie)
Date: Thu, 12 Nov 2009 10:17:21 +0800
Subject: [PATCH 3/8] pxa: fix offset setting at initialization
In-Reply-To: <7c34ac520911100012w3b441c50w9dffaa1100bcd5b7@mail.gmail.com>
References: <7c34ac520911100012w3b441c50w9dffaa1100bcd5b7@mail.gmail.com>
Message-ID: <7c34ac520911111817v22ff06dboc7d5f3c2e3da3126@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/10 Jun Nie <niej0001@gmail.com>:
> From c4f8923a0d532a1f1b5defed639ef818a0d7a270 Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 10 Nov 2009 09:33:49 +0800
> Subject: [PATCH] pxa: fix offset setting at initialization
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> ?drivers/video/pxa168fb.c | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index 50f72e9..55c69a1 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -765,6 +765,7 @@ static int __init pxa168fb_probe(struct
> platform_device *pdev)
> ? ? ? ?}
>
> ? ? ? ?info->fix.smem_start = (unsigned long)fbi->fb_start_dma;
> + ? ? ? set_graphics_start(info, 0, 0);
>
> ? ? ? ?/*
> ? ? ? ? * Set video mode according to platform data.
> --
> 1.5.4.3
>
patch attached.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-pxa-fix-offset-setting-at-initialization.patch
Type: text/x-diff
Size: 740 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091112/8a36a698/attachment.bin>

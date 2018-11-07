From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 7 Nov 2018 09:57:20 +0100
Subject: [PATCH] Staging: vchi: Add license id and change int type
In-Reply-To: <20181107000738.26963-1-andrealmeid@riseup.net>
References: <20181107000738.26963-1-andrealmeid@riseup.net>
Message-ID: <20181107085720.GA29581@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 10:07:38PM -0200, andrealmeid at riseup.net wrote:
> From: Andr? Almeida <andrealmeid@riseup.net>
> 
> Fix the following checkpatch issues:
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> CHECK: Prefer kernel type 's32' over 'int32_t'
> 
> Signed-off-by: Andr? Almeida <andrealmeid@riseup.net>
> 
> ---
> 
> Hello! This is my first patch to Linux Kernel. Let me know any feedback
> ---
>  drivers/staging/vc04_services/interface/vchi/vchi_mh.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
> index 198bd076b666..42fc0c693d43 100644
> --- a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
> +++ b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
> @@ -1,5 +1,5 @@
> -/**

Why change this line?

> - * Copyright (c) 2010-2012 Broadcom. All rights reserved.
> +/* SPDX-License-Identifier: GPL-2.0 */

That is not the correct license for this file.  Please never make a
change like this unless you really know your license information.


> +/* Copyright (c) 2010-2012 Broadcom. All rights reserved.
>   *
>   * Redistribution and use in source and binary forms, with or without
>   * modification, are permitted provided that the following conditions
> @@ -36,7 +36,7 @@
>  
>  #include <linux/types.h>
>  
> -typedef int32_t VCHI_MEM_HANDLE_T;
> +typedef s32 VCHI_MEM_HANDLE_T;

You are doing multiple things in the same patch, which isn't allowed.
Please break all patches up into one "logical" thing per patch and send
a patch series.

Also, are you sure this type change is correct?

thanks,

greg k-h

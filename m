From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 7 Nov 2018 09:30:38 +0100
Subject: [PATCH] Staging: vchi: Add license id and change int type
In-Reply-To: <20181107000738.26963-1-andrealmeid@riseup.net>
References: <20181107000738.26963-1-andrealmeid@riseup.net>
Message-ID: <d6e6a908-8ef6-e2a5-0a78-7bc21be957e4@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

Am 07.11.18 um 01:07 schrieb andrealmeid at riseup.net:
> From: Andr? Almeida <andrealmeid@riseup.net>
>
> Fix the following checkpatch issues:
>
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> CHECK: Prefer kernel type 's32' over 'int32_t'

thanks for your patch, but there are some changes required.

First don't change two different things in one patch. So please make a
V2 with one patch for SPDX and the other one for the type change.

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
> - * Copyright (c) 2010-2012 Broadcom. All rights reserved.
> +/* SPDX-License-Identifier: GPL-2.0 */

Please use the C++ style for the SPDX id.

Unfortunately your id doesn't match the license text. It's a dual
license|: BSD-3-Clause OR GPL-2.0|

> +/* Copyright (c) 2010-2012 Broadcom. All rights reserved.
>   *
>   * Redistribution and use in source and binary forms, with or without
>   * modification, are permitted provided that the following conditions
After adding the SPDX id we can drop the whole license text.
> @@ -36,7 +36,7 @@
>  
>  #include <linux/types.h>
>  
> -typedef int32_t VCHI_MEM_HANDLE_T;
> +typedef s32 VCHI_MEM_HANDLE_T;

In general we should drop the whole typedef, but since the firmware
counterpart would use this. I'm okay with this change.

Stefan

>  #define VCHI_MEM_HANDLE_INVALID 0
>  
>  #endif

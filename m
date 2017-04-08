From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Sat, 8 Apr 2017 19:12:25 +0100
Subject: [PATCHv3 17/22] staging: android: ion: Collapse internal header
 files
In-Reply-To: <1491245884-15852-18-git-send-email-labbott@redhat.com>
References: <1491245884-15852-1-git-send-email-labbott@redhat.com>
 <1491245884-15852-18-git-send-email-labbott@redhat.com>
Message-ID: <CACvgo52qr=oBoiMnrww3cgoKozEMi3DwBV55c_GMi0mR_p0GcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

Couple of trivial nitpicks below.

On 3 April 2017 at 19:57, Laura Abbott <labbott@redhat.com> wrote:

> --- a/drivers/staging/android/ion/ion.h
> +++ b/drivers/staging/android/ion/ion.h
> @@ -1,5 +1,5 @@
>  /*
> - * drivers/staging/android/ion/ion.h
> + * drivers/staging/android/ion/ion_priv.h
Does not match the actual filename.

>   *
>   * Copyright (C) 2011 Google, Inc.
>   *
> @@ -14,24 +14,26 @@
>   *
>   */
>
> -#ifndef _LINUX_ION_H
> -#define _LINUX_ION_H
> +#ifndef _ION_PRIV_H
> +#define _ION_PRIV_H
>
Ditto.

> +#include <linux/device.h>
> +#include <linux/dma-direction.h>
> +#include <linux/kref.h>
> +#include <linux/mm_types.h>
> +#include <linux/mutex.h>
> +#include <linux/rbtree.h>
> +#include <linux/sched.h>
> +#include <linux/shrinker.h>
>  #include <linux/types.h>
> +#include <linux/miscdevice.h>
>
>  #include "../uapi/ion.h"
>
You don't want to use "../" in includes. Perhaps address with another
patch, if you haven't already ?

Regards,
Emil

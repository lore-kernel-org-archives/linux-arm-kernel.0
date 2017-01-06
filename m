From: dhowells@redhat.com (David Howells)
Date: Fri, 06 Jan 2017 10:45:55 +0000
Subject: [PATCH v2 2/4] linux/const.h: move UL() macro to
 include/linux/const.h
In-Reply-To: <1483582810-7046-3-git-send-email-yamada.masahiro@socionext.com>
References: <1483582810-7046-3-git-send-email-yamada.masahiro@socionext.com>
 <1483582810-7046-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <15496.1483699555@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
> index c872bfd..76fb0f9 100644
> --- a/include/uapi/linux/const.h
> +++ b/include/uapi/linux/const.h
> @@ -1,7 +1,7 @@
>  /* const.h: Macros for dealing with constants.  */
>  
> -#ifndef _LINUX_CONST_H
> -#define _LINUX_CONST_H
> +#ifndef _UAPI_LINUX_CONST_H
> +#define _UAPI_LINUX_CONST_H

You need to be very careful doing this.  Some userspace stuff depends on the
guard macro names on the kernel header files.

>  /* Some constant macros are used in both assembler and
>   * C code.  Therefore we cannot annotate them always with
> @@ -21,7 +21,10 @@
>  #define _AT(T,X)	((T)(X))
>  #endif
>  
> +#define _UL(x)		(_AC(x, UL))
> +#define _ULL(x)		(_AC(x, ULL))

How likely is this to collide with existing userspace code somewhere?  It
looks like the sort of thing that could collide with a C library.

David

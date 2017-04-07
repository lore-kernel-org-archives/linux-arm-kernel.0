From: thuth@redhat.com (Thomas Huth)
Date: Fri, 7 Apr 2017 10:53:01 +0200
Subject: [RFC kvm-unit-tests PATCH 4/8] Makefiles: use explicit path for
 including sub-Makefiles
In-Reply-To: <20170406190727.5624-5-alex.bennee@linaro.org>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
 <20170406190727.5624-5-alex.bennee@linaro.org>
Message-ID: <7f6fe583-a765-b8cd-d1f6-5068ee5d52e0@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.04.2017 21:07, Alex Benn?e wrote:
> I would of thought VPATH took care of this but apparently not.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> ---
>  Makefile               | 8 ++++----
>  arm/Makefile           | 2 +-
>  arm/Makefile.arm       | 2 +-
>  arm/Makefile.arm64     | 2 +-
>  powerpc/Makefile       | 2 +-
>  powerpc/Makefile.ppc64 | 2 +-
>  x86/Makefile           | 2 +-
>  x86/Makefile.i386      | 2 +-
>  x86/Makefile.x86_64    | 2 +-
>  9 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 80bc57e..781186e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -32,14 +32,14 @@ cflatobjs := \
>  	lib/stack.o
>  
>  # libfdt paths
> -LIBFDT_objdir = lib/libfdt
> -LIBFDT_srcdir = lib/libfdt
> +LIBFDT_objdir = $(SRCDIR)/lib/libfdt

I think this is wrong - objdir should not get a SRCDIR prefix.

 Thomas

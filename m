From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 25 Apr 2016 12:01:09 -0400 (EDT)
Subject: [PATCH] kbuild: fix call to adjust_autoksyms.sh when output
 directory specified
In-Reply-To: <1461599708-1397-1-git-send-email-nicolas.ferre@atmel.com>
References: <1461599708-1397-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <alpine.LFD.2.20.1604251158260.5091@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Apr 2016, Nicolas Ferre wrote:

> When a different output directory is specified during the build process (with
> O= or KBUILD_OUTPUT), the call to adjust_autoksyms.sh script fails with the
> following error:
> /bin/sh scripts/adjust_autoksyms.sh \
> 	  "make KBUILD_MODULES=1 -f ../Makefile autoksyms_recursive"
> 	  /bin/sh: scripts/adjust_autoksyms.sh: No such file or directory
> 	  make[2]: *** [vmlinux] Error 127
> 	  make[1]: *** [sub-make] Error 2
> 	  make: *** [__sub-make] Error 2
[...]

I posted a few fixes for this and some other issues already.

You may grab them all at once from this branch where I committed them on 
top of Michal's kbuild branch:

        git://git.linaro.org/people/nicolas.pitre/linux kbuild


Nicolas

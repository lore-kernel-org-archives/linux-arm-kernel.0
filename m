From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 15:54:26 -0700
Subject: [RFC PATCH V3 1/2] scripts: dtc: build fdtget for extracting
 properties from dtbs
In-Reply-To: <55bef0830d336fc1df24e4cbf96822acc70c8f7e.1384809305.git.jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <cover.1384809305.git.jason@lakedaemon.net>
 <55bef0830d336fc1df24e4cbf96822acc70c8f7e.1384809305.git.jason@lakedaemon.net>
Message-ID: <528A9AA2.30303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 02:21 PM, Jason Cooper wrote:
> In order for 'make dtbs_install' to be maintainable, we need a reliable
> way to determine the board compatible string for a given dtb.  fdtget
> does that easily as written, but currently isn't built by the kernel.

> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile

> +include $(src)/libfdt/Makefile.libfdt
> +
> +fdtget-objs	:= fdtget.o util.o $(patsubst %, libfdt/%, $(LIBFDT_OBJS))

I observe that there's a scripts/dtc/Makefile.dtc that /isn't/ used by
scripts/dtc/Makefile. Hence, having scripts/dtc/Makefile use
scripts/dtc/libfdt/Makefile.libfdt seems slightly inconsistent. That
said, it's probably a good idea to use Makefile.libfdt, so perhaps the
answer here is to update Makefile to use Makefile.dtc sometime, rather
than not use Makefile.libfdt in this patch?

Otherwise, this patch seems to make sense.

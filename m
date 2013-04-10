From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 10 Apr 2013 11:35:34 -0600
Subject: [PATCH 1/2] ARM: boot/dts/Makefile: drop '\'
In-Reply-To: <1365585444-11520-1-git-send-email-plagnioj@jcrosoft.com>
References: <1365585444-11520-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <5165A2E6.7010108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 03:17 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> when adding multiple new platform this generate comflict

"When" and "conflict".

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile

> -ifeq ($(CONFIG_OF),y)

> -targets += dtbs
> -targets += $(dtb-y)
> -endif
> -
> -# *.dtb used to be generated in the directory above. Clean out the
> -# old build results so people don't accidentally use them.
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -	$(Q)rm -f $(obj)/../*.dtb
> -
> -clean-files := *.dtb

I'm not sure why those parts show up in the diff. I guess the -/+ lines
look the same though, so the result is fine. did line-endings change or
something?

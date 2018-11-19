From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Nov 2018 10:00:24 -0800
Subject: [PATCH] ARM: OMAP2+: hwmod: Fix some section annotations
In-Reply-To: <20181018005207.7201-1-natechancellor@gmail.com>
References: <20181018005207.7201-1-natechancellor@gmail.com>
Message-ID: <20181119180024.GR53235@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nathan Chancellor <natechancellor@gmail.com> [181017 17:52]:
> When building the kernel with Clang, the following section mismatch
> warnings appears:
> 
> WARNING: vmlinux.o(.text+0x2d398): Section mismatch in reference from
> the function _setup() to the function .init.text:_setup_iclk_autoidle()
> The function _setup() references
> the function __init _setup_iclk_autoidle().
> This is often because _setup lacks a __init
> annotation or the annotation of _setup_iclk_autoidle is wrong.
...

Applying into omap-for-v4.21/soc thanks.

Tony

From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 13 Jul 2010 16:14:41 -0700
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <20100713230352.6781.18644.stgit@angua>
References: <20100713230352.6781.18644.stgit@angua>
Message-ID: <1279062881.4609.34.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-13 at 17:04 -0600, Grant Likely wrote:

> - I haven't figured out a way for the fragment to force an option to
>   be "n", or to set a value, for example "CONFIG_LOG_BUF_SHIFT=16".
>   This may require changing the syntax.
> - It still doesn't resolve dependencies.  A solver would help with this.
>   For the time being I work around the problem by running the generated
>   config through 'oldconfig' and looking for differences.  If the files
>   differ (ignoring comments and generateconfig_* options) after oldconfig,
>   then the <board>_defconfig target returns a failure.  (but leaves the
>   new .config intact so the user can resolve it with menuconfig).  This
>   way at least the user is told when a Kconfig fragment is invalid.

The solver would fix the whole issues with the defconfigs , we wouldn't
need this Kconfig change .. From my perspective we shouldn't be fooling
around with anything but the solver approach ..

It just doesn't feel like Kconfig was meant to do this, it feel like
somewhat of an abuse ..

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

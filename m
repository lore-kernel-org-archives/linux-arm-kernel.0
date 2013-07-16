From: bp@alien8.de (Borislav Petkov)
Date: Tue, 16 Jul 2013 11:38:20 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <201307161132.39845.yann.morin.1998@free.fr>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <201307161112.17901.yann.morin.1998@free.fr>
 <20130716092242.GD4402@pd.tnic>
 <201307161132.39845.yann.morin.1998@free.fr>
Message-ID: <20130716093820.GE4402@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 11:32:39AM +0200, Yann E. MORIN wrote:
> No, this is already too late: the given .config *is* already broken and
> unbuildable.

Yes, and we don't build it because we fail the build.

> That does not work in two cases:
>   - older distros that do not have the tool packaged

This point is moot - distro kernels are built by the distro people.

>   - automatic test-harness that run thousands of randconfig a day

randconfigs are not guaranteed to build successfully.

> The idea is to be always have a .config that is buildable with the
> current toolset of the system, especially for esoteric and/or recent
> tools that are not packaged and/or installed by default by the
> distros.

How are you going to tell the user running make <something>config to
install the missing tools?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

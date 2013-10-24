From: keescook@chromium.org (Kees Cook)
Date: Thu, 24 Oct 2013 01:45:02 -0700
Subject: [PATCH] Simple NX lowmem mappings
In-Reply-To: <20131024071258.GB16735@n2100.arm.linux.org.uk>
Message-ID: <20131024084502.GT4994@outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for starting this work!

Russel said:
> -#define MT_MEMORY      9
> [...]
> + MT_MEMORY,
> + MT_MEMORY_NX,

Instead of these names, let's more fully describe the protections. "NX"
doesn't say anything about RO vs RW. Instead, how about:

MT_MEMORY_RWX (to replace MT_MEMORY)
MT_MEMORY_RW  (as the new "NX" in use for this patch)

for the first change? Then as we move forward, we can add:

MT_MEMORY_R

At which point we'll have the three states.

-Kees

-- 
Kees Cook                                            @outflux.net

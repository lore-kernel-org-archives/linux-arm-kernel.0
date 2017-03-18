From: rabin@rab.in (Rabin Vincent)
Date: Sat, 18 Mar 2017 19:33:23 +0100
Subject: [PATCH] arm: ftrace: fix dynamic ftrace with DEBUG_RODATA and
 !FRAME_POINTER
In-Reply-To: <1489601259-9432-1-git-send-email-abelvesa@linux.com>
References: <1489601259-9432-1-git-send-email-abelvesa@linux.com>
Message-ID: <20170318183323.5hmqt6yx6ja63kaa@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 06:07:39PM +0000, Abel Vesa wrote:
> The support for dynamic ftrace with CONFIG_DEBUG_RODATA involves
> overriding the weak arch_ftrace_update_code() with a variant which makes
> the kernel text writable around the patching.
> 
> This override was however added under the CONFIG_OLD_MCOUNT ifdef, and
> CONFIG_OLD_MCOUNT is only enabled if frame pointers are enabled.
> 
> This leads to non-functional dynamic ftrace (ftrace triggers a
> WARN_ON()) when CONFIG_DEBUG_RODATA is enabled and CONFIG_FRAME_POINTER
> is not.
> 
> Move the override out of that ifdef and into the CONFIG_DYNAMIC_FTRACE
> ifdef where it belongs.
> 
> Fixes: 80d6b0c2eed2a ("ARM: mm: allow text and rodata sections to be read-only")
> 
> Suggested-by: Nicolai Stange <nicstange@gmail.com>
> Suggested-by: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Abel Vesa <abelvesa@linux.com>

Acked-by: Rabin Vincent <rabin@rab.in>

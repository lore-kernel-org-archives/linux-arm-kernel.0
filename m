From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 16:46:57 +0200
Subject: [PATCH 1/1] ARM:Gemini:Fix compiler warning due wrong data type.
In-Reply-To: <1431360791-11681-1-git-send-email-ulli.kroll@googlemail.com>
References: <1431360791-11681-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <3887800.kgFSO5Stek@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 May 2015 18:13:11 Hans Ulli Kroll wrote:
> This patch fixes a compiler warning in gemini_restart()
> issued by commit
> 
> 7b6d864b48d95e6ea1df7df64475b9cb9616dcf9
> reboot:arm: reboot_mode changes from char to enum reboot_mode.
> 
> Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>

Applied to the fixes branch, with a slightly updated commit message:

Author: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Date:   Mon May 11 18:13:11 2015 +0200

    ARM: gemini: fix compiler warning due wrong data type
    
    This patch fixes a compiler warning in gemini_restart()
    issued by commit 7b6d864b48d9 ("reboot:arm: reboot_mode
    changes from char to enum reboot_mode").
    
    arch/arm/mach-gemini/board-rut1xx.c:93:2: warning: initialization from incompatible pointer type
    
    The warning is harmless, and the patch does not need to
    be backported to stable kernels.
    
    Fixes: 7b6d864b48d ("reboot:arm: reboot_mode changes from char to enum reboot_mode.")
    Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Note the exact format of the subject line (with spaces after ':', and
the 'Fixes' tag at the Signed-off-by line.

	Arnd

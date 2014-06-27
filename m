From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 26 Jun 2014 21:09:46 -0400
Subject: [PATCH 1/3] staging: tidspbridge: fix an erroneous removal of
 parentheses
In-Reply-To: <1403587467-59876-2-git-send-email-s-anna@ti.com>
References: <1403587467-59876-1-git-send-email-s-anna@ti.com>
 <1403587467-59876-2-git-send-email-s-anna@ti.com>
Message-ID: <20140627010946.GA19029@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 12:24:25AM -0500, Suman Anna wrote:
> Commit 4a9fdbb (staging: core: tiomap3430.c Fix line over 80 characters.)
> erroneously removed the parentheses around the function pointer leading
> to the following build error (when enabling the build of TI DSP/Bridge
> driver):
> 
> drivers/staging/tidspbridge/core/tiomap3430.c: In function 'bridge_brd_monitor':
> drivers/staging/tidspbridge/core/tiomap3430.c:283:10: error: invalid type argument of unary '*' (have 'u32')
> make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430.o] Error 1
> 
> Fix this build error properly.

This shows that no one really uses this driver :(

Can't we just delete the thing?

I'll go queue this up for 3.16-final, thanks.

greg k-h

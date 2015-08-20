From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 20 Aug 2015 08:58:37 +0200
Subject: [PATCH 5/5] drivers/tty: make serial 8250_lpc18xx.c Kconfig a
 tristate
In-Reply-To: <1440020889-12120-6-git-send-email-paul.gortmaker@windriver.com>
References: <1440020889-12120-1-git-send-email-paul.gortmaker@windriver.com>
 <1440020889-12120-6-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <CAGhQ9VzWBq=gqHhkhfm+2MwaOHDzLKDLo8v1CJX3N-xiZnCv=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 August 2015 at 23:48, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> The Kconfig currently controlling compilation of this code is:
>
> 8250/Kconfig:config SERIAL_8250_LPC18XX
> 8250/Kconfig:        bool "NXP LPC18xx/43xx serial port support"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> When targetting orphaned modular code in non-modular drivers, this
> came up.  Joachim indicated that the driver was actually meant to
> be tristate but ended up bool by accident.  So here we make it
> tristate instead of removing the modular code that was essentially
> orphaned.
>
> Suggested-by: Joachim Eastwood <manabian@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Cc: linux-serial at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Joachim Eastwood <manabian@gmail.com>

Build tested as a module on lpc18xx.

Thanks for fixing it Paul.


regards,
Joachim Eastwood

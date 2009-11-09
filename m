From: swetland@google.com (Brian Swetland)
Date: Mon, 9 Nov 2009 05:06:01 -0800
Subject: htc dream: attempts at mmc and framebuffer support
In-Reply-To: <20091109111154.GB8750@elf.ucw.cz>
References: <20091109111154.GB8750@elf.ucw.cz>
Message-ID: <a55d774e0911090506r4baf53edpc0c5de35defcb96d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 9, 2009 at 3:11 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> I tried to get mmc and framebuffer to work, but could not. framebuffer
> probably needs clock framework to work properly...

Both fb and mmc will need operable clock control to function.  mmc
will also need the vreg code (to adjust power to the sdcard slot).
Both clk_* and vreg_* are already in, though I haven't put them
through their paces in the latest kernel tree.  They both just wrap
proc_comm (as the modem owns both clock and power control) and are
pretty simple -- they should "just work".

The framebuffer is "fun" to bootstrap -- it needs the mddi transport
(serial video interface), mddi-to-lcdc bridge and panel init code, and
the mdp dma code to go.

Brian

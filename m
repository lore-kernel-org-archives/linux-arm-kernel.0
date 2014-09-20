From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 20 Sep 2014 14:17:42 +0200
Subject: [PATCH] i2c: rk3x: Remove unlikely() annotations
In-Reply-To: <1408729424-11433-1-git-send-email-dianders@chromium.org>
References: <1408729424-11433-1-git-send-email-dianders@chromium.org>
Message-ID: <20140920121740.GA3850@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 10:43:44AM -0700, Doug Anderson wrote:
> Having a transfer more than 32 bits is not all that unlikely.  Remove
> the annotation.
> 
> The unlikely in the IRQ handler can't gain us much.  It's not in a
> loop, so at most it would save 1 instruction per IRQ, which isn't
> much.  In fact on the compiler I tested it produced the exact same
> code.  Remove it too.
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140920/65f1f968/attachment.sig>

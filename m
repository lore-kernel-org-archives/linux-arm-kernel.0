From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 2 Feb 2012 17:41:14 +0100
Subject: [PATCH] ARM: LPC32xx: Support for OHCI HCD
In-Reply-To: <1328103028-20547-1-git-send-email-stigge@antcom.de>
References: <1328103028-20547-1-git-send-email-stigge@antcom.de>
Message-ID: <20120202164114.GB3219@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 02:30:28PM +0100, stigge at antcom.de wrote:
> This patch adds OHCI support to the LPC32xx ARM platform
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Okay, I asked for a patch to test USB, so thanks. It did not work for me,
sadly, so there seems to be more work needed in that area.

Yet, even formally, this patch is not ready for mainline. It touches
various subsystems in one patch (arch, usb), uses too much #ifdef and
also misses important mailing lists (usb).

May I ask if you read Documentation/development-process and/or
Documentation/SubmittingPatches? If not, please do so.

I'd suggest to work in smaller steps. Get LPC32xx build again and fix
the elementary clock issues. Then, get USB to work (for example). Then,
get the network driver accepted (for example). Also consider, that those
drivers have not just been forgotten to be posted. They usually had
issues which need to be fixed before mainlining. So, one task at a time
will help to keep focused, I think.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/00be6712/attachment.sig>

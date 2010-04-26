From: ospite@studenti.unina.it (Antonio Ospite)
Date: Mon, 26 Apr 2010 12:19:38 +0200
Subject: pxa_overlay: WARNING: at drivers/char/vt.c:3699
	do_unblank_screen+0x30/0x144()
Message-ID: <20100426121938.06d74f10.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

when trying to open /dev/fb1 (even cat /dev/fb1) on a pxa27xx (Motorola
A780) I am getting the following trace, kernel is still 2.6.33.

------------[ cut here ]------------
WARNING: at drivers/char/vt.c:3699 do_unblank_screen+0x30/0x144()
Modules linked in:
[<c002ed90>] (unwind_backtrace+0x0/0xd8) from [<c0042994>] (warn_slowpath_common+0x48/0x60)
[<c0042994>] (warn_slowpath_common+0x48/0x60) from [<c016be14>] (do_unblank_screen+0x30/0x144)
[<c016be14>] (do_unblank_screen+0x30/0x144) from [<c014e800>] (fbcon_event_notify+0x574/0x710)
[<c014e800>] (fbcon_event_notify+0x574/0x710) from [<c005d02c>] (notifier_call_chain+0x2c/0x70)
[<c005d02c>] (notifier_call_chain+0x2c/0x70) from [<c005d354>] (__blocking_notifier_call_chain+0x48/0x5c)
[<c005d354>] (__blocking_notifier_call_chain+0x48/0x5c) from [<c005d37c>] (blocking_notifier_call_chain+0x14/0x18)
[<c005d37c>] (blocking_notifier_call_chain+0x14/0x18) from [<c0145844>] (fb_blank+0x5c/0x68)
[<c0145844>] (fb_blank+0x5c/0x68) from [<c0153048>] (overlayfb_open+0x4c/0x54)
[<c0153048>] (overlayfb_open+0x4c/0x54) from [<c01455f8>] (fb_open+0x100/0x134)
[<c01455f8>] (fb_open+0x100/0x134) from [<c00a893c>] (chrdev_open+0x18c/0x1ac)
[<c00a893c>] (chrdev_open+0x18c/0x1ac) from [<c00a4160>] (__dentry_open+0x184/0x2a0)
[<c00a4160>] (__dentry_open+0x184/0x2a0) from [<c00a4338>] (nameidata_to_filp+0x3c/0x50)
[<c00a4338>] (nameidata_to_filp+0x3c/0x50) from [<c00b11c0>] (do_filp_open+0x41c/0x920)
[<c00b11c0>] (do_filp_open+0x41c/0x920) from [<c00a3efc>] (do_sys_open+0x58/0x10c)
[<c00a3efc>] (do_sys_open+0x58/0x10c) from [<c0028fe0>] (ret_fast_syscall+0x0/0x34)
---[ end trace b03596c16cc0adf0 ]---
overlay1fb_disable: timeout disabling overlay1

And the overlay framebuffer is then disabled.

The relevant config options:
CONFIG_FB_PXA=y
CONFIG_FB_PXA_OVERLAY=y
# CONFIG_FB_PXA_SMARTPANEL is not set
CONFIG_FB_PXA_PARAMETERS=y

I'll try doing some more debugging as time permits.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100426/89612e0a/attachment.sig>

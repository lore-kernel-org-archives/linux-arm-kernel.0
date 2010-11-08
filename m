From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Nov 2010 09:47:37 +0100
Subject: [PATCH 6/6 v2] ARM: Add support for the display controllers in
	VT8500 and WM8505
In-Reply-To: <1289147348-31969-6-git-send-email-alchark@gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-6-git-send-email-alchark@gmail.com>
Message-ID: <201011080947.37522.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 07 November 2010, Alexey Charkov wrote:
>  drivers/video/Kconfig         |   26 +++
>  drivers/video/Makefile        |    3 +
>  drivers/video/vt8500lcdfb.c   |  452 +++++++++++++++++++++++++++++++++++++++++
>  drivers/video/vt8500lcdfb.h   |   34 +++
>  drivers/video/wm8505fb.c      |  438 +++++++++++++++++++++++++++++++++++++++
>  drivers/video/wm8505fb_regs.h |   76 +++++++
>  drivers/video/wmt_ge_rops.c   |  186 +++++++++++++++++
>  drivers/video/wmt_ge_rops.h   |    5 +

>From a very brief look, the two drivers look rather similar. What is the
reason to have separate drivers instead of just one?

Could you perhaps take the common parts and move them into a third module
that exports symbols to be used by the two drivers?

	Arnd

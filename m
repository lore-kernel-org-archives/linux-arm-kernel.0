From: wookey@wookware.org (Wookey)
Date: Thu, 29 Jul 2010 11:00:41 +0100
Subject: [PATCH 11/13] [ARM] pxa/balloon3: PCF857x GPIO expander and LEDs
In-Reply-To: <1280373389-32475-11-git-send-email-marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
	<1280373389-32475-11-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100729100040.GA4981@dream.aleph1.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Marek Vasut [2010-07-29 05:16 +0200]:
> Add supported for PCF8574A GPIO expander and LEDs attached to it.

This IO board is an add-on used in some ballon configurations, not
part of the core board. There needs to be some way of selecting this
support when the loon is used in this configuration. We have the
balloon_has() macro which is used for dealing with the different
builds of the board itself. Perhaps it should be extended to deal with
add-on board functionality too?

More obvious is using the CONFIG system to just enable this if
CUED_IO_BOARD is configured.

Wookey
-- 
Principal hats:  Linaro, Emdebian, Wookware, Balloonboard, ARM
http://wookware.org/

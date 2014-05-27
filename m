From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 May 2014 10:09:52 +0200
Subject: [PATCH 03/11] pinctrl: sunxi: Move setting of mux to irq type
 from unmask to set_type
In-Reply-To: <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20140527080952.GC4730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 09:47:58AM +0200, Hans de Goede wrote:
> With level triggered interrupt mask / unmask will get called for each
> interrupt, doing the somewhat expensive mux setting on each unmask thus is
> not a good idea. Instead move it to the set_type callback, which is typically
> done only once for each irq.

*This* is the bad idea. Nothing prevents you from calling
gpio_get_value whenever you just got your interrupt, that will change
the muxing, and never change it back, effectively breaking the
interrupts.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/89e7eb9c/attachment.sig>

From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 31 Oct 2014 10:15:31 +0200
Subject: [PATCH v4 0/5] simplefb: add clock handling code
In-Reply-To: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
Message-ID: <54534523.8080801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On 22/10/14 19:45, Hans de Goede wrote:

> -We will add a clocks property to the simplefb devicetree bindings, so
>  that u-boot setup framebuffers passed to the kernel (for early console
>  support) can properly list the clocks used, and simplefb can claim them to
>  avoid them getting turned off, thereby breaking the early console

Perhaps this has been discussed earlier, but I started to wonder if
managing clocks is enough.

What about regulators (to power the LCD), gpios (to keep the LCD
enabled) and pinctrl (for video signals)? I guess any those could be
reset by the kernel if no driver uses them.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/d8c71f16/attachment.sig>

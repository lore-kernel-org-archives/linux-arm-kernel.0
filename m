From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Mar 2015 18:48:34 +0100
Subject: [PATCH] pinctrl: sun4i: GPIOs configured as irq must be set to
 input before reading
In-Reply-To: <1425849237-30182-1-git-send-email-hdegoede@redhat.com>
References: <1425849237-30182-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150311174834.GP5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 08, 2015 at 10:13:57PM +0100, Hans de Goede wrote:
> On sun4i-a10, when GPIOs are configured as external interrupt the value for
> them in the data register does not seem to get updated, so set their mux to
> input (and restore afterwards) when reading the pin.
> 
> Missed edges seem to be buffered, so this does not introduce a race
> condition.
> 
> I've also tested this on sun5i-a13 and sun7i-a20 and those do not seem to
> be affected, the input value representation in the data register does seem
> to correctly get updated to the actual pin value while in irq mode there.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150311/8dc415a3/attachment.sig>

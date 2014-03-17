From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Mar 2014 12:12:45 +0100
Subject: [PATCH v2 2/2] irqchip: sun4i: simplify sun4i_irq_ack
In-Reply-To: <1394895894-8891-3-git-send-email-hdegoede@redhat.com>
References: <1394895894-8891-1-git-send-email-hdegoede@redhat.com>
 <1394895894-8891-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20140317111245.GH27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 04:04:54PM +0100, Hans de Goede wrote:
> Now that we only ack irq 0 the code can be simplified a lot.
> 
> Also switch from read / modify / write to a simple write clear:
> 1) This is what the android code does (it has a hack for acking irq 0
>   in its unmask code doing this)
> 2) read / modify / write simply does not make sense for an irq status
>   register like this, if the other bits are writeable (and the data sheet says
>   they are not) they should be write 1 to clear, since otherwise a read /
>   modify / write can race with a device raising an interrupt and then clear
>   the pending bit unintentionally
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/68632fc3/attachment.sig>

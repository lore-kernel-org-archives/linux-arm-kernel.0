From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 15 Jan 2015 14:44:01 +0100
Subject: [PATCH RESEND V2 1/2] power: gpio-charger: balance
 enable/disable_irq_wake calls
In-Reply-To: <1421287238-23522-1-git-send-email-dbaryshkov@gmail.com>
References: <1421287238-23522-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150115134401.GA512@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 15, 2015 at 05:00:37AM +0300, Dmitry Eremin-Solenikov wrote:
> enable_irq_wakeup returns 0 in case it correctly enabled the IRQ to
> generate the wakeup event (and thus resume should call disable_irq_wake).
> Currently gpio-charger driver has this logic inverted. Correct that thus
> correcting enable/disable_irq_wake() calls balance.

Thanks, applied:

http://git.infradead.org/battery-2.6.git/commit/9a2fb8ac9677ab9cf17ab336e06b59d93a57f4a4

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/692e0a76/attachment.sig>

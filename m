From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 17 Jul 2015 11:00:39 +0200
Subject: [PATCH] [TWL4030 MADC] Fix ADC[3:6] readings
In-Reply-To: <1437085227-28845-2-git-send-email-adam.yh.lee@gmail.com>
References: <1437085227-28845-1-git-send-email-adam.yh.lee@gmail.com>
 <1437085227-28845-2-git-send-email-adam.yh.lee@gmail.com>
Message-ID: <20150717090039.GC9331@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

To get a chance of this patch being considered for inclusion, you
should send this to the maintainers of the phy and iio framework.
There is a high chance, that none of them will see your mail.

On Thu, Jul 16, 2015 at 03:20:27PM -0700, Adam YH Lee wrote:
> MADC[3:6] reads incorrect values without these two following changes:

uhm MADC[3:6] are externally available analog inputs. Your
change will result in them being tied to the USB module.

> - enable the 3v1 bias regulator for ADC[3:6]

The regulator is not required for correct MADC functionality, but
for correct USB measureing. The regulator should not be requested
by the madc module, but by the usb module, which is connected to
the madc.

> - configure ADC[3:6] lines as input, not as USB

I don't think that should be done for all boards.

> [...]

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/e0810b09/attachment.sig>

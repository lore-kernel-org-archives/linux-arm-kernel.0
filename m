From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 23 May 2015 19:41:49 +0200
Subject: [PATCH V2 3/6] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <1430346747-28728-4-git-send-email-stefan.wahren@i2se.com>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
 <1430346747-28728-4-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20150523174149.GA16004@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 29, 2015 at 10:32:24PM +0000, Stefan Wahren wrote:
> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
> power subsystem. It's required to trigger the probing of the underlying
> drivers like on-chip regulators.

I'm not sure what you need the power supply class for. I see only
one property (ac connected), which is constant. Maybe just drop
the power supply stuff?

This would leave an almost empty driver, which just sets a single
register at probe time and probes more drivers. That would probably
be more fitting for the MFD subsystem.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150523/d2e569a5/attachment.sig>

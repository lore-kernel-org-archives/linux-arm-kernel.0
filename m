From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Feb 2016 10:33:45 +0100
Subject: Allwinner A64 MMC support
In-Reply-To: <56C1D9C0.6020601@arm.com>
References: <1455300000-18723-1-git-send-email-andre.przywara@arm.com>
 <56BE29A1.3060107@redhat.com> <56C1A590.6030500@arm.com>
 <56C1C7BB.1040602@redhat.com> <56C1D9C0.6020601@arm.com>
Message-ID: <20160216093345.GJ4344@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Mon, Feb 15, 2016 at 01:59:28PM +0000, Andre Przywara wrote:
> 2) The reset node is a allwinner,sun6i-a31-ahb1-reset, which does not
> get registered automatically, but by an explicit call from mach-sunxi/.
> I wonder why we do this (yes, I saw that comment, but still...) and if
> it would work with a normal MODULE_DEVICE_TABLE() declaration.

Because we need to access the reset controller at the time the timer
is probed, which is way before the device model is initilized, and the
"real" reset controller driver is probed.

I'm not really fond of the solution either, but there's no other
solution, if we set aside "rework the driver / device model so that it
initializes properly".

> There is and will be no equivalent to the mach- directory on arm64.

Then you cannot use the HS timer.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160216/ed962901/attachment-0001.sig>

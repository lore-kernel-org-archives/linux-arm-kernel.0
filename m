From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Jun 2013 10:05:18 +0200
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <20130603183057.GA9868@1wt.eu>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130603171017.GN18614@n2100.arm.linux.org.uk>
 <20130603175629.GH5008@1wt.eu>
 <20130603181437.GO3803@titan.lakedaemon.net>
 <20130603183057.GA9868@1wt.eu>
Message-ID: <20130604100518.167484e1@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Willy, Jason,

On Mon, 3 Jun 2013 20:30:57 +0200, Willy Tarreau wrote:

> I remember this discussion, but it is different and does not apply here.
> Sebastian fixed an issue with a properly configured NIC which used to
> lose its MAC, so the solution consisted in saving it early in the DT.
> 
> In the mv_neta case, the NICs are not configured yet and we need to
> find the MAC somewhere. I only found it in the ATAGs and nowhere else.
> Well, in fact u-boot sets it on the MAC used to boot from the network
> if such a boot is performed, but that's all. So in practice you boot
> without the MAC address anywhere but in the ATAGs. I'd be happy to
> find a way to parse non-standard atags in a board-specific file but
> they're lost early it seems :-(

I confirm this. Only the one NIC that was used for network booting gets
its MAC address assigned in the hardware registers, the other three NIC
have their MAC address left to zero by the bootloader. And of course,
if you don't do network booting, the four NICs will have their MAC left
to zero.

So Sebastian's approach does not work for mvneta.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

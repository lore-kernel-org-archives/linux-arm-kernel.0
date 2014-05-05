From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 May 2014 17:55:17 -0500
Subject: [PATCH 0/2] ARM: sunxi: Enable syscon for the system controller
In-Reply-To: <1399212160-26934-1-git-send-email-carlo@caione.org>
References: <1399212160-26934-1-git-send-email-carlo@caione.org>
Message-ID: <20140505225517.GE9464@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 04, 2014 at 04:02:38PM +0200, Carlo Caione wrote:
> The so called "system controller" in Allwinner A20 and A31 SoCs is
> multi-purpose controller that tries to add misc functionality to one
> memory region.
> In these SoCs it controls the internal SRAM partitioning but it also
> includes registers for chip versioning and NMI control.
> This patch adds the proper nodes in the DTS files and enable the syscon
> in the defconfig files.
> 
> Even though the system controller includes also register for managing the
> NMI controller, these register are not mapped in the syscon since they
> are directly used and mapped by the NMI controller itself.

Hmmm, what exactly do you want to achieve with this?

The NMI controller won't be able to use it, since it's initialized
much earlier than syscon and regmap.

Moreover, the A31 doesn't seem to have this system controller, or at
least this overlap.

And since on the A20, registers seem to have one usage only, so I
guess we can just split this IP into several nodes, just like we did
with the NMI.

Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140505/94cab0bb/attachment.sig>

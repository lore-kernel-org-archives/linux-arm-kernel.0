From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Feb 2015 21:31:37 +0100
Subject: [PATCH 08/10] ARM: mvebu: add core support for Armada 39x
In-Reply-To: <1423238276-9206-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1423238276-9206-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150206203137.GH2079@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, Feb 06, 2015 at 04:57:54PM +0100, Thomas Petazzoni wrote:
> This commit adds the core support for Armada 39x, which is quite
> simple:
> 
>  - a new Kconfig option which selects the appropriate clock and
>    pinctrl drivers as well as other common features (GIC, L2 cache,
>    SMP, etc.)
> 
>  - a new DT_MACHINE_START which references the top-level compatible
>    strings supported for the Marvell Armada 39x.
> 
>  - a new SMP enable-method. The mechanism to enable CPUs for Armada
>    39x appears to be the same as Armada 38x. However, we do want to

                                                              ^ not?

>    use marvell,armada-380-smp in the Device Tree, in the case of the
>    discovery of a subtle difference in the future, which would require
>    changing the Device Tree. And the enable-method isn't a compatible
>    string: you can't specify several values and expect a fallback on
>    the second string if the first one isn't supported. Therefore, we
>    simply declare the SMP enable method "marvell,armada-390-smp" as
>    doing the same thing as the "marvell,armada-380-smp" one.
> 

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150206/562eab45/attachment.sig>

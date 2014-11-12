From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Nov 2014 14:37:27 +0100
Subject: [PATCH V2 1/1] ARM: dts: sunxi: Banana Pi: increase
 startup-delay for the GMAC PHY regulator
In-Reply-To: <1415746906-20835-2-git-send-email-merker@debian.org>
References: <1415539714-7652-1-git-send-email-merker@debian.org>
 <1415746906-20835-1-git-send-email-merker@debian.org>
 <1415746906-20835-2-git-send-email-merker@debian.org>
Message-ID: <20141112133727.GO14919@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 12:01:46AM +0100, Karsten Merker wrote:
> On the LeMaker Banana Pi, probing the external ethernet PHY connected
> to the SoC's internal GMAC module sometimes fails. The PHY power
> supply is handled via a GPIO-controlled regulator, and the existing
> regulator startup-delay of 50000us is too short to make sure that the
> PHY is always fully powered up when it is queried by phylib. Tests
> have shown that to provide a reliable PHY detection, the startup-delay
> has to be increased to at least 60000us. To have a certain safety margin
> and to cater for manufacturing variations between different boards,
> the delay gets set to 100000us as discussed on the linux-arm-kernel
> mailinglist.
> 
> Signed-off-by: Karsten Merker <merker@debian.org>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Merged, thanks.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/40e14133/attachment.sig>

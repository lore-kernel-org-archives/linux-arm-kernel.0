From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Sep 2015 08:42:58 +0200
Subject: [PATCH 1/3] Revert "ARM: dts: sun8i: Add new
 sun8i-a33-q8-tzx-723q4.dts file"
In-Reply-To: <1443108234-14837-1-git-send-email-hdegoede@redhat.com>
References: <1443108234-14837-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150925064258.GA4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 05:23:52PM +0200, Hans de Goede wrote:
> The tzx-723q[a]4 board variant of A33 based Q8 formfactor tablets was
> given its own dts file because the mmc would not work with a drive
> strength of 30mA, Android seemed to be using a lower drive-strength
> and doing the same with the upstream kernel seemed to fix this issue.
> 
> While working on a similar fix for u-boot I noticed that Android did
> not use a lower drive strength for mmc0, but for mmc1, so mmc0 should
> work fine with a drive strength of 30mA.
> 
> Further investigation has shown that Allwinner is using slightly
> tweaked clock sample phase settings in newer Android kernels, and
> that updating the mainstream sunxi mmc driver to these settings fixes
> this.
> 
> With this fixed we no longer need a dts file specifically for these
> pcb varants -> drop this dts file.

I dropped the patch.

> This reverts commit fb61c559a810f1487892b83d2d0606af1d020318.

Checkpatch prints an error about this one. Make sure you have the
right commit format.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150925/02333d50/attachment.sig>

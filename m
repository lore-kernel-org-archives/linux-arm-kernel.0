From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 20:44:38 +0200
Subject: [PATCH ] ARM: sunxi: Add Emac,SMP and Arch_timer support for
 sunxi A20;Add phy cnt arch timer for ARMv7 support.
In-Reply-To: <65babca9.e1d6.1410e206c2e.Coremail.coosty@163.com>
References: <16b7467c.1f121.141089f3d81.Coremail.coosty@163.com>
 <65babca9.e1d6.1410e206c2e.Coremail.coosty@163.com>
Message-ID: <20130911184438.GJ2746@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fan,

On Thu, Sep 12, 2013 at 01:45:07AM +0800, cini wrote:
> I have released the new patchs that is clean?
> 0001-Add-smp-support-for-Allwinner-A20-sunxi-7i.patch
> 0002-Add-cpuconfig-nodes-in-dts-for-smp-configure.patch
> 0003-Add-physical-count-arch-timer-support-for-clocksourc.patch
> 0004-Add-arch-count-timer-node-in-dts-for-Allwinner-A20-s.patch
> 0005-Add-emac-node-for-Allwinner-A20-sun7i.patch
> 0006-Add-emac-node-in-dts-for-CubieBoard2.patch

Great, you're almost there.

Usually, we split up the series by what they are actually doing. In your
case, that would mean that you would send two set of patches, one for
the SMP support on the A20, and one for your arch timer patches. I
already sent a serie about the EMAC, so you can probably drop that one.

And to send these two series, you should send your patches in the mail
directly. git send-email makes that really easy, so I'd advise you to
actually use it. Along with these patches, we most of the time also send
a cover letter to introduce what we're doing in these patches, the
difficulties/drawbacks we faced, etc. In your case for example, this is
pretty much where you should put that you don't use the scu, and why you
don't use it. Finally, you should send it the relevant maintainers of
the files touched by your patches. You can get it quite easily by using
the get_maintainers.pl script in the scripts/ directory.

Don't forget to run the scrits/checkpatch.pl script on your patches, and
you'll be all set!

Thanks for your efforts,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/ce03a387/attachment.sig>

From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 13 Oct 2015 01:53:43 +0200
Subject: [PATCH v3] ARM: dts: twl4030: Add iio properties for bci subnode
In-Reply-To: <20151012222009.GH23801@atomide.com>
References: <1443212447-5841-1-git-send-email-marek@goldelico.com>
 <1443212447-5841-3-git-send-email-marek@goldelico.com>
 <20150926172936.GD22315@earth>
 <CAAfyv36nZ3c-yw7QQHwBWk3GwY31rV3Uq2n0dz5hppn5JFhEcA@mail.gmail.com>
 <20151012213827.GC23801@atomide.com>
 <20151012222009.GH23801@atomide.com>
Message-ID: <20151012235343.GA7755@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 12, 2015 at 03:20:10PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [151012 14:43]:
> > * Belisko Marek <marek.belisko@gmail.com> [150926 13:02]:
> > > Tony sorry I forgot to add you to the recipients for this patchset.
> > > Can you please queue this patch. Many thanks.
> > 
> > OK applying into omap-for-v4.4/dt thanks.
> 
> Actually dropping this one, it makes build fail as we don't
> have twl4030_madc yet.
> 
> Maybe please send a separate set of dts patches for me.

mh that's strange, twl4030-madc is there since a long time. But
checking the patch, it seems Marek got the phandle wrong:

$ grep -B1 "ti,twl4030-madc" arch/arm/boot/dts/twl4030.dtsi
	twl_madc: madc {
		compatible = "ti,twl4030-madc";

Once that is fixed, the patch should have no dependencies.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151013/d9f28361/attachment.sig>

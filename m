From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 21 Sep 2016 09:43:29 +0200
Subject: [PATCH 3/4] ARM: tegra: nyan-big: Include compatible revisions
 for proper detection
In-Reply-To: <6501341f-e14c-4876-dcb7-60a33b7621c4@nvidia.com>
References: <20160828173246.32621-1-contact@paulk.fr>
 <20160828173246.32621-3-contact@paulk.fr>
 <a9485a88-55a5-9dd1-1a1b-a6c0a78ff476@nvidia.com>
 <1474394004.1215.2.camel@paulk.fr>
 <d05b8e5a-adf7-9057-b42a-0da1fde84953@nvidia.com>
 <1474394544.1215.13.camel@paulk.fr>
 <6501341f-e14c-4876-dcb7-60a33b7621c4@nvidia.com>
Message-ID: <1474443809.1239.4.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 21 septembre 2016 ? 08:34 +0100, Jon Hunter a ?crit?:
> On 20/09/16 19:02, Paul Kocialkowski wrote:
> > 
> > * PGP Signed by an unknown key
> > 
> > Le mardi 20 septembre 2016 ? 18:56 +0100, Jon Hunter a ?crit :
> > > 
> > > On 20/09/16 18:53, Paul Kocialkowski wrote:
> > > > 
> > > > 
> > > > > 
> > > > > Old Signed by an unknown key
> > > > 
> > > > Le mardi 20 septembre 2016 ? 18:41 +0100, Jon Hunter a ?crit :
> > > > > 
> > > > > 
> > > > > On 28/08/16 18:32, Paul Kocialkowski wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > Depthcharge (the payload used with cros devices) will attempt to
> > > > > > detect
> > > > > > boards using their revision. This includes all the known revisions
> > > > > > for
> > > > > > the nyan-big board so that the dtb can be selected preferably.
> > > > > 
> > > > > May be I am missing something here, but for the mainline there is only
> > > > > one dtb available and so why is this needed for the mainline?
> > > > 
> > > > There is indeed a single dts in mainline, but depthcharge will use the
> > > > revision
> > > > to match the compatible string (e.g. it will look for google,nyan-big-
> > > > rev5,
> > > > not
> > > > google,nyan-big), so we need to list them all in that single dts.
> > > > Otherwise,
> > > > depthcharge will fall back to the default config, which may or may not
> > > > be
> > > > suitable for nyan.
> > > 
> > > Is tegra124-nyan-big.dtb not the default?
> > 
> > You can't expect that to always be the case. The image format allows many
> > different dts to be provided, so I could easily build with
> > multi_v7_defconfig
> > and have various dts for various devices in the same image, and just select
> > a
> > random one as default.
> 
> Really? Sounds odd. I was hoping that tegra124-nyan-big.dtb would be a
> catch all.

Yes, the image format (FIT) allows specifying multiple dtb and zImage
combinations in the same image[0].

See depthcharge[|1] for how the "compatible" property is being matched against.

> > Here, default is really a fallback, the right one is expected to be detected
> > by
> > this mechanism. And it really doesn't hurt to provide that information for
> > proper detection.
> > 
> > Note that this is done with many other cros devices in mainline (such as
> > rk3288
> > veyrons).
> 
> Yes, I guess the same is true for the tegra210-smaug and we do define
> all the revs for that one. May be extend the changelog comment to say
> what may happen without this change and the problem that this is fixing.

Allright, will do!

Thanks

[0]:?http://www.denx.de/wiki/pub/U-Boot/Documentation/multi_image_booting_scenarios.pdf
[1]:?https://chromium.googlesource.com/chromiumos/platform/depthcharge/+/master/src/boot/fit.c#39

-- 
Paul Kocialkowski, developer of low-level free software for embedded devices

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160921/d16c5577/attachment.sig>

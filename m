From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 25 Jan 2017 12:19:48 +0100
Subject: [PATCH v2 3/6] ARM: tegra: nyan-big: Include compatible
 revisions for proper detection
In-Reply-To: <20170125111458.GH9344@ulmo.ba.sec>
References: <20170122154753.31942-1-contact@paulk.fr>
 <20170122154753.31942-3-contact@paulk.fr>
 <20170125110246.GD9344@ulmo.ba.sec> <1485342488.1224.3.camel@paulk.fr>
 <20170125111458.GH9344@ulmo.ba.sec>
Message-ID: <1485343188.1224.4.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 25 janvier 2017 ? 12:14 +0100, Thierry Reding a ?crit?:
> On Wed, Jan 25, 2017 at 12:08:08PM +0100, Paul Kocialkowski wrote:
> > Le mercredi 25 janvier 2017 ? 12:02 +0100, Thierry Reding a ?crit?:
> > > On Sun, Jan 22, 2017 at 04:47:50PM +0100, Paul Kocialkowski wrote:
> > > > Depthcharge (the payload used with cros devices) will attempt to detect
> > > > boards using their revision. This includes all the known revisions for
> > > > the nyan-big board so that the dtb can be selected preferably.
> > > > 
> > > > Defining compatibly revisions allows depthcharge to select the kernel
> > > > via the revision it detects instead of using the default kernel. This
> > > > allows having a FIT image with multiple kernels for multiple devices.
> > > > 
> > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > ---
> > > > ?arch/arm/boot/dts/tegra124-nyan-big.dts | 7 ++++++-
> > > > ?1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > I've applied this, with a small change, see below.
> > > 
> > > > diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts
> > > > b/arch/arm/boot/dts/tegra124-nyan-big.dts
> > > > index 67d7cfb32541..f12ece9b76a6 100644
> > > > --- a/arch/arm/boot/dts/tegra124-nyan-big.dts
> > > > +++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
> > > > @@ -6,7 +6,12 @@
> > > > ?
> > > > ?/ {
> > > > ?	model = "Acer Chromebook 13 CB5-311";
> > > > -	compatible = "google,nyan-big", "nvidia,tegra124";
> > > > +	compatible = "google,nyan-big-rev7", "google,nyan-big-rev6",
> > > > +			"google,nyan-big-rev5", "google,nyan-big-rev4",
> > > > +			"google,nyan-big-rev3", "google,nyan-big-rev2",
> > > > +			"google,nyan-big-rev5", "google,nyan-big-rev4",
> > > 
> > > This line is the same as two lines above, so I've removed this one. I've
> > > also used slightly different padding (two tabs and align to the first
> > > string in the first line with spaces) to make it consistent with other
> > > string lists in the file.
> > 
> > Oops, sorry I missed that last faulty line. Actually, it should have
> > contained:
> > "google,nyan-blaze-rev1", "google,nyan-blaze-rev0";
> > 
> > instead so that all revision, from 7 down to 0 are covered.
> > 
> > Should I make another patch on top to fix that?
> 
> Here's what I've put into Tegra's for-next, that has all the necessary
> revisions, doesn't it?
> 
> 	https://git.kernel.org/cgit/linux/kernel/git/tegra/linux.git/commit/?h=f
> or-next&id=bfa3c0d4e8ba8eff525d34dbde0e76a98ebfbade
> 
> If so, no need for another patch.

Excellent, it's all there! Thanks a bunch.

-- 
Paul Kocialkowski, developer of free digital technology at the lower levels

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/39cb14e4/attachment.sig>

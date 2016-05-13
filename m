From: dev@lynxeye.de (Lucas Stach)
Date: Fri, 13 May 2016 21:08:50 +0200
Subject: [PATCH] ARM: tegra: beaver: allow SD card voltage to be changed
In-Reply-To: <20160513172704.GA498@ulmo.ba.sec>
References: <1456779678-20173-1-git-send-email-dev@lynxeye.de>
 <1463124331.2459.0.camel@lynxeye.de> <20160513172704.GA498@ulmo.ba.sec>
Message-ID: <1463166530.2556.5.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 13.05.2016, 19:27 +0200 schrieb Thierry Reding:
> On Fri, May 13, 2016 at 09:25:31AM +0200, Lucas Stach wrote:
> > 
> > Am Montag, den 29.02.2016, 22:01 +0100 schrieb Lucas Stach:
> > > 
> > > This allows to switch the card signal voltage level to 1.8V,
> > > which is needed for any ultra high speed modes to work.
> > > 
> > > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > > ---
> > > This needs the SDMMC memcomp pad calibration patches I just
> > > sent out to be applied, otherwise the card voltage change will
> > > fail with a message in the kernel log and a fall back to
> > > high speed operation.
> > The patches this one depends on have been applied for some time
> > now.
> > Please pick up this patch.
> My understanding is that UHS modes currently cause problems on
> Beaver.
> What I don't understand about that is how it will even try those
> modes
> if the voltage regulator can't be set to 1.8 V? Shouldn't that
> actively
> prevent those modes from even being attempted?
> 
AFAIK this is right. I haven't re-tested with v4.6 yet, but on v4.5
without this change the high-speed modes using 1.8V signaling would not
be used on the SD card. As eMMC doesn't need the voltage switch, this
one will work in high-speed mode on Beaver.

Regards,
Lucas

From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 13 May 2016 19:27:04 +0200
Subject: [PATCH] ARM: tegra: beaver: allow SD card voltage to be changed
In-Reply-To: <1463124331.2459.0.camel@lynxeye.de>
References: <1456779678-20173-1-git-send-email-dev@lynxeye.de>
 <1463124331.2459.0.camel@lynxeye.de>
Message-ID: <20160513172704.GA498@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2016 at 09:25:31AM +0200, Lucas Stach wrote:
> Am Montag, den 29.02.2016, 22:01 +0100 schrieb Lucas Stach:
> > This allows to switch the card signal voltage level to 1.8V,
> > which is needed for any ultra high speed modes to work.
> > 
> > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> > ---
> > This needs the SDMMC memcomp pad calibration patches I just
> > sent out to be applied, otherwise the card voltage change will
> > fail with a message in the kernel log and a fall back to
> > high speed operation.
> 
> The patches this one depends on have been applied for some time now.
> Please pick up this patch.

My understanding is that UHS modes currently cause problems on Beaver.
What I don't understand about that is how it will even try those modes
if the voltage regulator can't be set to 1.8 V? Shouldn't that actively
prevent those modes from even being attempted?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160513/eda0eaad/attachment.sig>

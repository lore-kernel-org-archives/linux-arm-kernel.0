From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Nov 2016 10:58:36 +0000
Subject: [PATCH] ARM: dts: mvebu: Add Armada 38x labels and clean up
 Turris Omnia
In-Reply-To: <4ad1108a-43c4-46f8-4683-1c4b89996036@suse.de>
References: <1fc18002-0144-8300-1888-09f456860ef0@kleine-koenig.org>
 <1480272700-28888-1-git-send-email-afaerber@suse.de>
 <20161128103738.GT14217@n2100.armlinux.org.uk>
 <4ad1108a-43c4-46f8-4683-1c4b89996036@suse.de>
Message-ID: <20161128105836.GU14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 11:52:26AM +0100, Andreas F?rber wrote:
> Hi Russell,
> 
> Am 28.11.2016 um 11:37 schrieb Russell King - ARM Linux:
> > On Sun, Nov 27, 2016 at 07:51:39PM +0100, Andreas F?rber wrote:
> >> To more consistently reference nodes by label, add labels for sata,
> >> usb2, sdhci and usb3 nodes.
> >>
> >> Convert all other 38x boards for consistency. Add labels for nfc and rtc.
> > 
> > Please don't do this for clearfog - there's changes in the pipeline which
> > completely replace armada-388-clearfog.dts because there's a "base" and
> > "pro" versions of this hardware now, and making such a huge change will
> > effectively mean we have to start over with the DT files.
> 
> Would it help to split it back up into a series of add-labels,
> use-labels like I had originally? Then you could start using them in
> your refactoring as soon as the add-labels patch gets applied. Or are
> you completely against this style?

What I mentioned is not a case of a work in progress, it's already out
in the wild, and completely changing the clearfog dts file by changing
the style of DT references will make applying the changes _much_ more
difficult - not only obviously impossible to apply the original patch,
but also quite impossible to identify the changes made downstream.

So, I'd rather armada-388-clearfog.dts is not touched at all as it _will_
cause conflicts, but I have nothing against the new style (and I actually
prefer it.)

What I'm asking is that you don't make other people's lives harder than
they need to be.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

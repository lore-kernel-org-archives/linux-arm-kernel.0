From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 2 Oct 2018 15:13:12 +0200
Subject: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable
 eMMC.
In-Reply-To: <CAG7TQgGS7DkLpNVYqfCD-9vMZkeY6r+L-5oXKWef3x-OVbqjtw@mail.gmail.com>
References: <20180919141815.18737-1-rodrigo@tjader.xyz>
 <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
 <20180925090139.qbu6tqav5oth7zkw@flea>
 <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
 <20180927081711.llmwnvpu73loe5iv@flea>
 <CAG7TQgGMkvBnNE_WEth8gscKxN3qN8a44mNMWz3QP-2+JKfOzg@mail.gmail.com>
 <20180929154754.abz3byvrufvnf4dq@flea>
 <CAG7TQgGS7DkLpNVYqfCD-9vMZkeY6r+L-5oXKWef3x-OVbqjtw@mail.gmail.com>
Message-ID: <20181002131312.soqwybsohdifvso3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2018 at 01:51:02PM -0300, Rodrigo Exterck?tter Tj?der wrote:
> On Sat, Sep 29, 2018 at 12:47 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Thu, Sep 27, 2018 at 11:49:20AM -0300, Rodrigo Exterck?tter Tj?der wrote:
> > > On Thu, Sep 27, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Tue, Sep 25, 2018 at 02:47:59PM -0300, Rodrigo Exterck?tter Tj?der wrote:
> > > > > On Tue, Sep 25, 2018 at 6:01 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > We can't really do that, unfortunately. If the device tree name was to
> > > > > > change for a given board, we'd break all the build systems, boot
> > > > > > scripts and distros out there.
> > > > >
> > > > > What if we keep the device tree for the version without WiFi and eMMC
> > > > > with the current name and create new device trees for the other two
> > > > > versions?
> > > >
> > > > Wifi and Bluetooth should be dealt with with overlays in this case,
> > > > and since the eMMC is already enabled, then there's nothing to do, I
> > > > guess.
> > >
> > > It's WiFi that is already enabled, not eMMC. Only one of the three
> > > variants has WiFi.
> >
> > Ah, right, sorry. In the board that doesn't have an emmc, are the pins
> > usable for something else?
> 
> I don't have the variant without eMMC nor could I find pictures of it.
> The schematics do mention that the A64 pins could be used to control
> NAND flash, but you'd have to solder that yourself.

Ok.

> > > We can't even remove a node from a device tree? Removing the WiFi node
> > > from the current tree would make it correspond to the variant with the
> > > least features.
> >
> > Not really. How pissed would you be if you were a user, had wifi
> > running on your board, you upgrade your kernel, and then it's just
> > gone? :)
> 
> That would suck, but what about someone who has the board with no wifi
> and problems start happening because the wifi is enabled on the device
> tree?

Did that happen or is it a theoretical issue?

> > > About device tree overlays, I read overlay-notes.txt, but I went
> > > looking for an example with "git grep /plugin/ arch" and it came
> > > empty. Is this approach not used for other boards?
> >
> > It is, it's simply not stored in the kernel, but through other third
> > party repos.
> 
> So that would mean that it's up to every distro to support the boards
> instead of relying on mainline support?

Distros would have to integrate it either way. One would need to
detect and / or ask for the board variant in order to load say the BT
stack, or to know if you want to boot from the eMMC or from the SD
card.

> > > Does the overlay approach make the device available at boot time? That
> > > is important for a storage device such as eMMC.
> > >
> > > I went with the separate dts approach because that's what I saw was
> > > done for other similar cases, like Pine64 and Pine64+, OLinuXino-LIME2
> > > and its variant with eMMC, among others.
> >
> > Yeah, but in all these cases, it was done from day one, not after the
> > facts.
> 
> For the LIME2 the dts for the emmc variant was commited two years
> after the base LIME2 dts.
> 
> What if instead of keeping the current dt for the least featureful
> model we keep it for the most featureful model and create new dts for
> the two less featureful models?

This is a different story though. The LIME2 eMMC variant was created
way after the original LIME2, with a separate name.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181002/3eb11f33/attachment.sig>

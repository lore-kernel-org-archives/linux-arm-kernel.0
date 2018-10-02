From: rodrigo@tjader.xyz (=?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?=)
Date: Tue, 2 Oct 2018 13:47:33 -0300
Subject: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable
 eMMC.
In-Reply-To: <20181002131312.soqwybsohdifvso3@flea>
References: <20180919141815.18737-1-rodrigo@tjader.xyz>
 <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
 <20180925090139.qbu6tqav5oth7zkw@flea>
 <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
 <20180927081711.llmwnvpu73loe5iv@flea>
 <CAG7TQgGMkvBnNE_WEth8gscKxN3qN8a44mNMWz3QP-2+JKfOzg@mail.gmail.com>
 <20180929154754.abz3byvrufvnf4dq@flea>
 <CAG7TQgGS7DkLpNVYqfCD-9vMZkeY6r+L-5oXKWef3x-OVbqjtw@mail.gmail.com>
 <20181002131312.soqwybsohdifvso3@flea>
Message-ID: <CAG7TQgHWCJTaM+pFYFq0_8nWg7sA+d0huqu96sjhqZfeHwqbGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2018 at 10:13 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sat, Sep 29, 2018 at 01:51:02PM -0300, Rodrigo Exterck?tter Tj?der wrote:
> > On Sat, Sep 29, 2018 at 12:47 PM Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > > > We can't even remove a node from a device tree? Removing the WiFi node
> > > > from the current tree would make it correspond to the variant with the
> > > > least features.
> > >
> > > Not really. How pissed would you be if you were a user, had wifi
> > > running on your board, you upgrade your kernel, and then it's just
> > > gone? :)
> >
> > That would suck, but what about someone who has the board with no wifi
> > and problems start happening because the wifi is enabled on the device
> > tree?
>
> Did that happen or is it a theoretical issue?

Theoretical. I don't know how likely having a non-existant device
enabled is to cause problems.

> > > > About device tree overlays, I read overlay-notes.txt, but I went
> > > > looking for an example with "git grep /plugin/ arch" and it came
> > > > empty. Is this approach not used for other boards?
> > >
> > > It is, it's simply not stored in the kernel, but through other third
> > > party repos.
> >
> > So that would mean that it's up to every distro to support the boards
> > instead of relying on mainline support?
>
> Distros would have to integrate it either way. One would need to
> detect and / or ask for the board variant in order to load say the BT
> stack, or to know if you want to boot from the eMMC or from the SD
> card.

Yeah, but now if a bug is found in the device tree it has to be fixed
once per distro instead of only on mainline.

> > > > Does the overlay approach make the device available at boot time? That
> > > > is important for a storage device such as eMMC.
> > > >
> > > > I went with the separate dts approach because that's what I saw was
> > > > done for other similar cases, like Pine64 and Pine64+, OLinuXino-LIME2
> > > > and its variant with eMMC, among others.
> > >
> > > Yeah, but in all these cases, it was done from day one, not after the
> > > facts.
> >
> > For the LIME2 the dts for the emmc variant was commited two years
> > after the base LIME2 dts.
> >
> > What if instead of keeping the current dt for the least featureful
> > model we keep it for the most featureful model and create new dts for
> > the two less featureful models?
>
> This is a different story though. The LIME2 eMMC variant was created
> way after the original LIME2, with a separate name.

What about the idea of keeping the current dt for the most featureful
variant and creating new dts for the other two?

That would make it so that no one's device stops working and would
have mailine support for all three devices.

Also, the current device tree doesn't represent any existing device:
it has wifi on but no emmc. That variation does not exist.

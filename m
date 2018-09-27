From: rodrigo@tjader.xyz (=?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?=)
Date: Thu, 27 Sep 2018 11:49:20 -0300
Subject: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable
 eMMC.
In-Reply-To: <20180927081711.llmwnvpu73loe5iv@flea>
References: <20180919141815.18737-1-rodrigo@tjader.xyz>
 <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
 <20180925090139.qbu6tqav5oth7zkw@flea>
 <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
 <20180927081711.llmwnvpu73loe5iv@flea>
Message-ID: <CAG7TQgGMkvBnNE_WEth8gscKxN3qN8a44mNMWz3QP-2+JKfOzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Sep 25, 2018 at 02:47:59PM -0300, Rodrigo Exterck?tter Tj?der wrote:
> > On Tue, Sep 25, 2018 at 6:01 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > We can't really do that, unfortunately. If the device tree name was to
> > > change for a given board, we'd break all the build systems, boot
> > > scripts and distros out there.
> >
> > What if we keep the device tree for the version without WiFi and eMMC
> > with the current name and create new device trees for the other two
> > versions?
>
> Wifi and Bluetooth should be dealt with with overlays in this case,
> and since the eMMC is already enabled, then there's nothing to do, I
> guess.

It's WiFi that is already enabled, not eMMC. Only one of the three
variants has WiFi.

We can't even remove a node from a device tree? Removing the WiFi node
from the current tree would make it correspond to the variant with the
least features.

About device tree overlays, I read overlay-notes.txt, but I went
looking for an example with "git grep /plugin/ arch" and it came
empty. Is this approach not used for other boards?

Does the overlay approach make the device available at boot time? That
is important for a storage device such as eMMC.

I went with the separate dts approach because that's what I saw was
done for other similar cases, like Pine64 and Pine64+, OLinuXino-LIME2
and its variant with eMMC, among others.

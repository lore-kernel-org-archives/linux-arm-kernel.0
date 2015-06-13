From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 13 Jun 2015 15:50:55 +0200
Subject: [linux-sunxi] [PATCH 2/8] mfd: axp20x: Add a cell for the usb
 power_supply part of the axp20x PMICs
In-Reply-To: <5577EDD9.8020900@redhat.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-3-git-send-email-hdegoede@redhat.com>
 <CAGb2v652W+i6L1k5-CnHtXZXdJjFswkcyFGromhWSYaXtitW_w@mail.gmail.com>
 <5577EDD9.8020900@redhat.com>
Message-ID: <20150613135055.GQ19653@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 09:57:13AM +0200, Hans de Goede wrote:
> >>@@ -368,6 +392,12 @@ static struct mfd_cell axp20x_cells[] = {
> >>                 .resources              = axp20x_pek_resources,
> >>         }, {
> >>                 .name                   = "axp20x-regulator",
> >>+       }, {
> >>+               .name                   = "axp20x-usb-power-supply",
> >
> >Could we use either "vbus-power-supply" to match the AXP datasheets,
> >or "otg-power-supply" which is slightly more obvious to board owners?
> 
> I do not like the vbus name, since it does not indicate which bus
> it is, OTOH you are right that is what it is called in the datasheet.
> 
> As for using otg, I think that usb is better then.
> 
> All in all I believe that the current usb name is best, but if others
> disagree I'm open to renaming this.
> 
> So anyone else have an opinion on what would be a good name for the
> cell and the compatible ?

I usually prefer to use the name mentionned in the datasheet, but if
that doesn't make sense, feel free to use an alternative like this
one.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150613/3324ad71/attachment.sig>

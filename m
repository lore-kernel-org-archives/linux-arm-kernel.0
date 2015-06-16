From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 16 Jun 2015 19:55:12 +0200
Subject: [PATCH v2 6/6] ARM: sun8i: dts: Add Ippo-q8h v1.2 with A33 and
 1024x600 lcd support
In-Reply-To: <85E62D2D-5387-433B-A944-7F2145459F08@konsulko.com>
References: <1432997706-20172-1-git-send-email-hdegoede@redhat.com>
 <1432997706-20172-7-git-send-email-hdegoede@redhat.com>
 <20150602081459.GO23777@lukather> <556D6955.8030708@redhat.com>
 <20150603094535.GI23777@lukather> <556EE104.3090803@redhat.com>
 <20150613135002.GP19653@lukather>
 <85E62D2D-5387-433B-A944-7F2145459F08@konsulko.com>
Message-ID: <20150616175512.GJ11732@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pantelis,

On Sun, Jun 14, 2015 at 09:16:21PM +0300, Pantelis Antoniou wrote:
> > I think we need to discuss this with Pantelis and what is his feeling
> > about this.
> > 
> > Pantelis, to sum things up, we have a case of a tablet that comes with
> > the exact same board, but coming in two flavours with two differents
> > screen resolutions. It looks like a great case for your DT quirks
> > work, but we have no way of runtime detecting the difference between
> > the two variants. What do you think about this? Should we go with
> > using the DT quirks or is this simply out of scope?
> > 
> > There's not so much example of similar cases in the kernel, and none
> > of them use quirks so far (obviously) but they all boil down to either
> > the solution you were suggesting in that patch or adding the alternate
> > configuration as a comment.
> > 
> > I don't think the latter would work for you, and I agree with that, so
> > I guess that depending on what Pantelis says, either we go with a
> > better solution using the quirks, or we end up using what you
> > suggested (with a nitpick though, I'd prefer if you used the display
> > standard instead of the resolution, which would make it xga I guess?)
> > 
> 
> First of all, the quirks interface is at an RFC stage (new name
> suggested is ?variants?); getting that out of the way this seems
> like what it is designed to do.
> 
> The idea of the DT quirks is to drastically cut down on the number
> of different DTs required, each different for each board with minute
> differences from one another.

We're on the same page then :)

> In your case you have boards that have no way to be probed about
> what they ?are?, but that?s no big problem. You can easily pass the
> board variant in the kernel command line and use that to select the
> quirk to apply.

Hans actually pointed out that this would just move the logic
somewhere else, but not remove it. In our case, that would mean U-Boot
(Hans being the U-Boot maintainer for the SoCs that are used in this
particular board).

That would still require us to have a different configuration and to
add some logic to pass that extra parameter to the kernel. I'd be glad
to have less stuff in the kernel, but I can understand that he doesn't
want more stuff either.

> In fact the original patchset does contain a command line quirk for
> enabling and disabling the onboard emmc & hdmi of the beaglebone
> black for capes that need to use those signals.

Ah. I somehow overlooked that when reading it.

> Saying that, if you?re in a hurry I?d say go with a different DTSs
> for now, since that?s going to go in a near kernel cycle; DT quirks
> will be discussed at plumber?s in a couple of months, and then we?ll
> if it will go in and in what form.

Ok. I won't be here this year, but if you could raise the topic of how
to handle "non-discoverable boards" then, it would be great.

Hans, I guess we can go for your suggestion then: apply a "generic" DT
for the board right now, we're going to need it anyway. Then, when
will have real display support, depending on the current state of the
discussion for the quirks, we will either merge a different DT
including the generic one, or if the quirks have something that work
for both of us then, use the quirks. Sounds good?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150616/628f0871/attachment-0001.sig>

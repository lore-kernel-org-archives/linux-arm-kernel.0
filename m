From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Aug 2015 23:02:08 +0200
Subject: [PATCH 6/6] ARM: dts: sun6i: Add dts file for MSI Primo81 tablet
In-Reply-To: <20150828163144.239e9bd5@i7>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
 <1440755679-8266-7-git-send-email-wens@csie.org>
 <20150828123805.GN29389@lukather> <20150828163144.239e9bd5@i7>
Message-ID: <20150828210208.GU29389@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 28, 2015 at 04:31:44PM +0300, Siarhei Siamashka wrote:
> > > external connectors are represented by MicroSD slot, MiniHDMI, MicroUSB
> > > OTG and 3.5mm headphone jack. More details are available at
> > > 
> > >     http://linux-sunxi.org/MSI_Primo81
> > 
> > Again, not a huge fan of the commit logs URL...
> 
> But you are not strongly objecting to it either, right?
> 
> AFAIK many people are in favour of having links to the device pages in
> the linux-sunxi wiki listed somewhere in the commit logs or along with
> the board maintainer contact information (in U-Boot).

[citation needed]

And it's a good thing that we're in Linux then.

> Because these pages contain the most relevant and up to date
> information about the device, various pictures, tips and tricks,
> etc.
> 
> If you are worried about linux-sunxi.org suddenly going down and not
> coming back, there is also webarchive:
> 
>     http://web.archive.org/web/*/http://linux-sunxi.org/MSI_Primo81

If you have to look in web archive to find that page, you can just as
well use google in the first place?

> > This commit log is already fine without it.
> 
> This commit log is a nice example of why having a link to the wiki page
> is a good idea. The errors and omissions in the wiki page can be
> corrected. The old commit logs can't.

Which is exactly why we shouldn't have URLs. Because we can't fix them
when they become irrelevant.

Plus, quoting SubmittingPatches

"
When you submit or resubmit a patch or patch series, include the
complete patch description and justification for it.  Don't just
say that this is version N of the patch (series).  Don't expect the
subsystem maintainer to refer back to earlier patch versions or referenced
URLs to find the patch description and put that into the patch.
I.e., the patch (series) and its description should be self-contained.
"

If the patch description is self-contained, there's no need for a
URL. And I really don't care about the board description being
comprehensive either, so there's nothing to edit.

> > > +&i2c1 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&i2c1_pins_a>;
> > > +	status = "okay";
> > > +
> > > +	ctp at 5d {
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&gt911_int_primo81>;
> > > +		compatible = "goodix,gt911";
> > > +		reg = <0x5d>;
> > > +		interrupt-parent = <&pio>;
> > > +		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>; /* PA3 */
> > > +		/*
> > > +		 * The default 0,0 coordinate is at the corner closest to
> > > +		 * the headphone jack. X goes along the long side, while
> > > +		 * Y goes along the short side.
> > > +		 */
> > 
> > I'm not exactly sure what that comment is supposed to be for...
> 
> It's probably a human readable comment intended to be read by humans.
> 
> Yeah, this information might actually better belong to the wiki page.
> But then again, this brings us to the question whether we should have
> a link to the linux-sunxi wiki page somewhere in the dts.

I guess I'm not a human then, but a DT is definitely not the place I
would look at for such information, and I'm not sure a user that
didn't even build his kernel will either.

However, I'm pretty sure that if it was in a wiki page, any search
engine would return exactly the info I need, far more reliably than if
it was in the kernel source.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150828/a72d198b/attachment-0001.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Sep 2015 15:09:17 +0200
Subject: [PATCH 6/6] ARM: dts: sun6i: Add dts file for MSI Primo81 tablet
In-Reply-To: <20150829074303.0b2a4c0d@i7>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
 <1440755679-8266-7-git-send-email-wens@csie.org>
 <20150828123805.GN29389@lukather> <20150828163144.239e9bd5@i7>
 <20150828210208.GU29389@lukather> <20150829074303.0b2a4c0d@i7>
Message-ID: <20150910130917.GG9885@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 29, 2015 at 07:43:03AM +0300, Siarhei Siamashka wrote:
> On Fri, 28 Aug 2015 23:02:08 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Hi,
> > 
> > On Fri, Aug 28, 2015 at 04:31:44PM +0300, Siarhei Siamashka wrote:
> > > > > external connectors are represented by MicroSD slot, MiniHDMI, MicroUSB
> > > > > OTG and 3.5mm headphone jack. More details are available at
> > > > > 
> > > > >     http://linux-sunxi.org/MSI_Primo81
> > > > 
> > > > Again, not a huge fan of the commit logs URL...
> > > 
> > > But you are not strongly objecting to it either, right?
> > > 
> > > AFAIK many people are in favour of having links to the device pages in
> > > the linux-sunxi wiki listed somewhere in the commit logs or along with
> > > the board maintainer contact information (in U-Boot).
> > 
> > [citation needed]
> 
> Sure. I'm not going to search for every possible post in the mailing
> lists on this particular subject, but you can check this one for
> example:
>     http://lists.denx.de/pipermail/u-boot/2015-June/215675.html

I don't see any external links in the commit logs mentionned, just
comments in the defconfig?

> And also look here:
>     https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=0ff1ffd3fe86840c80458ea45c2379014c86b660

Yeah, some slipped through. My bad.

> > And it's a good thing that we're in Linux then.
> 
> What do you mean by this?

You mentionned that U-Boot had such a policy. This is not a U-Boot
patch.

> > > Because these pages contain the most relevant and up to date
> > > information about the device, various pictures, tips and tricks,
> > > etc.
> > > 
> > > If you are worried about linux-sunxi.org suddenly going down and not
> > > coming back, there is also webarchive:
> > > 
> > >     http://web.archive.org/web/*/http://linux-sunxi.org/MSI_Primo81
> > 
> > If you have to look in web archive to find that page, you can just as
> > well use google in the first place?
> 
> You *don't* have to look in web archive to find that page. That's
> only an emergency option, just in case if shit hits the
> fan. Hopefully we are never going to have to resort to this.

And my point is that you don't have to use the commit log to find that
page as well.

> Do you mean that the users probably will not think about the
> webarchive alternative in the case of emergency? If you are really
> so paranoid, it is possible to provide both the real wiki page url
> and the webarchive url. Does this solve the problem?

No. My point is that it provides *no* additional information, while
adding a fragile resource.

How many times did you turn to the commit log to find the URL of that
device on the wiki?

> 
> > > > This commit log is already fine without it.
> > > 
> > > This commit log is a nice example of why having a link to the wiki page
> > > is a good idea. The errors and omissions in the wiki page can be
> > > corrected. The old commit logs can't.
> > 
> > Which is exactly why we shouldn't have URLs. Because we can't fix them
> > when they become irrelevant.
> 
> By the very same reasoning, we shouldn't ever have e-mail addresses in
> the commit messages, documentation or source files. Because you know,
> they sometimes may change too. I mentioned e-mail addresses here because
> wiki pages and e-mail addresses both serve a very similar purpose:
> that's a contact information.
> 
> > 
> > Plus, quoting SubmittingPatches
> > 
> > "
> > When you submit or resubmit a patch or patch series, include the
> > complete patch description and justification for it.  Don't just
> > say that this is version N of the patch (series).  Don't expect the
> > subsystem maintainer to refer back to earlier patch versions or referenced
> > URLs to find the patch description and put that into the patch.
> > I.e., the patch (series) and its description should be self-contained.
> > "
> 
> There is a significant difference between "patch description" mentioned
> in this quotation (in other words, a commit message) and an external
> URL with additional useful information.
> 
> If you search "http:" substring in the "git log" output, then you can
> find a lot of various links to external web pages. Most of them are
> links to the archived discussions in the mailing lists or references
> to bugtracker issues. AFAIK there is no strict policy about prohibiting
> URLs in general.

Most of them hosted on kernel.org, which makes a huge difference.

> > If the patch description is self-contained, there's no need for a
> > URL. And I really don't care about the board description being
> > comprehensive either, so there's nothing to edit.
> 
> Finally looks like we have the real reasoning for stripping out URLs
> and other extra information: *you* don't care. Basically, that's your
> whim. And don't get me wrong, that's a perfectly valid explanation.
>  
> > > > > +&i2c1 {
> > > > > +	pinctrl-names = "default";
> > > > > +	pinctrl-0 = <&i2c1_pins_a>;
> > > > > +	status = "okay";
> > > > > +
> > > > > +	ctp at 5d {
> > > > > +		pinctrl-names = "default";
> > > > > +		pinctrl-0 = <&gt911_int_primo81>;
> > > > > +		compatible = "goodix,gt911";
> > > > > +		reg = <0x5d>;
> > > > > +		interrupt-parent = <&pio>;
> > > > > +		interrupts = <0 3 IRQ_TYPE_LEVEL_HIGH>; /* PA3 */
> > > > > +		/*
> > > > > +		 * The default 0,0 coordinate is at the corner closest to
> > > > > +		 * the headphone jack. X goes along the long side, while
> > > > > +		 * Y goes along the short side.
> > > > > +		 */
> > > > 
> > > > I'm not exactly sure what that comment is supposed to be for...
> > > 
> > > It's probably a human readable comment intended to be read by humans.
> > > 
> > > Yeah, this information might actually better belong to the wiki page.
> > > But then again, this brings us to the question whether we should have
> > > a link to the linux-sunxi wiki page somewhere in the dts.
> > 
> > I guess I'm not a human then, but a DT is definitely not the place I
> > would look at for such information, and I'm not sure a user that
> > didn't even build his kernel will either.
> 
> Why not? If the users are troubleshooting problems with the peripherals
> in their devices (such as the touchscreen in this particular example),
> why would they not look into a DTS file? It is one of the possible
> culprits and also a source of valuable information, which may aid
> debugging.

Because it comes bundled as a binary in the distributions, without
this comment? And since the code isn't indexed, it would be buried
somewhere any random user wouldn't even know the existence?

> And if a user doesn't have any device yet, but is only considering to
> buy something that is well supported by the Linux kernel, then why
> would (s)he not look though the list of the available DTS files as
> the first step in this search?

How is that relevant? The fact that X and Y are starting on that
particular corner of the screen really reflects on the quality of the
support in Linux?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150910/b90cbd56/attachment.sig>

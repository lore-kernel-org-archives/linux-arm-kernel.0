From: balbi@ti.com (Felipe Balbi)
Date: Mon, 16 Jun 2014 09:36:44 -0500
Subject: [RESEND PATCH 1/2] ARM: AM43xx: hwmod: add DSS hwmod data
In-Reply-To: <alpine.DEB.2.02.1406150257380.659@utopia.booyaka.com>
References: <1402676147-3711-1-git-send-email-balbi@ti.com>
 <1402676147-3711-2-git-send-email-balbi@ti.com>
 <20140613162323.GH8319@saruman.home>
 <alpine.DEB.2.02.1406131910060.340@utopia.booyaka.com>
 <20140613231019.GA24121@saruman.home>
 <alpine.DEB.2.02.1406140127020.20370@utopia.booyaka.com>
 <20140614045603.GA28775@saruman.home>
 <alpine.DEB.2.02.1406150257380.659@utopia.booyaka.com>
Message-ID: <20140616143644.GA16850@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jun 15, 2014 at 03:29:40AM +0000, Paul Walmsley wrote:
> Hi,
> 
> On Fri, 13 Jun 2014, Felipe Balbi wrote:
> 
> > On Sat, Jun 14, 2014 at 02:57:32AM +0000, Paul Walmsley wrote:
> > > > > > > From: Sathya Prakash M R <sathyap@ti.com>
> > > > > > > 
> > > > > > > Add DSS hwmod data for AM43xx.
> > > > > > > 
> > > > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > > > Acked-by: Rajendra Nayak <rnayak@ti.com>
> > > > > > > Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> > > > > > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > > > > ---
> > > > > > > 
> > > > > > > Note that this patch was originally send on May 9th [1], changes were requested
> > > > > > > and a new version was sent on May 19th [2], then on May 27th [3] Tomi pinged
> > > > > > > maintainer again and go no response.
> > > > > > > 
> > > > > > > Without this patch, we cannot get display working on any AM437x devices.
> > > > > > > 
> > > > > > > [1] http://marc.info/?l=linux-arm-kernel&m=139963677925227&w=2
> > > > > > > [2] http://marc.info/?l=linux-arm-kernel&m=140049799425512&w=2
> > > > > > > [3] http://marc.info/?l=linux-arm-kernel&m=140117232826754&w=2
> > > > > > > 
> > > > > > >  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 98 ++++++++++++++++++++++++++++++
> > > > > > >  arch/arm/mach-omap2/prcm43xx.h             |  1 +
> > > > > > >  2 files changed, 99 insertions(+)
> > > > > 
> > > > > Sorry for the delay on this.  Have been corresponding with TI management 
> > > > > to figure out what to do about patches for AM43xx.  I don't have boards or 
> > > > > public documentation for these devices, so it's impossible for me to 
> > > > > meaningfully review the patches.  Looks like boards and/or public docs 
> > > > > won't be coming any time soon.
> > > > > 
> > > > > So for my part, here's what I'll need to merge any hwmod or PRCM patches 
> > > > > that involve AM437x:
> > > > > 
> > > > > 1. A Reviewed-by: from one of the following folks (which should come from
> > > > > a different person than who is submitting the patches):
> > > > > 
> > > > > Roger Quadros
> > > > > Nishanth Menon
> > > > > Rajendra Nayak
> > > > > Kevin Hilman
> > > > > Tony Lindgren
> > > > > 
> > > > > 2. A Tested-by: from one of the following folks (who can be the same as 
> > > > > the person who is the same as the person who is submitting the patches):
> > > > > 
> > > > > Nishanth Menon
> > > > > Rajendra Nayak
> > > > > Kevin Hilman 
> > > > > Tony Lindgren
> > > > 
> > > > What you're saying here is that it's pointless for anybody else in TI to
> > > > review and/or test patches because you will only accept such tags from
> > > > this list of 4 ~ 5 people.
> > > 
> > > That might be how you interpreted the E-mail.  But that's not what was 
> > > written.
> > 
> > of course it was. Read what you wrote:
> > 
> > "here's what I'll need to *merge* any hwmod or PRCM patches that involve
> > AM437x".
> > 
> > That basically puts down the requirements to getting any patches
> > accepted and those requirements are the blessings of a handful.
> > 
> > > For the record, I'm pleased to accept Reviewed-by:s and Tested-by:s from 
> > > anyone.  But, like most maintainers, there are some folks who I think do a 
> > > better job of reviewing and testing hwmod and PRCM patches than others.
> > > 
> > > The people listed above are a first cut at that list.  I'm certainly
> > > happy to consider adding others, but the reviewers need:
> > > 
> > > 1. to have experience with those parts of the kernel;
> > > 
> > > 2. to have access to the canonical documentation for AM43xx to review
> > > against; and
> > 
> > anybody in ti.com have access to those.
> > 
> > > 3. to have some kind of track record doing in-depth reviews of patches
> > > for that subsystem, or writing clean code for that subsystem.
> > > 
> > > 
> > > Similarly, for testers, the folks listed above are people who:
> > > 
> > > 1. could actually have AM43xx boards; and
> > 
> > well, quite a few have rather easy access to multiple (3, to be exact)
> > different am437x platforms.
> > 
> > > 2. who have a history of testing patches against mainline kernels in 
> > > public forums, rather than testing against vendor kernels; and
> > 
> > $subject and patch two have both been tested on top of linux next from
> > june 10th. Is that bleeding edge enough for you ? Moreover, *only* these
> > two patches were applied on top of Stephen's linux-next.
> > 
> > > 3. who I think would be mortally embarrassed if a patch was broken 
> > > that they had a Tested-by: for.
> > 
> > right, and when those guys try to get bugs fixed, we spend half a year
> > discussing pointless might-happen-when-the-sun-dies problems with other
> > drivers even when... aaaah what the heck, you'll just say I'm mixing
> > threads again...
> > 
> > The point is that it has been this back and forth for quite a while now,
> > in countless occasions we have missed merge windows because this or that
> > maintainer just stops responding and *nobody* else has balls to pick the
> > patch up.
> > 
> > Weeks later social network posts start to arise blaming TI for not
> > sending patches upstream.
> > 
> > > (N.B. In the case of anything involving DSS, such as this patch, I'd be 
> > > happy to accept Tested-by:s from Archit or Tomi.)
> > > 
> > > If you have other people that you think I'm missing from the above two 
> > > lists, who meet those requirements, please suggest some names!
> > 
> > the point is about not having a list. Sure, you need to know some folks
> > who you can trust, but sometimes, when it's clear that the patch doesn't
> > break anything, follows standard code practices, have passed through
> > more than one hand and soaked in the mailing list for months, it's time
> > to give up and just let the patch sit in linux-next for a while. You can
> > always revert if someone else starts to scream.
> > 
> > I'm *not* saying that you should blindly accept anything, but not
> > accepting patches without a reason isn't fair.
> > 
> > > > Quite frankly, it's very upsetting to see an affirmation that all the
> > > > work that I (personally) and many others do is seen as "pointless" from
> > > > your side *unless* it gets the blessing from the few folks listed above.
> > > 
> > > I'd be curious to know how many of the people listed in the Signed-off-by: 
> > > for these patches have double-checked the data against the TRM (or 
> > 
> > I know I've done it. Have latest am437x Datasheed, TRM and board
> > schematics open for quite a while now as I've been hacking this am437x
> > StarterKit.
> > 
> > Also, the thing is functional. Xorg + i3 runs just fine without any
> > glitches or bogus colors, or any sort of warnings, errors, anything at
> > all.
> > 
> > > whatever documentation is canonical for this chip).  And have thought 
> > > through whether the data actually makes sense with regards to the SoC 
> > > integration.  I consider those to be the prerequisites for reviewing hwmod 
> > 
> > how else would we get the freaking thing to enable clocks ? Or are you
> > forgetting that long ago the entire OMAP architecture was made tightly
> > coupled with runtime PM and HWMOD; and are you also forgetting that no
> > driver is now allowed to call clk_get() directly without hurting
> > somebody's feelings ?
> > 
> > With these details in mind, there's no SoC who depends on mach-omap2
> > that can have any chance of *working* without hwmod data.
> > 
> > > device data patches.  That's what I generally do myself, and that's what I 
> > > expect from trusted reviewers.
> > 
> > alright, so do you see any problems with the patch ? Do you think the
> > data isn't necessary ? Instead of just being silent for months, why
> > don't you just drop a line ? Reply to the f-ing thread ? How can we make
> > any progress if you don't ? Is this what we have to go now ? Send a
> > patch and hopefully, some day, it will make its way to mainline ?
> > 
> > > > This just makes it ever more difficult for anything, which is clearly
> > > > *BROKEN* to be fixed upstream and will just contribute to people
> > > > vanishing from mainline development.
> > > 
> > > Sounds like you might be mixing mailing list threads.  
> > > 
> > > The description for these patches states:
> > > 
> > > "Add DSS hwmod data for AM43xx"
> > > 
> > > Unless I'm missing something, these patches add a feature.  They are not 
> > > fixing something that is broken.
> > 
> > without DSS hwmod data, how can display work ? So it _is_ broken indeed.
> > The same DSS code is functional in many other SoCs, but it's *broken* in
> > am437x because $subject has been pending without *any* reply since
> > May 19th.
> > 
> > > > The very fact that you will only accept patches blessed by the gang-of-4
> > > > goes against the very foundations of open source development. Just
> > > > because you don't have access to documentation - and granted, that
> > > > _does_ make things a lot more difficult - does not mean you have to
> > > > consider an entire company as a non-trust worthy organization. Specially
> > > > when there are so many here who have been doing mainline development for
> > > > quite some time.
> > > 
> > > As stated, I'm happy to consider adding more folks to the list, but they 
> > > need to have a track record of doing good work in that area, or doing 
> > > in-depth reviews.  If they don't have one yet, well, there's no better 
> > > time to start than the present.
> > > 
> > > I'm also happy to do the reviews and a basic test myself, if I have 
> > > documentation and a board.
> > > 
> > > > It doesn't take a brain surgeon to note how this won't scale and, if you 
> > > > continue to ignore patches during the entire development cycle and only 
> > > > reply after it's too late for $this merge window, it won't help much.
> > > 
> > > ...
> > > 
> > > > Anyway, whatever... I just hope that if we go through *another* merge
> > > > window without $subject being merged
> > > 
> > > What is this business about "*another* merge window" and "continue to 
> > > ignore"?  Using the dates from your own E-mail message above, the original 
> > > patches were sent May 9th.  This was the same day that v3.15-rc5 was 
> > > released. According to your message, the revised patches were sent May 
> > > 19th - three days before v3.15-rc6.
> > 
> > right, right.. I'm talking in general. This *could* have made it into
> > v3.16. There are also other patches which were missed. One of them since
> > january.
> > 
> > > So by the time these patches were ready to go, we'd already reached the 
> > > cutoff point for getting anything merged into v3.16.
> > 
> > not really. We had 3 more tags (3 more weeks) until v3.15 final was
> > tagged. Add to that the fact that the merge window is 2 weeks long, 4
> > weeks (leaving the last week as padding) seems like enough time.
> > 
> > > I was rather hoping that I'd be able to review it against the AM43xx 
> > > documentation in time, but that turned out not to be available.
> > > 
> > > If all this has nothing to do with the $SUBJECT patches, and is about the 
> > > DSS clocking issue, and not these patches, that's fine; but please direct 
> > > your flames to that thread instead.
> > > 
> > > > ps: $subject in particular, has been tested by 3 different people.
> > > > Actually 4, if you consider Darren Etheridge who used $subject to help
> > > > me get display working on AM437x SK.
> > > 
> > > There are no Tested-by:s on this patch.  It seems likely to me that Tomi 
> > > has tested it against something close to mainline, just based on general 
> > > experience with his level of patch quality in the past, but in general, I 
> > > have no way of knowing this.
> > 
> > SoB usually means the patch was tested by that person. Or are you
> > implying that neither me nor Sathya (patch author!!) ever tested the
> > patch ? I can post a video on youtube if that makes you happy, but boy
> > do I want to avoid doing that...
> > 
> > > So if folks actually tested it against mainline, please do send 
> > > Tested-by:s, and note the mainline commit that it was tested on, along 
> > > with other patches were needed for this patch to apply and/or work.  It's 
> > > also helpful to include a serial console boot log to a Tested-by: message.  
> > > That adds confidence that the patches don't add extra warnings and that 
> > > the commit ID is what's expected.
> > 
> > sure thing, but don't expect everybody to just figure out what's going
> > on inside your head. Silent gets us nowhere.
> > 
> > > For the specific case of this patch, since it's already been reviewed by 
> > > Rajendra, once there are good Tested-by:s sent to the list, I'd say it's 
> > > ready to merge.
> > 
> > good Tested-by:s ?
> > 
> > nice
> 
> Felipe, here's what I need:
> 
> For boards that I don't have access to, that I don't have 
> documentation for, such as the AM43xx and DRA7xx), for me to merge or ack 
> SoC infrastructure or PM-related patches, I want to have:
> 
> 1. a Reviewed-by: from people who:
> 
> a. I think know something about SoC integration or PM in general, and 
> about OMAP-style integration specifically; and
> 
> b. who have a track record of doing strong and detailed reviews of that 
> code, or who have contributed significantly to that code in the past.
> 
> My initial list of those reviewers is listed above, and I am happy to 
> consider extending it or modifying that list.
> 
> 
> 2. confidence that the patch or series has been tested against a mainline 
> commit and isn't obviously breaking other things, like PM, and confidence 
> that it's not adding new runtime warnings.
> 
> I've listed an initial set of people above who I feel have proven track 
> records in testing who I'm happy to accept Tested-by:s without further 
> explanation.  I'm sure I've missed some folks and if anyone who should be 
> on that list is offended that I didn't mention them, please accept my 
> apologies.  For other folks, like yourself, who aren't on that list (yet), 
> please just specifically state:
> 
> a. what mainline commit they've tested the patch against,

As I said, linux-next from June 10th.

commit 27a4e439fe5cd92b70137ae237c7aa6888c07b5a
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Jun 10 16:37:52 2014 +1000

    Add linux-next specific files for 20140610
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

> b. what other prerequisite patches were needed for the patch to apply,

only these two patches I sent here.

> c. and a cut-and-paste of the serial console boot log from the boot 
> portion of the test.

attached minicom.cap. The "dirty" part is just another set of minor
changes (see below) I'm testing to, hopefully, include in the final DTS
too; and the WARNING you see, was caused by RMK's L2 rework but IIRC
Sekhar already had a fix for it, not sure if it has already reached
next.

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 49fa596..e3830d4 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -270,7 +270,7 @@
 			ti,hwmods = "counter_32k";
 		};
 
-		rtc at 44e3e000 {
+		rtc: rtc at 44e3e000 {
 			compatible = "ti,am4372-rtc","ti,da830-rtc";
 			reg = <0x44e3e000 0x1000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
@@ -279,7 +279,7 @@
 			status = "disabled";
 		};
 
-		wdt at 44e35000 {
+		wdt: wdt@44e35000 {
 			compatible = "ti,am4372-wdt","ti,omap3-wdt";
 			reg = <0x44e35000 0x1000>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 51ffab1..59b620b 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -374,6 +374,16 @@
 		DRVDD-supply = <&v33_fixed>;
 		DVDD-supply = <&v18_fixed>;
 	};
+
+	lis331dlh at 18 {
+		compatible = "st,lis331dlh";
+		reg = <0x18>;
+		status = "okay";
+
+		Vdd-supply = <&v33_fixed>;
+		Vdd_IO-supply = <&v33_fixed>;
+		interrupts-extended = <&gpio1 6 0>, <&gpio2 1 0>;
+	};
 };
 
 &epwmss0 {
@@ -537,3 +547,23 @@
 		};
 	};
 };
+
+&sham {
+	status = "okay";
+};
+
+&aes {
+	status = "okay";
+};
+
+&des {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: minicom.cap
Type: application/vnd.tcpdump.pcap
Size: 32347 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140616/7a32c053/attachment-0001.cap>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140616/7a32c053/attachment-0001.sig>

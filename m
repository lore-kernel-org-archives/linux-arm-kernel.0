From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 9 Jun 2017 16:38:22 +0200
Subject: [PATCH 2/4] drm/bridge: dw-hdmi: add cec notifier support
In-Reply-To: <20170609141056.GS4902@n2100.armlinux.org.uk>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3E-0004lh-Pu@rmk-PC.armlinux.org.uk>
 <0c2c4988-37bb-fd01-efee-c6878cc53923@baylibre.com>
 <20170609133822.GR4902@n2100.armlinux.org.uk>
 <5b2fdadd-f1fa-c454-b3fe-facf221beb78@baylibre.com>
 <20170609141056.GS4902@n2100.armlinux.org.uk>
Message-ID: <9f877352-4122-14d9-4517-af01989161ba@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/17 16:10, Russell King - ARM Linux wrote:
> On Fri, Jun 09, 2017 at 03:56:39PM +0200, Neil Armstrong wrote:
>> Yes, but on the Amlogic Meson plarform, the DW-HDMI CEC controller is
>> not used, but a custom one, so this notifier is actually useful for
>> this platform and maybe others.
> 
> Is the CEC controller configured into dw-hdmi (is the config bit set?)
> I'm just wondering if we're going to end up with two CEC drivers trying
> to bind to the same notifier.
> 
>> Should we really wait until I push the Amlogic AO CEC driver ? Having a
>> notifier in the DW-HDMI driver won't harm anybody since it *will be used*.
> 
> It sounds like this adds additional information that has been missing
> from the review of my patches - and I suspect changes Hans' comments.
> So, I'll wait, it seems pointless to try and update the patches when
> it's not clear how to proceed due to other dependencies, especially
> when it means that their existing state is what's required (I'm pleased
> that I've held off modifying the patches so far.)
> 
> If that means having to wait another kernel revision, then I guess that's
> what will have to happen.
> 

I've Acked patches 1-3. Patch 4 can be rebased on top of the latest mainline
and just ignore any notifier-related comments I made in my review of this
patch.

I have no problem with patches 1-3 being merged now.

Regards,

	Hans

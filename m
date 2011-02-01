From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 1 Feb 2011 10:41:59 +0200
Subject: FW: [linux-cirrus] Fwd: Re: More about SD-Card problems
In-Reply-To: <4D471F71.4010806@bluewatersys.com>
References: <0D753D10438DA54287A00B027084269764CEE3A4FE@AUSP01VMBX24.collaborationhost.net>
	<4D471F71.4010806@bluewatersys.com>
Message-ID: <20110201084158.GA2463@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 09:45:37AM +1300, Ryan Mallon wrote:
> On 02/01/2011 05:45 AM, H Hartley Sweeten wrote:
> > *From:* linux-cirrus-bounce at freelists.org
> > [mailto:linux-cirrus-bounce at freelists.org] *On Behalf Of *Martin Guy
> > *Sent:* Sunday, January 30, 2011 5:40 PM
> > *To:* sim1 at googlegroups.com; linux-cirrus at freelists.org
> > *Subject:* [linux-cirrus] Fwd: Re: More about SD-Card problems
> 
> The Cirrus mailing lists are effectively dead now. Can we please keep
> EP93xx related discussions on the Linux ARM kernel list (Cc'ed).

I'm confused - how did a private email to Martin end up in some Cirrus related
mailing list?

> > Da: "Mika Westerberg" <mika.westerberg@iki.fi
[...]
> > 
> > The M2M DMA patches are attached. Note that it is still in "hack" phase so
> > error handling etc. are not finalized at all. M2M DMA currently only
> > supports
> > SPI but I'm going to add that memory-to-memory support and possibly IDE,
> > let's
> > see. It currently doesn't use double buffering but that is going to be
> > added at
> > some point.
> > 
> > I've been developing on .38-rc2 kernel but since these patches touch
> > only ep93xx
> > stuff I believe that they should apply pretty easily to .36.
> 
> It would be good to get these patches applied to mainline. Some comments
> below. I also think we should look at integrating the EP93xx DMA into
> the existing dmaengine framework if applicable. If not, is it at least
> possible to reuse/combine some parts of the existing EP93xx M2P DMA code?

Well this patch set wasn't meant for public review. It's just a hack I'm working
on which was going to evolve into something which could be considered into
mainline.

I totally agree with you that we should try to use an existing framework. These
are now in a separate source files and have different API but I had a plan to
merge them later if they are similar enough. The patches which are attached are
not there yet (not even close).

It is certainly possible to reuse the existing EP93XX M2P DMA code. Current set
just implements everything on it's own because it was easier to me to get the
thing working with the SPI driver.

Anyway thanks for the review, I'll make sure that the version I'm going to send
to upstream incorporates your suggestions. And I'm hoping to either merge M2M
code into M2P code or look how it could be implemented with dmaengine.

Sorry for the noise.

Regards,
MW

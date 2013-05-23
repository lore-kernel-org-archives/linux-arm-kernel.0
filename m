From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 May 2013 17:27:32 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <519E3031.8080604@schinagl.nl>
References: <1368797744-13737-1-git-send-email-oliver+list@schinagl.nl>
 <1368797744-13737-2-git-send-email-oliver+list@schinagl.nl>
 <CACRpkdaWADjy1YZXTcRaXU+ZsS6_pG0hojQdnz=qeTgyVY7_Ww@mail.gmail.com>
 <519DCEE9.6070208@schinagl.nl> <20130523145835.GI8595@lukather>
 <519E3031.8080604@schinagl.nl>
Message-ID: <20130523152732.GL8595@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 05:05:21PM +0200, Oliver Schinagl wrote:
> On 05/23/13 16:58, Maxime Ripard wrote:
> >On Thu, May 23, 2013 at 10:10:17AM +0200, Oliver Schinagl wrote:
> >>Then, i'm not sure if the driver is the best for this to be loaded?
> >>Maxime, what do you think? Personally I would feel more in having
> >>this in the mach-sunxi/core.c bit, but then again, this is currently
> >>a module and wouldn't be useful to have there. Maxime is far more
> >>knowledgeable to answer that.
> >
> >Hmmm, I don't understand what you mean here. Could you explain what you
> >have in mind?
> I've thought about it a little, and don't think core.c is a good
> spot, since the module will have to be loaded, or available there.
> And that's really early.
> 
> So I guess, during probe, controlled by a parameter perhaps, load
> all 16 bytes into the random pool as Linus suggested?

Yeah, though I don't really know what the parameter would be useful for,
but yes, do it in the driver's probe.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

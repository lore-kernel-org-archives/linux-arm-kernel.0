From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Oct 2016 15:54:51 -0500
Subject: Add Allwinner Q8 tablets hardware manager
In-Reply-To: <20161024173900.GP15620@leverpostej>
References: <20161014075337.10452-1-hdegoede@redhat.com>
 <20161024173900.GP15620@leverpostej>
Message-ID: <20161026205451.cgk5xam334ncg6op@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 06:39:01PM +0100, Mark Rutland wrote:
> On Fri, Oct 14, 2016 at 09:53:31AM +0200, Hans de Goede wrote:
> > Hi Rob, Mark, et al.,
> 
> Hi Hans,
> 
> Apologies for the delay in replying to this.
> 
> I'd like to be clear that I do understand that there is a problem that
> needs to be addressed here. However, I do not believe that the *current*
> in-kernel approach is correct. More on that below.
> 
> > Mark, I know that we discussed this at ELCE and you clearly indicated
> > that according to you this does not belong in the kernel. I was a bit
> > surprised by this part of the discussion.
> > 
> > I had posted a RFC earlier and Rob had indicated that given that the q8
> > tablets are a special case, as my code uses actual probing rather then some
> > pre-arranged id mechanism with say an eeprom, that doing this in a
> > non-generic manner would be ok for my special case.
> 
> To some extent, Rob and I may have differing views here; I'm not
> entirely sure what Rob's view is, and I cannot talk on his behalf. I
> certainly must apologise for having not commented on said RFC, however.

I've focused mainly on the bindings which I certainly had issues with 
how the RFC was done. As to where this should be done, keeping all the 
dirty bits in firmware/bootloader is certainly appealing. However, there 
are cases where data alone can't abstract out board differences and we 
need board code. Whether this is one of them, well, that is Hans' job to 
convince Mark.

Rob

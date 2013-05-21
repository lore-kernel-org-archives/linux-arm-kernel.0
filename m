From: w@1wt.eu (Willy Tarreau)
Date: Tue, 21 May 2013 22:26:01 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130521221235.61491ecb@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130521193803.GA20882@1wt.eu> <20130521221235.61491ecb@skate>
Message-ID: <20130521202601.GB20882@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 10:12:35PM +0200, Thomas Petazzoni wrote:
> Dear Willy Tarreau,
> 
> On Tue, 21 May 2013 21:38:03 +0200, Willy Tarreau wrote:
> 
> > Just out of curiosity, what happens if you touch the register at the
> > wrong address ?
> 
> On Armada 370/XP, it hangs the CPU.
> 
> > I mean, if you blindly write to the 0xD0xxxxxx address
> > that you want the registers to be mapped at 0xF1xxxxxx. Will the chip
> > hang, will it silently ignore the sequence ?
> 
> Answered above: it hangs.
> 
> > Because maybe you don't need to detect using CP15 whether the remapping was done,
> > you could simply perform it unconditionally. Another point would be that if the
> > boot loader is the only one to know whether the registeres were remapped,
> > then maybe it could put something into the atags or DT about this. And
> > maybe we'll simply find that DT-enabled boot loaders are remapped and
> > that non-DT ones are not.
> > 
> > Just a few ideas since you feel a bit worried about the fragility of
> > the CP15 bit :-)
> 
> No, as explained above, we have considered a way of "detecting" whether
> the remapping occurred, or to unconditionally do the remapping. But
> none of those solutions work: we need to know, through some external
> mechanism, whether the remapping has already taken place or not.

OK, thank you for these precisions.

Best regards,
Willy

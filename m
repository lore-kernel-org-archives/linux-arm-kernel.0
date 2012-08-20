From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 20 Aug 2012 14:45:20 -0400 (EDT)
Subject: [PATCH] ARM: io: avoid writeback addressing modes for __raw_
 accessors
In-Reply-To: <20120820181007.GX25864@mudshark.cambridge.arm.com>
References: <1344956366-32574-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1208161906390.1541@xanadu.home>
 <20120820124109.GK25864@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208200902120.1754@xanadu.home>
 <20120820144927.GP25864@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208201150010.1754@xanadu.home>
 <20120820165405.GU25864@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1208201356130.1754@xanadu.home>
 <20120820181007.GX25864@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1208201443070.1754@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Aug 2012, Will Deacon wrote:

> On Mon, Aug 20, 2012 at 07:04:01PM +0100, Nicolas Pitre wrote:
> > On Mon, 20 Aug 2012, Will Deacon wrote:
> > > 
> > > Hmm, ok. I too would hope that the volatile keyword would sort that out but,
> > > since the '+' doesn't seem to change the generated code, I can add that. It
> > > does, however, mean we have to cast away the `const' in the read accessors
> > > which makes the code even uglier.
> > 
> > Nah... the const is wrong.  The way you wrote it means that addr may 
> > change but the pointed data is constant.  This is obviously wrong since 
> > we expect the pointed location to change even from a read.
> 
> That's the prototype for the read accessors though -- a bunch of other
> architectures define them that way (including asm-generic), so I wonder what
> the reasoning behind that was?

I'm still asserting that they're wrong.


Nicolas

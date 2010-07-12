From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Jul 2010 09:11:06 -0400 (EDT)
Subject: [RFC,PATCH 0/2] Allow late mdesc detection
In-Reply-To: <1278921935.9235.90.camel@pororo.lan>
References: <1278903792.387175.713057245098.0.gpush@pororo>
	<alpine.LFD.2.00.1007112334390.10598@xanadu.home>
	<1278921935.9235.90.camel@pororo.lan>
Message-ID: <alpine.LFD.2.00.1007120904240.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jul 2010, Jeremy Kerr wrote:

> Hi Nicolas,
> 
> > The fundamental problem with those patches is that we actually want to 
> > move in the opposite direction for the eventual support of multiple SOCs 
> > in the same kernel, i.e. rely on the machine ID -> mdesc to determine 
> > the right debug addresses at run time and eventually make the addruart 
> > into something that is not hardcoded at compile time.
> 
> Sure, I think that's where we're going in general, but I think the debug
> stuff is an exception - we want that up as early as possible, and with
> as few dependencies on other bits of code as possible.
[...]
> I also think it's good to only specify the debug parameters in one place
> (addruart), rather than have to provide them in adduart *and* the mdesc.

OK I'm convinced.

I'll comment on the actual implementation separately.

PS: I still believe in a per SOC machine ID for DT despite of this, at 
    least for now.  If we end up not needing it eventually then it could 
    be ignored which is a far easier thing to do (start to ignore stuff) 
    than bite our fingers because we prematurely ditched it.


Nicolas

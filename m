From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 11 Jul 2010 23:39:07 -0400 (EDT)
Subject: [RFC,PATCH 0/2] Allow late mdesc detection
In-Reply-To: <1278903792.387175.713057245098.0.gpush@pororo>
References: <1278903792.387175.713057245098.0.gpush@pororo>
Message-ID: <alpine.LFD.2.00.1007112334390.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jul 2010, Jeremy Kerr wrote:

> Hi all,
> 
> Currently, we probe for a mdesc early in boot. At this early stage, the
> only thing we use the mdesc for is to determine the debug page mapping.
> 
> However, the debug addresses (phys and virt) need to be coded into the
> addruart macro anyway; the dynamic probing is only going to tell us what
> we already know.

The fundamental problem with those patches is that we actually want to 
move in the opposite direction for the eventual support of multiple SOCs 
in the same kernel, i.e. rely on the machine ID -> mdesc to determine 
the right debug addresses at run time and eventually make the addruart 
into something that is not hardcoded at compile time.


Nicolas

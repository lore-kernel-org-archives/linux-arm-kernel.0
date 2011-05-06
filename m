From: phil@nwl.cc (Phil Sutter)
Date: Fri, 6 May 2011 18:17:53 +0200
Subject: ARM, AF_PACKET: caching problems on Marvell Kirkwood
In-Reply-To: <20110505194601.GA10565@lunn.ch>
References: <20110408130643.GA8730@orbit.nwl.cc>
	<20110505141107.GC30443@orbit.nwl.cc>
	<20110505194601.GA10565@lunn.ch>
Message-ID: <20110506161753.GC20777@orbit.nwl.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 05, 2011 at 09:46:01PM +0200, Andrew Lunn wrote:
> I can reproduce it on a Kirkwood:
> 
> [    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977

Thanks for the information. Seems like we have the same CPU:

| [    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053177
| [    0.000000] CPU: VIVT data cache, VIVT instruction cache

and it's actually VIVT, not VIPT as I wrote in an earlier mail.

Greetings, Phil

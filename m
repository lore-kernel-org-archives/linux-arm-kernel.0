From: gmbnomis@gmail.com (Simon Baatz)
Date: Thu, 31 Jan 2013 23:44:57 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130130230100.GV7717@titan.lakedaemon.net>
References: <20130127152431.GX1758@titan.lakedaemon.net>
 <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130130000341.GA10600@schnuecks.de> <51086E86.8040705@gmail.com>
 <20130130083044.GA25688@schnuecks.de> <5108F300.7000705@gmail.com>
 <20130130230100.GV7717@titan.lakedaemon.net>
Message-ID: <20130131224457.GB17976@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason, Sebastian,

On Wed, Jan 30, 2013 at 06:01:00PM -0500, Jason Cooper wrote:
> 
> wrt to runit gating, the only case we are not covering is if of_serial
> is a module (and so is everything else using the runit clk).  That's
> *really* rare.  If someone embarks down that path, they get the
> responsibility of not writing to all the deactivated registers. ;-)

With the serial driver now enabling runit it is really rare, but
where is your enthusiasm to get to the bottom of it?  At least we
have indications that there really is something in "..." (my box
stops somewhere when no driver enables runit)

Sebastian, are you still interested in the .flags stuff from the
runit patch or do you see no need now since "ddr" is the only
exception anyway?


- Simon

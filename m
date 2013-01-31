From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 30 Jan 2013 19:32:22 -0500
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <5109AB30.5020202@gmail.com>
References: <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130130000341.GA10600@schnuecks.de> <51086E86.8040705@gmail.com>
 <20130130083044.GA25688@schnuecks.de> <5108F300.7000705@gmail.com>
 <20130130230100.GV7717@titan.lakedaemon.net>
 <5109AB30.5020202@gmail.com>
Message-ID: <20130131003222.GX7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:22:24AM +0100, Sebastian Hesselbarth wrote:
> On 01/31/2013 12:01 AM, Jason Cooper wrote:
> >As it stands, there are three patches to fix this issue:
> >
> >ARM: kirkwood: of_serial: fix clock gating by removing clock-frequency
> >ARM: kirkwood: provide ge clock aliases for shared smi
> >ARM: kirkwood: fix to retain gbe MAC addresses for DT kernels
> 
> Actually, for the second patch I got distracted by the smi split patch
> set floating around. But that is not in current kernel and smi will not
> request any clock at all.
> 
> If Simon can hit another round of testing without second patch included
> and agrees, I suggest to keep it for next release.

Ok, I'll wait for Simon on this.  fixes can go anytime, so no rush.
Better to get it right the first (second?) time out.

> >wrt to ge losing mac addresses, both DT and non-DT booting are covered by
> >Sebastian's patches, for non-DT aware mv643xx_eth.
> 
> non-DT already ungates ge0/1 clocks on registration and cannot loose its
> mac address, not my fix.

Yes, bad wording on my part.  I meant that everything was magically
fixed by Sebastian and that his thesis should be approved without
challenge.  ;-)

thx,

Jason.

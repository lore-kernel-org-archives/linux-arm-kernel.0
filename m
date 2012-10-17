From: zonque@gmail.com (Daniel Mack)
Date: Wed, 17 Oct 2012 17:13:53 +0200
Subject: [PATCH 0/4] OMAP-GPMC generic timing migration
In-Reply-To: <507E455F.7060703@ti.com>
References: <cover.1349450723.git.afzal@ti.com> <5076B166.2020006@gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FBC41@DBDE01.ent.ti.com>
 <20121011144756.GB12552@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FCEC9@DBDE01.ent.ti.com>
 <20121015160154.GB15569@atomide.com> <507D050D.2090402@ti.com>
 <507E455F.7060703@ti.com>
Message-ID: <507ECB31.8030006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Afzal,

On 17.10.2012 07:42, Afzal Mohammed wrote:
> On Tuesday 16 October 2012 12:26 PM, Afzal Mohammed wrote:
>> I certainly don't think it is easier, rather tougher, cleaner
>> as well. One thing that worried me was, if we pursue the
>> auxdata path (a last resort option) and later if it is
>> objected, we would be back to square one.
> 
> I commented on auxdata usage without visualising in more
> detail how it can be implemented, it was bad of me.
> 
> I doubt whether auxdata would help here, it seems using
> compatible field alone would help in deciding relevant
> custom timing routine. Whether we want this kind of
> peripheral knowledge in gpmc driver instead of using
> generic timing routine has to be decided though.

Maybe slightly off-topic, but still:

When GPMC is used for driving NAND chips that comply to CFI, the timings
could actually be derived from the connected peripheral as well. I
believe a slowest-possible-mode will have to be selected first for the
identication phase.

Another thing that might be worth thinking about is that apart from the
GPMC host controller and the peripherals, there could be other
components like level shifters or series resistors on the board that
limit the maximum speed of transactions. So in fact we might be better
off storing all that timing details in the DT, as they are in fact
highly application specific.


Daniel

From: eduardo.valentin@ti.com (Valentin, Eduardo)
Date: Tue, 22 May 2012 10:02:55 +0300
Subject: [PATCH V2] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
In-Reply-To: <CAOMWX4cN3kYnpe16_zVDVdA8dtthwAo5RvvSCkVdLvyPpguA2w@mail.gmail.com>
References: <1337365122-702-1-git-send-email-nm@ti.com>
 <20120519095237.GA26761@besouro>
 <CAOMWX4f2N1dS8RcwYAyUpmWVKPkEHGuhMGGZ3__D-DwipsjzFQ@mail.gmail.com>
 <20120521145157.GA7923@besouro>
 <CAOMWX4cN3kYnpe16_zVDVdA8dtthwAo5RvvSCkVdLvyPpguA2w@mail.gmail.com>
Message-ID: <CAGF5oy9STCs8wvQqmWaPjoOLGTo6-e-JieoywPrKd-HCi=mA1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, May 21, 2012 at 6:14 PM, Menon, Nishanth <nm@ti.com> wrote:
> On Mon, May 21, 2012 at 9:51 AM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
>>
>>
>> On Mon, May 21, 2012 at 08:36:35AM -0500, ext Nishanth Menon wrote:
>>> ?Sat, May 19, 2012 at 4:52 AM, Eduardo Valentin <eduardo.valentin@ti.com>
>>> wrote:
>>> >
>>> >
>>> > I guess it is time to properly document this increasing busy loop delay..
>>> > As it is getting closer to ms scale..
>>> Does the following sound good?
>>> /* Maximum time for Voltage Processor to enter or exit idle */
>>
>> Sounds way better :-). If you have an estimation of how long it takes
>> in the average case, it might help. But I am OK already with the above,
>> in case you don't have the estimation.
> /*
> ?* Maximum time for Voltage Processor to enter or exit idle
> ?* worst case is around 100uSec depending on when we intercepted VP
> ?* we use 5 times worst case value to be sure that the system flags
> ?* invalid condition
> ?*/
> better?

Yes! Thanks.

>
> Regards,
> Nishanth Menon



-- 

Eduardo Valentin

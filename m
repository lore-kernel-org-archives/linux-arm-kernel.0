From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Tue, 4 Dec 2012 10:45:01 +0530
Subject: [PATCH 2/2] i2c-s3c2410: Add bus arbitration implementation
In-Reply-To: <CAOesGMgzBGieYJ131sUX7u8EWPEusxareFzC0XPt48+oNuh-xA@mail.gmail.com>
References: <1354165536-18529-1-git-send-email-ch.naveen@samsung.com>
 <1354165536-18529-3-git-send-email-ch.naveen@samsung.com>
 <20121129163448.GA3761@sirena.org.uk>
 <CAPnjgZ0atD3k=gT0vjgkLO_SA8DMak6SiT6nZ_2T6WFqtK0szQ@mail.gmail.com>
 <CAOesGMgE0JEHsdySpua34_kbWi1+z4n4UdW0kumiJEROi7O2pQ@mail.gmail.com>
 <20121201132632.GA17981@opensource.wolfsonmicro.com>
 <CAOesGMgzBGieYJ131sUX7u8EWPEusxareFzC0XPt48+oNuh-xA@mail.gmail.com>
Message-ID: <CAHfPSqBcpAA8fLcLjOAMkSPGmm=b1mHaVgfYfjAbLAtLbrXB+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2012 05:41, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Dec 1, 2012 at 5:26 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Thu, Nov 29, 2012 at 10:14:58PM -0800, Olof Johansson wrote:
>>> On Thu, Nov 29, 2012 at 6:13 PM, Simon Glass <sjg@chromium.org> wrote:
>>
>>> > It was originally done separately but I think it was felt that this
>>> > was overly complex. Olof can you please comment on this?
>>
>>> it is indeed not controller specific per se, but we are unaware of any
>>> other platform/driver using it. So, it seemed reasonable to implement
>>> it in the driver as long as we have only one user; if another one
>>> comes along it's of course better to move it to the common i2c code.
>>
>>> At least that was my opinion at the time. I could be convinced
>>> otherwise if someone else has strong opinions on the matter.
>>
>> This sort of approach is half the reason SPI ended up being so fun...  I
>> suspect if you look hard enough you'll find that this is just the first
>> time someone tried to upstream such a scheme.  This is all especially
>> true for the DT bindings, even if the implementation is driver local for
>> now it'd be better to define generic bindings.
>
> Ok, sounds like we might as well make it generic then. Naveen?
Thanks for the comments.

Sure, Will send an RFC soon.
>
>
> -Olof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Shine bright,
(: Nav :)

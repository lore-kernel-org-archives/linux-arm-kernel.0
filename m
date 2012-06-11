From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 11 Jun 2012 22:15:04 +0200
Subject: [PATCHv2 11/12] ARM: OMAP4: clock data: add clockdomains for
 clocks used as main clocks
In-Reply-To: <alpine.DEB.2.00.1206111050430.5849@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004623.20034.52760.stgit@dusk> <4FD61C94.4030004@ti.com>
 <alpine.DEB.2.00.1206111050430.5849@utopia.booyaka.com>
Message-ID: <4FD651C8.8030108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/11/2012 6:59 PM, Paul Walmsley wrote:
> On Mon, 11 Jun 2012, Cousson, Benoit wrote:
>
>> In fact, neither prm_clkdm not cm_clkdm are valid clock domain on OMAP4
>> :-(.
>>
>> I've just realized that you introduced that for 3.5, but this is wrong.
>> We should not start adding some fake clock domains just because the fmwk
>> is not smart enough to allow a NULL clock domain.
>>
>
> ...
>
>> In a period of data size reduction, adding some fake information does
>> not seems to be the right approach. Don't you think so?
>
> No, I do not.
>
> These clockdomains are clearly documented in both the OMAP4 TRM[1]
> and the NDA OMAP4 PRCM functional specifications.

Sorry for the confusion; I was just referring to the prm_clkdm and cm_clkdm.

> I continue to be baffled as to why you assert that they are fake, given
> how clearly they are documented.

In that case the clock domains are valid, but that does not change the 
fact that they are useless, at least for the moment.
The PRCM is already taking care of managing properly the domains based 
on module activity. Adding that to the clocks nodes is not wrong, but 
does add an information that is a duplication of what the HW is already 
doing.
That's why we should populate that information only if this is needed, 
like it was the case for the DPLL, but it should remain optional.

Regards,
Benoit

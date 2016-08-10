From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Aug 2016 15:01:30 +0530
Subject: [PATCH 3/4] ARM: dts: da850-lcdk: Add NAND to DT
In-Reply-To: <20160810090417.GE16481@gobelin>
References: <20160809171518.22690-1-kbeldan@baylibre.com>
 <20160809171518.22690-4-kbeldan@baylibre.com> <57AAE67D.4000404@ti.com>
 <20160810090417.GE16481@gobelin>
Message-ID: <57AAF472.7000804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 August 2016 02:34 PM, Karl Beldan wrote:
> On Wed, Aug 10, 2016 at 02:01:57PM +0530, Sekhar Nori wrote:
>> On Tuesday 09 August 2016 10:45 PM, Karl Beldan wrote:
>>> This adds DT support for the NAND connected to the SoC AEMIF.
>>> The parameters (timings, ecc) are the same as what the board ships with
>>> (default AEMIF timings, 1bit ECC) and improvements will be handled in
>>> due course.
>>
>> I disagree that we need to be compatible to the software that ships with
>> the board. Thats software was last updated 3 years ago. Instead I would
>> concern with what the hardware supports. So, if the hardware can support
>> 4-bit ECC, I would use that.
>>
> I am not saying we _need_ to be compatible.

Alright then, please drop references to what software the board ships
with in the commit message and in the patch itself.

> 
>> If driver is broken for 4-bit ECC, please fix that up first.
>>
> Since this issue is completely separate from my DT improvements
> I'll stick to resubmitting the series, applying my LCDK changes to the
> EVM too, besides you'll be able to compare the behavior without ECC
> discrepancies.
> I took note that you are likely to not apply without the ECC fix.

Yeah, I would not like to apply with 1-bit ECC now and then change to
4-bit ECC soon after.

Regards,
Sekhar

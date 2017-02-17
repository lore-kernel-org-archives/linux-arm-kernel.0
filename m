From: nandor.han@ge.com (Han, Nandor (GE Healthcare))
Date: Fri, 17 Feb 2017 11:13:43 +0200
Subject: EXT: Re: sDMA on i.mx7d
In-Reply-To: <20170216170828.bcbpvtdobmcxr2lu@piout.net>
References: <20170214222425.hbkfkeq3l6sveo7n@piout.net>
 <e9c36a33f2a49df2a517db5869eaea7f@agner.ch>
 <20170215110736.oumvvv7zordd2jdw@piout.net>
 <3513b2c01d86ad7312522d6be97e766f@agner.ch>
 <20170216104229.axwm3445yj6zrxoz@piout.net>
 <CAOMZO5CeqipfNJxM2Pc1g1606OjbN83ZtbbGRZFmqE3q4fNpRw@mail.gmail.com>
 <20170216164038.zbl2nb76now3glkk@piout.net>
 <1487263639.13536.36.camel@pengutronix.de>
 <20170216170828.bcbpvtdobmcxr2lu@piout.net>
Message-ID: <b60d1bc3-e23f-0ce5-2905-b6c0025bdc84@ge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/02/2017 19:08, Alexandre Belloni wrote:
> On 16/02/2017 at 17:47:19 +0100, Lucas Stach wrote:
>> Am Donnerstag, den 16.02.2017, 17:40 +0100 schrieb Alexandre Belloni:
>>> On 16/02/2017 at 13:36:28 -0200, Fabio Estevam wrote:
>>>> Hi Alexandre,
>>>>
>>>> On Thu, Feb 16, 2017 at 8:42 AM, Alexandre Belloni
>>>> <alexandre.belloni@free-electrons.com> wrote:
>>>>
>>>>> I confirm it is the culprit.
>>>>
>>>> Does this mean that PCM3168s codec works fine on imx7 using SAI on
>>>> 4.9.x plus the revert?
>>
>> And there is already a fix for this in 4.10:
>> 85f57752b33c (dmaengine: imx-sdma - correct the dma transfer residue
>> calculation)
>>
>> This fixes audio output on i.MX6 and should probably be sent to -stable.
>> Can you see if applying this patch gets rid of the issues on i.MX7?
>>
>
> It does too, thanks!
> It is probably worth having it on 4.9.
>

Hi,
   Thanks for mention the problem and confirm that the above patch fixed 
the issue.

I'm a bit surprised about the issue that Stefan mention, which in his 
case was a "noise". In my case was more like a sound interruption (I was 
testing on a iMX6).

But good to hear that works :)

Regards,
    Nandor


-- 
Regards,
     Nandi

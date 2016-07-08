From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Fri, 8 Jul 2016 17:21:21 -0400
Subject: [PATCH v4 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <CAOMZO5C3eu6W2hHF40giuTgRaP8y9KAZOihr+7kPn627vCkVhA@mail.gmail.com>
References: <1456476714-11351-1-git-send-email-p.zabel@pengutronix.de>
 <1456476714-11351-4-git-send-email-p.zabel@pengutronix.de>
 <56D60C90.7080703@timesys.com>
 <CACrMeVAtLMdx6FhhmvxOq=_q=HztU_2nqVwzbL3dYBHd-PWKUg@mail.gmail.com>
 <CAOMZO5DJ=2xo3ciDDoC1KVwHpxagEjNHq5hEkS7StBzaXrk-pQ@mail.gmail.com>
 <56F9855B.9060009@timesys.com>
 <CAOMZO5CsCfprq_br-omNyeE_T7XC7Do+Z0qOT68msZSu9QedqA@mail.gmail.com>
 <1459354720.2505.98.camel@pengutronix.de>
 <CAOMZO5C3eu6W2hHF40giuTgRaP8y9KAZOihr+7kPn627vCkVhA@mail.gmail.com>
Message-ID: <57801951.30305@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/04/2016 08:21 PM, Fabio Estevam wrote:
> Hi Philipp,
>
> On Wed, Mar 30, 2016 at 1:18 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
>>>> 1. NXP 3.10 kernel switches clock source as follows:
>>>> current_parent -> 7 -> 4 -> new_parent
>>>
>>> Yes, we need to follow this requirement.
>>
>> Thanks. Does anybody know why?
>
> The SoC folks say this needs to be done to make sure the glitch is not
> propagated.
>
>> (Does this work for current_parent == 4 and new_parent != 0)?
>
> They say it works for all combinations.
>
>> Is this also true for starting values other than 3?
>
> Yes.
>


Hi Philipp,

NXP has updated the EB821 document and made it public. As per the 
updated document your v4 patch matches the NXP recommendation for the 
clock switch. The only change I see is allowing to switch to any new 
parent (when starting at a value other than 3). Is it possible for you 
to resubmit this useful patch after reviewing the EB821 document?

http://www.nxp.com/files/32bit/doc/eng_bulletin/EB821.pdf?fasp=1&WT_TYPE=Engineering%20Bulletins&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation&fileExt=.pdf

Thanks,
Akshay

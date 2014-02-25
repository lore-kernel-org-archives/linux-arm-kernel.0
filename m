From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 25 Feb 2014 09:10:21 +0100
Subject: [PATCH v2 0/2] ARM: OMAP4: Fix gpmc_fck clock
In-Reply-To: <20140225062615.22529.88499@quantum>
References: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch>
 <5304DA2C.3030605@ti.com> <53050573.8090506@epfl.ch>
 <20140223212309.22529.75068@quantum> <530ADC39.1010300@epfl.ch>
 <20140225062615.22529.88499@quantum>
Message-ID: <530C4FED.80403@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2014 07:26 AM, Mike Turquette wrote:
> Quoting Florian Vaussard (2014-02-23 21:44:25)
>> On 02/23/2014 10:23 PM, Mike Turquette wrote:
>>> Quoting Florian Vaussard (2014-02-19 11:26:43)
>>>>
>>>> On 02/19/2014 05:22 PM, Tero Kristo wrote:
>>>>> On 02/19/2014 11:15 AM, Florian Vaussard wrote:
>>>>>> Hello,
>>>>>>
>>>>>> Trying to get my SMSC9221 working on OMAP4 with DT,
>>>>>> I faced a misconfigured gpmc_fck (dummy clock set to 0)
>>>>>> resulting in serveral division-by-zero, misconfigured
>>>>>> timings and driver lost in the La La Land.
>>>>>>
>>>>>> To solve this, patch 1 removes gpmc_fck from the dummy
>>>>>> clocks, and patch 2 adds the gpmc_fck DT node and
>>>>>> reference it from the gpmc node.
>>>>>>
>>>>>> Tested on DuoVero/Parlor (OMAP4430) with SMSC9221.
>>>>>
>>>>> I can't test GPMC myself, but other than that, this set looks good to go.
>>>>>
>>>>
>>>> Thank you. Would you like more test coverage by other people? I would
>>>> like to see this in -rc if possible, as it is needed to boot my OMAP4
>>>> system.
>>>
>>> What OMAP4 system is this? Is this a regression for board that already
>>> has support merged into mainline?
>>>
>>
>> No, it is not yet merged into mainline. I was planning to post the DTS
>> this week, when most issues are cleared. Looking at the current mainline
>> boards, no one seems to use the GPMC, so I am just the first one to hit
>> this issue.
> 
> OK, well typically the later -rc's are for fixing observed regressions.
> Since your platform is not yet merged in then it's probably fine to push
> this for 3.15.
> 

Fair enough. 3.15 is fine.

> This also gives time to test the fix for other OMAP-ish processors.
> 

I can do the v3, including OMAP5 and DRA7. But for DRA7, I will need
someone with the TRM telling me where is connected gpmc_fclk (Suman?).

BTW, your mail client seems to have corrupted the To: header, double
quotes " are missing between Tero, Beno?t and Tony's addresses, mixing
them as the same person. Maybe an indigestion caused by the UTF8
character of Beno?t?

Regards,
Florian

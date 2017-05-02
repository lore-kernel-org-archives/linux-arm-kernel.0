From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 2 May 2017 13:18:21 +0200
Subject: [PATCH 2/5] mtd: nand: gpmi: add i.MX 7 SoC support
In-Reply-To: <20170502111758.53e9a959@bbrezillon>
References: <20170421010755.18025-1-stefan@agner.ch>
 <20170421010755.18025-3-stefan@agner.ch>
 <af3fe671-c5fb-d3cf-c891-e6b7c973baa1@gmail.com>
 <5cf26d2b020392c875464c7504a9fb5b@agner.ch>
 <8377dadc-043f-5932-cb13-3367db38a6dd@gmail.com>
 <494a7bc044457240a302d92b3a50b8e5@agner.ch>
 <57336d7e-7b48-8855-9e87-3eb370facd05@gmail.com>
 <a9cdc47795433e7b152dcdd123f9bd63@agner.ch>
 <CA+EcR20FCPSec+ihTMA=SGwogd7p5tsnECCp3CR-Nv6fUciK4g@mail.gmail.com>
 <20170502111758.53e9a959@bbrezillon>
Message-ID: <d0162bbe-c2de-73d1-0d37-9bdd68ceb94b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2017 11:17 AM, Boris Brezillon wrote:
> Hi Han,
> 
> On Fri, 21 Apr 2017 13:29:16 -0500
> Han Xu <xhnjupt@gmail.com> wrote:
> 
>>>>  
>>>>>>> But then, adding the type would only require 2-3 lines of change if I
>>>>>>> add it to the GPMI_IS_MX6 macro...  
>>>>>>
>>>>>> Then at least add a comment because using type = IMX6SX right under
>>>>>> gpmi_data_mx7d can trigger some head-scratching. And put my R-B on V2.  
>>>>>
>>>>> FWIW, I mentioned it in the commit message.
>>>>>
>>>>> I think rather then adding a comment it is cleaner to just add IS_IMX7D
>>>>> and add it to the GPMI_IS_MX6 macro. That does not need a comment since
>>>>> it implicitly says we have a i.MX 7 but treat it like i.MX 6 and it is a
>>>>> rather small change. Does that sound acceptable?  
>>>>
>>>> Sure, that's even better, thanks.
>>>>
>>>> btw isn't there some single-core mx7 (mx7s ?) , maybe we should just go
>>>> with mx7 (without the d suffix). I dunno if it has GPMI NAND though, so
>>>> maybe mx7d is the right thing to do here ...
>>>>  
>>>
>>> There is a Solo version yes, and it has GPMI NAND too. However, almost
>>> all i.MX 7 IPs have been named imx7d by NXP for some reason (including
>>> compatible strings, see grep -r -e imx7 Documentation/), so I thought I
>>> stay consistent here...  

I missed the DT bit, sorry. the DT bindings say:
  - compatible : should be "fsl,<chip>-gpmi-nand"
so if FSL invented their own buggy bindings, they need to get them
through Rob :) IMO for MX7, this should be "imx7-gpmi-nand" , unless
there's some incentive to discern the solo/dual chips and/or there
is a future imx7 coming up with different GPMI NAND block version.

>> Hi Guys,
>>
>> Yes, there should be a i.MX7 Solo version with one core fused out. IMO, can
>> we use QUIRK to distinguish them rather than SoC name. I know I also sent
>> some patch set with SoC Name but I prefer to use QUIRK now.
> 
> Not sure what this means. Are you okay with Stefan's v2?

IMO the GPMI controller in solo and dual should be the same, so there's
no need to have quirks for it.

-- 
Best regards,
Marek Vasut

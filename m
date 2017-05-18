From: varada@codeaurora.org (Varadarajan Narayanan)
Date: Thu, 18 May 2017 14:09:26 +0530
Subject: [PATCH v2 1/5] pinctrl: qcom: Add ipq8074 pinctrl driver
In-Reply-To: <20170517193315.GF12920@tuxbook>
References: <1493898841-20583-1-git-send-email-varada@codeaurora.org>
 <1493898841-20583-2-git-send-email-varada@codeaurora.org>
 <20170510224355.GE45273@Bjorns-MacBook-Pro-2.local>
 <1f4c9974-f6a4-bee7-4f37-ad8795e442a3@codeaurora.org>
 <20170514042307.GE69278@Bjorns-MacBook-Pro-2.local>
 <7afc7191-bcb1-a566-eac5-a4fe1293c773@codeaurora.org>
 <20170517193315.GF12920@tuxbook>
Message-ID: <f5a3da8b-c3a4-3cb3-9f5f-0cbdb87688ed@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/18/2017 1:03 AM, Bjorn Andersson wrote:
> On Mon 15 May 02:05 PDT 2017, Varadarajan Narayanan wrote:
> 
>> On 5/14/2017 9:53 AM, Bjorn Andersson wrote:
>>> On Thu 11 May 03:33 PDT 2017, Varadarajan Narayanan wrote:
>>>
>>>> On 5/11/2017 4:13 AM, Bjorn Andersson wrote:
>>>>> On Thu 04 May 04:53 PDT 2017, Varadarajan Narayanan wrote:
> [..]
>>>>>> +	msm_mux_qpic_pad4,
>>>>>
>>>>> What are qpic_pad and qpic_pad0 through qpic_pad8? Different functions,
>>>>> alternative muxings...?
>>>>
>>>> This is for the NAND and LCD display. The pins listed are the 9 data pins.
>>>>
>>>
>>> Then you can describe them all as "qpic_pad" (or simply "qpic"?). (It's
>>> possible to reference a partial group in the DTS, if that's necessary)
>>
>> There are two sets of 9 pins, either of which can go to NAND or LCD.
>> Will rename qpic_pad as qpic_a and qpic_pad[0-8] as qpic_b.
>> Is that ok?
>>
> 
> So you have NAND and LCD hardware muxed to either "a" or "b" and then
> you mux either "a" or "b" out onto actual pins?
> 
> How is this first mux configured?
> 
> I think the a/b scheme sounds reasonable, if above is how it works.

Sorry, I was wrong. I had misread the documentation.

There are 18 pins. 15 pins are common between LCD and NAND. The QPIC 
controller arbitrates between LCD and NAND. Of the remaining 4, 2 are 
for NAND and 2 are for LCD exclusively. We plan to group the qpic pins 
into 3 groups namely, qpic_common, qpic_nand and qpic_lcd. Is that ok?

Thanks
Varada

> 
> Regards,
> Bjorn
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, a Linux Foundation Collaborative Project

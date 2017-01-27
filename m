From: rafalo@cadence.com (Rafal Ozieblo)
Date: Fri, 27 Jan 2017 10:26:14 +0000
Subject: [PATCH net-next v2] macb: Common code to enable ptp support for
 MACB/GEM
In-Reply-To: <CAFcVECLuWM65zXJWtMcwijZ1ZbtH0pvKnTUR=SJagPGHEr9amg@mail.gmail.com>
References: <1484841375-11420-1-git-send-email-andrei.pistirica@microchip.com>
 <BN3PR07MB25160FCBCF19918C495F43B4C9770@BN3PR07MB2516.namprd07.prod.outlook.com>
 <CAFcVECLuWM65zXJWtMcwijZ1ZbtH0pvKnTUR=SJagPGHEr9amg@mail.gmail.com>
Message-ID: <BN3PR07MB25163747E1520E4CE1C6164FC9760@BN3PR07MB2516.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Harini Katakam [mailto:harinikatakamlinux at gmail.com] 
>Sent: 27 stycznia 2017 06:43
>Subject: Re: [PATCH net-next v2] macb: Common code to enable ptp support for MACB/GEM
>
>Hi Rafal,
>
>On Thu, Jan 26, 2017 at 8:45 PM, Rafal Ozieblo <rafalo@cadence.com> wrote:
>>> -----Original Message-----
>>> From: Andrei Pistirica [mailto:andrei.pistirica at microchip.com]
>>> Sent: 19 stycznia 2017 16:56
>>> Subject: [PATCH net-next v2] macb: Common code to enable ptp support for MACB/GEM
>>>
>>>
>>> +static inline bool gem_has_ptp(struct macb *bp)
>>> +{
>>> +     return !!(bp->caps & MACB_CAPS_GEM_HAS_PTP);
>>> +}
>> Why don't you use hardware capabilities here? Would it be better to read it from hardware instead adding it to many configuration?
>
>If you are referring to TSU bit in DCFG5, then we will be relying on
>Cadence IP's information irrespective of the SoC capability
>and whether the PTP support was adequate.
>I think the capability approach gives better control and
>it is not really much to add.
>
>Regards,
>Harini
>
Yes, I'm referring to TSU bit.
What if SoC contains multiple Cadence GEMs, some with PTP support and others without?
Relevant will be checking both, hardware capabilities and SoC capabilities from "caps" field.

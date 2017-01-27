From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 27 Jan 2017 11:12:24 +0100
Subject: [PATCH net-next v2] macb: Common code to enable ptp support for
 MACB/GEM
In-Reply-To: <CAFcVECLuWM65zXJWtMcwijZ1ZbtH0pvKnTUR=SJagPGHEr9amg@mail.gmail.com>
References: <1484841375-11420-1-git-send-email-andrei.pistirica@microchip.com>
 <BN3PR07MB25160FCBCF19918C495F43B4C9770@BN3PR07MB2516.namprd07.prod.outlook.com>
 <CAFcVECLuWM65zXJWtMcwijZ1ZbtH0pvKnTUR=SJagPGHEr9amg@mail.gmail.com>
Message-ID: <1bf44464-6f85-64a9-a660-8d2c44015eb9@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/01/2017 ? 06:42, Harini Katakam a ?crit :
> Hi Rafal,
> 
> On Thu, Jan 26, 2017 at 8:45 PM, Rafal Ozieblo <rafalo@cadence.com> wrote:
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
> If you are referring to TSU bit in DCFG5, then we will be relying on
> Cadence IP's information irrespective of the SoC capability
> and whether the PTP support was adequate.
> I think the capability approach gives better control and
> it is not really much to add.

Yes, absolutely. In fact we already had this discussion and decided that
this capability scheme was giving much more control at low cost.

Regards,
-- 
Nicolas Ferre

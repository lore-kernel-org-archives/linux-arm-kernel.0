From: stefan@agner.ch (Stefan Agner)
Date: Mon, 14 Jul 2014 09:10:54 +0200
Subject: [PATCH] can: flexcan: add vf61x support for flexcan
In-Reply-To: <cecd42e333cdf65ad512f719125f9180@agner.ch>
References: <1405075933-22317-1-git-send-email-stefan@agner.ch>
 <53BFD401.8030101@pengutronix.de>
 <dac76ccd134f41b86f00352d10cfae4b@agner.ch> <20140714060344.GB2197@dragon>
 <cecd42e333cdf65ad512f719125f9180@agner.ch>
Message-ID: <7da069ecd355069d82cbe95adc1043f5@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-07-14 09:06, schrieb Stefan Agner:
> Am 2014-07-14 08:04, schrieb Shawn Guo:
>> On Fri, Jul 11, 2014 at 03:58:37PM +0200, Stefan Agner wrote:
>>> >> @@ -362,7 +374,7 @@
>>> >>
>>> >>  			esdhc1: esdhc at 400b2000 {
>>> >>  				compatible = "fsl,imx53-esdhc";
>>> >> -				reg = <0x400b2000 0x4000>;
>>> >> +				reg = <0x400b2000 0x1000>;
>>> >
>>> > What's that doing here? :)
>>>
>>> That's an error I just stumbled upon.
>>
>> I do not see why it's an error.  From Table 2-1. System Memory Map in
>> i.MX53 RM, the size of ESDHC1 is 16K.
>>
>> Shawn
> 
> But then, the memory map within the SDHC peripheral has some registers
> also located in 0x400B3000. Hence I think 0x2000 is correct. Will send
> an updated and separated patch.
> 

Sorry, I read this wrong. It is SDHC1 which is in the upper 0x1000 of
the memory map.

So I would say 0x1000 is really correct, since SDHC0 is at 0x400B1000
and SDHC1 is at 0x400B2000.

--
Stefan

From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 16 Feb 2016 16:10:14 +0000
Subject: [PATCH v3 09/10] ARM: dts: introduce MPS2 AN385/AN386
In-Reply-To: <7562697.iiO7rmWd7c@wuerfel>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <1455617295-23736-10-git-send-email-vladimir.murzin@arm.com>
 <7562697.iiO7rmWd7c@wuerfel>
Message-ID: <56C349E6.2000002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/16 11:01, Arnd Bergmann wrote:
> On Tuesday 16 February 2016 10:08:14 Vladimir Murzin wrote:
>> +
>> +       ethernet at 40200000 {
>> +               compatible = "smsc,lan9220", "smsc,lan9115";
>> +               reg = <0x40200000 0x10000>;
>> +               interrupts = <13>;
>> +               interrupt-parent = <&nvic>;
>> +               smsc,irq-active-high;
>> +       };
>> +};
>> +
>>
> 
> This node seems slightly misplaced. Is there some external bus interface
> that this is connected to? The address suggests that it should be somewhere
> below the /soc node, and you probably want to list the external bus
> interface with a "ranges" property that identifies the addresses visibile
> there, and put the external chip under there.
> 

I might messed it up since the MAC/PHY connects to the same 16-bit
interface as the 16MB PSRAM external memory and both connected via AHB.

Not sure how it should be expressed, so some help form DT camp would be
appreciated.

Cheers
Vladimir

> 	Arnd
> 
> 
> 

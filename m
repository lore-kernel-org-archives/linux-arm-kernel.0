From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 12 Oct 2017 13:24:42 +0200
Subject: [PATCH 16/16] arm64: dts: marvell: armada-3720-espressobin: fill
 UART nodes
In-Reply-To: <20171009093025.78d45a9a@xps13> (Miquel RAYNAL's message of "Mon,
 9 Oct 2017 09:30:25 +0200")
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
 <20171006101344.15590-17-miquel.raynal@free-electrons.com>
 <87fuawe8gx.fsf@free-electrons.com>
 <20171006151521.440418a2@windsurf.lan> <20171009093025.78d45a9a@xps13>
Message-ID: <87zi8wbocl.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On lun., oct. 09 2017, Miquel RAYNAL <miquel.raynal@free-electrons.com> wrote:

> Hi Thomas, Gregory,
>
> On Fri, 6 Oct 2017 15:15:21 +0200
> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
>
>> Hello,
>> 
>> On Fri, 06 Oct 2017 15:01:18 +0200, Gregory CLEMENT wrote:
>> 
>> >  /*
>> >   * To enable the second UART on J17 (pins 24,26) refer to the uart1
>> >   * node from armada-3720-db.dts.
>> >   * Note that TX and RX signal are the ones coming directly from
>> > the SoC:
>> >   * 1.8V TTL.
>> >   */  
>> 
>> One issue with this comment (and Miqu?l's version as well) is that it
>> does not explain why you don't enable this UART by default.
>> 
>> The real reason is in the commit log from Miqu?l, and should probably
>> be part of the comment. Perhaps something like:
>> 
>> /*
>> 
>>  * Connector J17 (pins X, Y, Z) exposes a number of different
>>  * features:
>>  *  - UART1 (pins 24 = RX, pins 26 = TX), see armada-3720-db.dts for
>> an
>>  *    example on how to enable UART1. Beware that the signals are 1.8V
>>  *    TTL.
>>  *  - SPIxyz
>>  *  - I2Cxyz
>>  */
>
> Thanks for both your comments, there is my version, inspired from both
> comments:
>
> /*
>  * Connector J17 exposes a number of different features. Some pins are
>  * multiplexed. This is the case for the UART1 feature (pins 24 = RX,
>  * pins 26 = TX). See armada-3720-db.dts for an example of how to enable it.
>  * Beware that the signals are 1.8V TTL.
>  */

Seems good for me however I prefer Thomas version, easier to read and to
extend latter with the description of other pins if needed.

Gregory

>
> Thanks,
> Miqu?l
>
>> 
>> Otherwise, it's not clear at all why you don't just enable UART1. Or
>> perhaps I misunderstood Miqu?l's commit log ?
>> 
>> Best regards,
>> 
>> Thomas
>
>
>
> -- 
> Miquel Raynal, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

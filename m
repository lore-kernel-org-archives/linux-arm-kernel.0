From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 26 May 2015 14:20:08 +0200
Subject: [PATCH 2/3] spi: orion: Fix extended baud rates for each Armada
 SoCs
In-Reply-To: <20150526120853.GB28523@lunn.ch>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
 <20150526120853.GB28523@lunn.ch>
Message-ID: <556464F8.1020707@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew, Mark,

On 26/05/2015 14:08, Andrew Lunn wrote:
>> --- a/Documentation/devicetree/bindings/spi/spi-orion.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
>> @@ -1,7 +1,13 @@
>>  Marvell Orion SPI device
>>  
>>  Required properties:
>> -- compatible : should be "marvell,orion-spi" or "marvell,armada-370-spi".
>> +- compatible : should be on of the following:
>> +    - "marvell,orion-spi" for the Orion, mv78x00, Kirkwood and Dove SoCs
>> +    - "marvell,armada-370-spi", for the Armada 370 SoCs
>> +    - "marvell,armada-375-spi", for the Armada 375 SoCs
>> +    - "marvell,armada-380-spi", for the Armada 38x SoCs
>> +    - "marvell,armada-390-spi", for the Armada 38x SoCs
> 
> Hi Gregory
> 
> Is that a typ0?

yes it is! :/

Mark do you want a new patch or do you prefer fixing the typo
yourself ? it should be
    - "marvell,armada-390-spi", for the Armada 39x SoCs
instead of
    - "marvell,armada-390-spi", for the Armada 38x SoCs

s/38x/39x/ on this line.


Thanks,

Gregory


> 
>    Andrew
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Oct 2015 20:37:51 -0600
Subject: [PATCH RFT] ARM: bcm2835: dt: fix memory of Raspberry Pi B+
In-Reply-To: <8737x5ncod.fsf@eliezer.anholt.net>
References: <1444942124-23122-1-git-send-email-stefan.wahren@i2se.com>
 <8737x5ncod.fsf@eliezer.anholt.net>
Message-ID: <5626FA7F.2060903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2015 02:53 AM, Eric Anholt wrote:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
>> Since the Raspberry Pi models differ in memory amount we better
>> define it at board level. After that we are able to fix the
>> memory node of the Raspberry Pi B+ .

>> diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
>> b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts

>> +	memory { +		reg = <0 0x10000000>; /* 256 MB */ +	}; +

> 
> Seems like a good idea.  The closed firmware passes us an edited 
> devicetree with good memory fields, but I don't think U-Boot is up
> to it if you chainload it.

U-Boot fills in the memory size in DT correctly too.

I have no objection to the patch since it looks correct at a very
brief glance, but I think it will have zero practical effect.

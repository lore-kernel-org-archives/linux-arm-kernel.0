From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 17 Jul 2012 14:25:24 +0100
Subject: Device tree.
In-Reply-To: <50056391.3060208@codethink.co.uk>
References: <500552C9.4090107@codethink.co.uk>
 <20120717140100.7c0ae90c@skate> <500556CF.6030704@codethink.co.uk>
 <CAMW5UfZR5qrY4K=ty9HDcd9UqYGtfZitH0CBgDbZWvpAoTve2Q@mail.gmail.com>
 <50056391.3060208@codethink.co.uk>
Message-ID: <8f3d9be256cbe0feec86cca6aaefd437@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/2012 14:07, Ian Molton wrote:
> On 17/07/12 13:32, Josh Coombs wrote:
>> make make target.dtb
>> cat arch/arm/boot/target.dtb  >> arch/arm/boot/zImage
>>make uImage
>
> Yick...

How about adding a dts=<address> argument to the current
command line handling. If this is found, then the system
ignores the rest of the atags passed and uses the passed
address for the device-tree settings.

This means in u-boot, you just need to load the .dts file
into place before booting the kernel.

-- 
Ben

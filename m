From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 10 Mar 2014 10:28:26 +0000
Subject: [PATCH] net: phy: Add sysfs attribute to prevent PHY suspend
In-Reply-To: <20140309.234032.873557698878535571.davem@davemloft.net>
References: <531D094C.1090205@gmail.com>
 <20140309.204101.47552917508273123.davem@davemloft.net>
 <531D0D0D.4050703@gmail.com>
 <20140309.234032.873557698878535571.davem@davemloft.net>
Message-ID: <531D93CA.6050801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2014 03:40 AM, David Miller wrote:
> From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Date: Mon, 10 Mar 2014 01:53:33 +0100
>
>> On 03/10/2014 01:41 AM, David Miller wrote:
>>> From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> Date: Mon, 10 Mar 2014 01:37:32 +0100
>>>
>>>> The mechanism is manual, no automatic way to determine it.
>>>
>>> We recognize BIOS and ACPI bugs and work around them, by looking at
>>> version information and whatnot, so you really can't convince me that
>>> something similar can't be done here perhaps in the platform code.
>>
>> Hmm, if the is a way to determine the version of that particual u-boot
>> I'd be happy to exploit that information. But I honestly doubt that.
>> Compared to u-boot bootloader and kernel interaction, BIOS and ACPI
>> are well-defined protocols.
>>
>> I personally, would prefer everybody should update his broken
>> bootloaders, but that will just not happen.
>
> What you can do is have a test that _perhaps_ covers a "broader than
> reality" list of broken bootloader cases.
>
> Then you have something the bootloader can provide which indicates
> that it has been fixed.

I think we can just pass the workaround responsibility back to the
bootloader. You rejected both easy-to-maintain workarounds for good
reasons, both bootloaders I know of can be fixed by just resuming the
PHY by bootloader commands. Users of this two boards can prepend their
tftpboot commands with an appropriate write to BMCR.

Let's just ignore this for now and wait for a really unfixable
bootloader.

Sebastian

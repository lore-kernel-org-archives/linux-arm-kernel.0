From: robherring2@gmail.com (Rob Herring)
Date: Tue, 22 Jan 2013 14:46:49 -0600
Subject: [PATCH 3/6] arm: kconfig: don't select TWD with local timer for
 Armada 370/XP
In-Reply-To: <201301212044.41865.arnd@arndb.de>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <201301211831.45947.arnd@arndb.de>
 <CAKGA1b=9WQNwHOz=k13XVc=MyZT1UrcaYj8muF2A5B4eJA5+MA@mail.gmail.com>
 <201301212044.41865.arnd@arndb.de>
Message-ID: <50FEFAB9.4030503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 02:44 PM, Arnd Bergmann wrote:

>> On multiplatform kernels where at least one arch has TWD support, it
>> will be included, and where not, it will not.
>>
>> It doesn't seem logical for a feature descriptor (HAVE_ARM_TWD) to
>> rely on greater knowledge of what platforms may or may not support it.
>> If we had to include every platform in that list it would be unwieldy.
> 
> I would expect that all future platforms have ARM_TWD, so the list
> of the platforms that don't is not going to grow much, but the list
> of platforms that do will keep growing.

No, I expect all future platforms will have architected timers. TWD is
pretty much A9 and A5 only I believe. Same with SCU. I've probably
missed some in my list.

Rob

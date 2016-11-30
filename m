From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 30 Nov 2016 19:59:26 +0200
Subject: [GIT PULL] ARM: keystone: add TI SCI protocol support for v4.10
In-Reply-To: <9563335.412haHXOPG@wuerfel>
References: <e6b04eeb-ebfb-2da0-834b-1da440a35783@ti.com>
 <d685444b-4275-e6e6-aae6-214a41776a28@ti.com> <9563335.412haHXOPG@wuerfel>
Message-ID: <6f67f67f-7489-6d62-c2c2-9bba440cfabc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/16 18:43, Arnd Bergmann wrote:
> On Monday, November 28, 2016 6:42:41 PM CET Tero Kristo wrote:
>> Gentle ping on this, is anybody going to pull this one?
>>
>> -Tero
>>
>> On 27/10/16 12:30, Tero Kristo wrote:
>>> Hi Arnd, Olof, Kevin,
>>>
>>> This pull introduces the TI SCI protocol support for keystone family of
>>> devices, targeted for v4.10 merge window. We discussed with Santosh
>>> (keystone maintainer) that it would probably be better that I'll be
>>> sending the pull requests for this directly, avoiding one extra step of
>>> merges.
>>
>
> Sorry for the delay. I just saw this pull request in the backlog
> and had to take a closer look first. I probably would have commented
> on a few details in a proper review, but overall this seems harmless
> enough, so I've merged it into next/drivers in the end.
>
> There was no branch description in
>  https://github.com/t-kristo/linux-pm.git for-4.10-ti-sci-base
> and I ended up taking something from the wiki. This is now the
> commit I ended up with:

Thanks Arnd, that looks good to me.

I'll figure out how to add branch description next time when I am going 
to be sending a pull-request directly to you guys.

-Tero

>
> commit ba9cb7b9ffa4a4056158bc8570f1a851e4a6a8ae
> Merge: e7541f9 912cffb
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Wed Nov 30 17:13:13 2016 +0100
>
>     Merge branch 'for-4.10-ti-sci-base' of https://github.com/t-kristo/linux-pm into next/drivers
>
>     Merge "ARM: keystone: add TI SCI protocol support for v4.10" from
>     Tero Kristo:
>
>     [description taken from http://processors.wiki.ti.com/index.php/TISCI
>
>     Texas Instruments' Keystone generation System on Chips (SoC) starting
>     with 66AK2G02, now include a dedicated SoC System Control entity called
>     PMMC(Power Management Micro Controller) in line with ARM architecture
>     recommendations. The function of this module is to integrate all system
>     operations in a centralized location. Communication with the SoC System
>     Control entity from various processing units like ARM/DSP occurs over
>     Message Manager hardware block.
>
>     ...
>
>     Texas Instruments' System Control Interface defines the communication
>     protocol between various processing entities to the System Control Entity
>     on TI SoCs. This is a set of message formats and sequence of operations
>     required to communicate and get system services processed from System
>     Control entity in the SoC.]
>
>     * 'for-4.10-ti-sci-base' of https://github.com/t-kristo/linux-pm:
>       firmware: ti_sci: Add support for reboot core service
>       firmware: ti_sci: Add support for Clock control
>       firmware: ti_sci: Add support for Device control
>       firmware: Add basic support for TI System Control Interface (TI-SCI) protocol
>       Documentation: Add support for TI System Control Interface (TI-SCI) protocol
>
> 	Arnd
>

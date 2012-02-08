From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 08 Feb 2012 13:09:02 +0200
Subject: [PATCH] ARM: OMAP: update omap1 and omap2plus defconfigs
In-Reply-To: <20120208101958.GT1275@n2100.arm.linux.org.uk>
References: <20120208053556.GB1426@atomide.com>
 <1328696173-17226-1-git-send-email-grinberg@compulab.co.il>
 <20120208101958.GT1275@n2100.arm.linux.org.uk>
Message-ID: <4F3257CE.7070909@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 02/08/12 12:19, Russell King - ARM Linux wrote:
> On Wed, Feb 08, 2012 at 12:16:13PM +0200, Igor Grinberg wrote:
>> This patch updates omapX_defconfig to 3.3-rc1 and enables
>> the CONFIG_DEBUG_SECTION_MISMATCH.
> 
> You shouldn't enable this in the kernel supplied defconfigs.

Hmmm... Ok, looks like I've forgot the purpose of defconfigs...
It is intended for users rather than developers (right?) and
the CONFIG_DEBUG_SECTION_MISMATCH has no use for users?
Is it the case, or is there anything else?

> 
>> The update is done by:
>> 1) make mrproper && make omapX_defconfig
>> 2) Enable the CONFIG_DEBUG_SECTION_MISMATCH
>> 3) make savedefconfig
>> 4) cp defconfig arch/arm/configs/omapX_defconfig
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>> After updating omap1_defconfig,
>> there are several section mismatch warnings seen.
>> Hopefully, I will have time to fix those tomorrow
>> (unless someone will be kind enough to fix them before me).
>> The mismatches are:
> 
> The correct way is to build with:
> 
> make ... CONFIG_DEBUG_SECTION_MISMATCH=y
> 
> or set it in your private configuration.

In my current setup, command line switch would be most appropriate.
Thanks for suggestion.


-- 
Regards,
Igor.

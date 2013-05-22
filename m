From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 22 May 2013 12:01:29 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130521193803.GA20882@1wt.eu>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130521193803.GA20882@1wt.eu>
Message-ID: <519C9779.1040104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2013 09:38 PM, Willy Tarreau wrote:
> On Tue, May 21, 2013 at 12:33:25PM +0200, Thomas Petazzoni wrote:
> (...)
>> As it was explained above, we unfortunately can't read the
>> current base address of the internal register window, so we need a
>> different mechanism to know if the bootloader has done the remapping
>> at 0xF1000000 (new generation bootloader) or has left the internal
>> registers at 0xD0000000 (old generation bootloader).
>
> Just out of curiosity, what happens if you touch the register at the
> wrong address ? I mean, if you blindly write to the 0xD0xxxxxx address
> that you want the registers to be mapped at 0xF1xxxxxx. Will the chip
> hang, will it silently ignore the sequence ? Because maybe you don't
> need to detect using CP15 whether the remapping was done, you could
> simply perform it unconditionally.

Willy,

I tried the above on Dove which is possibly affected by the workaround
as it is also ARMv7. In Dove you can access unmapped addresses without
any problems, but as Thomas already stated Armada 370/XP just hang.
Must be some default AHB slave in Dove, which Armada 370/XP is missing.

Sebastian

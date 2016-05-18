From: agraf@suse.de (Alexander Graf)
Date: Wed, 18 May 2016 18:16:05 +0200
Subject: [PATCH v2] arm64: Allow for different DMA and CPU bus offsets
In-Reply-To: <3270693.WrXnxabe9J@wuerfel>
References: <1463576010-115428-1-git-send-email-agraf@suse.de>
 <20160518151958.GH22378@e104818-lin.cambridge.arm.com>
 <573C8B55.3030805@suse.de> <3270693.WrXnxabe9J@wuerfel>
Message-ID: <573C9545.9050909@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2016 06:08 PM, Arnd Bergmann wrote:
> On Wednesday 18 May 2016 17:33:41 Alexander Graf wrote:
>>>> IIRC we don't own EL3 on there.
>>> Then how do you switch to AArch64?
>> You write into config.txt that you want to boot into AArch64 EL2 and the
>> raspberry pi firmware takes care of the rest.
>>
>>
> Have you tried telling the firmware that you'd like to boot into AArch64 EL3? ;-)

Yes, but then you don't get any SMP initialization (so we'd have to redo 
that in U-Boot, or port ATF) and you lose the usual workflow on defining 
how the hat device tree overlays work.

Overall, I think it's an interesting goal and you're more than happy to 
be my guest, but I think that spin tables are good enough for the device 
for now :). At least we'd be able to move people away from 32bit code.


Alex

From: robertcnelson@gmail.com (Robert Nelson)
Date: Mon, 11 Mar 2013 10:01:45 -0500
Subject: [PATCH 0/4] SAMA5D3 support
In-Reply-To: <513dbd6d.c99d2a0a.2f58.ffff9ac2SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1362755638-20092-1-git-send-email-ludovic.desroches@atmel.com>
 <CAOCHtYiqkQYZukbp=xOyxT_vmRRRbbpev5R3vvtKPqEu9GttOQ@mail.gmail.com>
 <513dbd6d.c99d2a0a.2f58.ffff9ac2SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <CAOCHtYgnjT3HxufD1NSbvZWqhyWqBPRBM7jz5+3YMaPc5S_-mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Looks like something is still missing, with the 3 cleanup patches
>> (delivery/at91_3.9_dt_cleanup) and these 4 on top of mainline built
>> with "sama5_defconfig" results in:
>>
>>   CC      net/wireless/ap.o
>>   CC      net/wireless/trace.o
>>   LD      net/wireless/cfg80211.o
>>   LD      net/wireless/built-in.o
>>   LD      net/built-in.o
>>   LINK    vmlinux
>>   LD      vmlinux.o
>>   MODPOST vmlinux.o
>>   GEN     .version
>>   CHK     include/generated/compile.h
>>   UPD     include/generated/compile.h
>>   CC      init/version.o
>>   LD      init/built-in.o
>> arch/arm/mach-at91/built-in.o: In function `soc_detect':
>> pm.c:(.init.text+0xa88): undefined reference to `sama5d3_soc'
>> make: *** [vmlinux] Error 1
>>
>> Everything looks correct in:
>> ./arch/arm/mach-at91/setup.c
>> ./arch/arm/mach-at91/soc.h
>>
>
> Thanks for testing it. You are right, I have split my patch series and I have
> forgotten one patch.

Hi Ludovic,

Yeap, that patch fixed it
ARM-at91-change-name-template-in-AT91_SOC_START-macr.patch

It now boots just fine on my D34-EK with v3.9-rc2 as a base..

Tested-by: Robert Nelson <robertcnelson@gmail.com>

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/

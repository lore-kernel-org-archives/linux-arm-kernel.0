From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Fri, 20 Nov 2015 11:49:57 -0500
Subject: [PATCH v2] xen/events: Always allocate legacy interrupts on PV
 guests
In-Reply-To: <alpine.DEB.2.02.1511201632390.1107@kaball.uk.xensource.com>
References: <1447870445-17199-1-git-send-email-boris.ostrovsky@oracle.com>
 <alpine.DEB.2.02.1511201117120.1107@kaball.uk.xensource.com>
 <564F397A.8010203@oracle.com>
 <alpine.DEB.2.02.1511201535550.1107@kaball.uk.xensource.com>
 <564F3F4D.9080005@oracle.com>
 <alpine.DEB.2.02.1511201632390.1107@kaball.uk.xensource.com>
Message-ID: <564F4F35.40401@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2015 11:33 AM, Stefano Stabellini wrote:
>>>
>>>
>>> BTW, I got this build error:
>>>
>>>     STUBCPY drivers/firmware/efi/libstub/lib-sort.stub.o
>>> 0000000000000000 R_AARCH64_ABS64   __efistub_sort
>>> 0000000000000008 R_AARCH64_ABS64   .init__ksymtab_strings
>>> drivers/firmware/efi/libstub/lib-sort.stub.o: absolute symbol references
>>> not
>>> allowed in the EFI stub
>>> drivers/firmware/efi/libstub/Makefile:63: recipe for target
>>> 'drivers/firmware/efi/libstub/lib-sort.stub.o' failed
>>> make[4]: *** [drivers/firmware/efi/libstub/lib-sort.stub.o] Error 1
>>> scripts/Makefile.build:403: recipe for target
>>> 'drivers/firmware/efi/libstub'
>>> failed
>>> make[3]: *** [drivers/firmware/efi/libstub] Error 2
>>> scripts/Makefile.build:403: recipe for target 'drivers/firmware/efi'
>>> failed
>>> make[2]: *** [drivers/firmware/efi] Error 2
>>> scripts/Makefile.build:403: recipe for target 'drivers/firmware' failed
>>> make[1]: *** [drivers/firmware] Error 2
>>> Makefile:943: recipe for target 'drivers' failed
>>> make: *** [drivers] Error 2
>>>
>>> I worked around this by removing some of EFI config options but presumably
>>> this needs to be properly fixed.
>>> Interesting. This build error could be something new. Could you please
>>> post your kernel config?
>> Attached.
>>
>> This, BTW, is on a relatively old toolstack:
>> gcc version 4.8.2 20131014 (prerelease) (crosstool-NG
>> linaro-1.13.1-4.8-2013.10 - Linaro GCC 2013.10)
> Interesting. I cannot repro the error with Linaro GCC 4.9-2014.

This does look like something toolstack-specific: I installed
     gcc version 4.8.3 20140401 (prerelease) (crosstool-NG 
linaro-1.13.1-4.8-2014.04 - Linaro GCC 4.8-2014.04)
from the link you provided above and it built without problems.

-boris

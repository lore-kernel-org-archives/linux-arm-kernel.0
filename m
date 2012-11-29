From: mmayer@broadcom.com (Markus Mayer)
Date: Thu, 29 Nov 2012 12:02:09 -0800
Subject: Branches next/soc and for-next
Message-ID: <50B7BF41.7060807@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Following a short discussion with Pawel regarding a build breakage in 
next/soc (see 
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/thread.html#135208), 
I would like to ask you for some clarification as to the differences 
between the branches next/soc and for-next and what that means for 
development.

If I understand correctly, next/soc is being used to integrate SoC work 
from various board- or vendor-specific branches. for-next, in turn, 
integrates next/soc with driver branches and other non-SoC related 
branches. Is this somewhat accurate? -- What happens to code in 
for-next? Is that what eventually gets pulled into mainline?

As I mentioned in my discussion with Pawel, next/soc currently doesn't 
build for vexpress and, since vexpress is multiplatform-enabled, no 
other multiplatform target will build, either. The reason for this, 
Pawel explained, was that he was asked to split his patch, so it could 
be applied to different branches, depending on the subsystem area his 
changes were made in. As a result, a file needed for compilation 
(arch/mach-vexpress/reset.c) is missing in next/soc.

How are such build errors generally addressed? How long does it usually 
take? And, lastly, which branch would you recommend to use for 
development to generate patches relative to arm-soc?

Thanks for your help.

Regards,
-Markus

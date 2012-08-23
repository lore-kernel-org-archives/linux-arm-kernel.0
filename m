From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 23 Aug 2012 12:58:29 +0000
Subject: [PATCHv4 0/9] *** ARM: Update arch-vt8500 to Devicetree ***
In-Reply-To: <201208231040.16702.arnd@arndb.de>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>,
 <201208231040.16702.arnd@arndb.de>
Message-ID: <76F764B079F92A4E843589C893D0A022DAF68C14@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>On Thursday 23 August 2012, Tony Prisk wrote:
>> Patchset based on Arnd's arm-soc/for-next branch.
>>
>>
>> Could I get this reviewed, hopefully for inclusion into v3.7.

>I can take them into the arm-soc tree if there are no new comments.
>For the last two patches, you need to get an Acked-by comment from the
>gpio and clk maintainers, respectively, or you should send them
>the patches for inclusion in those subsystem trees.

>        Arnd


Linus W has provided some feedback on the gpio driver - I missed the
issues he raised the first time around so just waiting for him to take a look
at v4 when he's got time.

I haven't heard from Mike T in regards to the new clock code - He did
reply about the original patch (pre-devicetree) but I asked him to hold off
reviewing it because it was going to be rewritten.

EHCI/UHCI has gone to -next (on patchv2) via usb-next
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
There haven't been any changes to it in v3/v4.

GPIO going via another tree isn't really an issue if necessary.

Without the clock patch (9/9), the mach-vt8500 patch (6/9) won't compile
due to unresolved symbols.

In arch/arm/mach-vt8500/vt8500.c - you will get an unresolved symbol
for 'vtwm_clk_init'

Not sure if this matters, thought I should point it out.
Does it need to compile cleanly in your tree (which is what I would assume),
or just once its all combined in -next?
Does it matter that the usb patches are already in -next?

I don't really understand the requirements around submitting to individual
trees and which (if any) of these points are actually issues.

Regards

Tony Prisk

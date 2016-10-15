From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 15 Oct 2016 23:17:08 +0200
Subject: [PATCH v2 0/4] PXA cpufreq conversion to clock API
In-Reply-To: <20161015203421.GG1041@n2100.armlinux.org.uk> (Russell King's
 message of "Sat, 15 Oct 2016 21:34:21 +0100")
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <20161015203421.GG1041@n2100.armlinux.org.uk>
Message-ID: <87oa2l5n3f.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Sat, Oct 15, 2016 at 09:57:26PM +0200, Robert Jarzmik wrote:
>> Hi,
>> 
>> This serie is a preparation to shift the cpufreq of pxa2xx platforms to clocks
>> API.
>> 
>> The first 3 patches are review and merge material :
>>  - patch 1/4 for Viresh and Rafael
>>  - patches 2/4 and 3/4 for me
>> 
>> The 4th on is for review but not merge, as the clock changes must be fully
>> reviewed and go in first as a prequisite
>
> Have you tested whether this patch set results in functional cpufreq
> support - looking at drivers/clk/pxa, the CPU clock is read-only -
> it can't be used to change the clock rate.  So, I very much doubt this
> has been functionally tested.

Oh yes I did, on lubbock and mainstone ... but this requires another patchset
under review, here :
https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1247123.html

> Don't forget that changing the CPU clock rate needs other changes
> (like the memory clock rate) so all that code you're removing in
> patch 4 (which does the actual clock change) needs to go somewhere.
Sure, here :
https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1247130.html

I would have been wiser to quote these URLs instead of speaking of "clock
changes must be fully review and go in first as a prequisite".

Cheers.

-- 
Robert

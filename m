From: jonathan@jonmasters.org (Jon Masters)
Date: Mon, 26 Mar 2012 09:07:44 -0400
Subject: Inconsistent kallsyms data on ARM.
In-Reply-To: <20120326073704.GH5611@n2100.arm.linux.org.uk>
References: <CAP=VYLoStscdVJretZ-Rkbp7V3Vsm8N0oWcjih7ruHFiDN7CiA@mail.gmail.com>
 <201203141321.47010.arnd@arndb.de>
 <20120325112035.GE5611@n2100.arm.linux.org.uk>
 <4F6FB170.1040109@jonmasters.org>
 <20120326073704.GH5611@n2100.arm.linux.org.uk>
Message-ID: <4F706A20.6020302@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2012 03:37 AM, Russell King - ARM Linux wrote:
> On Sun, Mar 25, 2012 at 07:59:44PM -0400, Jon Masters wrote:
>> As to longer term, I am happy to work up something that will spot this
>> particular kind of failure (symbol changes type) and output something
>> more useful during the kallsyms generation if you would like.
>>
>> Are you planning to pull in either of the fixes you mention?
> 
> I'm not, because those are all sub-optimal - I don't see why we should
> bloat the kernel image just for the sake of working around kallsyms.
> 
> The best I've come up with so far which avoids that is to force
> KALLSYMS_EXTRA_PASS to always be set on ARM.

Or just increasing the base number of kallsyms runs on ARM? That way,
you can have a real extra extra pass in the case of something else :)

Jon.

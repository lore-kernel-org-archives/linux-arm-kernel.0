From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 Aug 2017 09:12:36 -0700
Subject: [GIT PULL 2/2] bcm2835-soc-next-2017-08-15
In-Reply-To: <36766926-c8d6-b768-59b6-4ff302a6a5ba@gmail.com>
References: <20170815180325.12809-1-eric@anholt.net>
 <20170815180325.12809-2-eric@anholt.net>
 <36766926-c8d6-b768-59b6-4ff302a6a5ba@gmail.com>
Message-ID: <87valmgoln.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> On 08/15/2017 11:03 AM, Eric Anholt wrote:
>> The following changes since commit f29c256853b7412961d3ee80ca525bd2530573db:
>> 
>>   ARM: dts: bcm283x: Add 32-bit enable method for SMP (2017-08-14 20:09:44 +0200)
>> 
>> are available in the git repository at:
>> 
>>   git://github.com/anholt/linux tags/bcm2835-soc-next-2017-08-15
>> 
>> for you to fetch changes up to 067b437e55a892e3ebb13e40c98825fcfa1e2d99:
>> 
>>   ARM: bcm2836: Send event when onlining other cores (2017-08-15 10:52:26 -0700)
>> 
>> ----------------------------------------------------------------
>> This pull request brings in two things.
>> 
>> One is to use sev() to wake up CPUs that might be sleeping when doing
>> the custom spin-table boot process in 32-bit mode (new firmware
>> versions will have the CPUs sleeping waiting for an event instead of
>> just spinning).  However, the irqchip maintainer objected to our SMP
>> code continuing to live in the driver, so we had to move it to
>> platsmp.c, and to do that we needed a new SMP enable-method to the DT
>> for the platsmp.c to attach to (thus the DT cross-merge in this PR).
>> The platsmp.c patch was acked by irqchip for going through arm-soc.
>
> This does make us pull quite a lot of changes, how about I just
> cherry-pick "ARM: dts: bcm283x: Add 32-bit enable method for SMP" such
> that the branch in itself is functional as-is, but we don't pull in
> everything else from devicetree/next?

Then you get the commit duplicated in the history, which people
generally dislike even more.  Also, it depends on the arm64->arm move,
so you'd need that as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170817/3cf7946c/attachment-0001.sig>

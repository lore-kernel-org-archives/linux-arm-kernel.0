From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 22 Oct 2012 10:53:19 -0700
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210200614390.9865@utopia.booyaka.com> (Paul
 Walmsley's message of "Sat, 20 Oct 2012 06:24:03 +0000 (UTC)")
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <alpine.DEB.2.00.1210200614390.9865@utopia.booyaka.com>
Message-ID: <87objufl68.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin
>
> On Fri, 19 Oct 2012, Paul Walmsley wrote:
>
>> On Thu, 18 Oct 2012, Paul Walmsley wrote:
>> 
>> > Here are some basic OMAP test results for Linux v3.7-rc1.
>> > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/
>
> ...
>
>> > Failing tests: needing investigation
>> > ------------------------------------
>> > 
>
> ...
>
>> > PM tests:
>>
>> * 3730 Beagle XM: OPPs do not initialize
>>   - Several "find_device_opp: Invalid parameters" messages appear on boot; 
>>     related warnings follow
>>   - Cause unknown
>
> This one seems to be caused by this commit:
>
> commit 24d7b40a60cf19008334bcbcbd98da374d4d9c64
> Author: Kevin Hilman <khilman@ti.com>
> Date:   Thu Sep 6 14:03:08 2012 -0700
>
>     ARM: OMAP2+: PM: MPU DVFS: use generic CPU device for MPU-SS
>     
> Care to take a look at it and fix it?
>

Yup, will fix.  Looks like this exposed some initcall ordering issues in
the Beagle board file when adding OPPs.

Kevin

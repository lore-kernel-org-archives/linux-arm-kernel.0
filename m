From: mans@mansr.com (=?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sat, 21 Nov 2015 20:45:38 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <7199523.6J0A1gxY4q@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <7199523.6J0A1gxY4q@wuerfel>
Message-ID: <5239BA2A-BCD9-4A8C-BC34-F48603137E08@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 November 2015 20:39:58 GMT+00:00, Arnd Bergmann <arnd@arndb.de> wrote:
>On Friday 20 November 2015 17:23:14 Stephen Boyd wrote:
>> This is a respin of a patch series from about a year ago[1]. I
>realized
>> that we already had most of the code in recordmcount to figure out
>> where we make calls to particular functions, so recording where
>> we make calls to the integer division functions should be easy enough
>> to add support for in the same codepaths. Looking back on the thread
>> it seems like Mans was thinking along the same lines, although it
>wasn't
>> obvious to me back then or even over the last few days when I wrote
>this.
>
>Shouldn't we start by allowing to build the kernel for -march=armv7ve
>on platforms that allow it? That would seem like a simpler change
>and likely generate better code for most people, except when you
>actually
>care about running the same binary kernel on older platforms.
>
>I tried to get a complete list of CPU cores with idiv, lpae and
>virtualization support at some point, but I don't remember the
>details for all Qualcomm and Marvell cores any more, to create the
>complete configuration matrix. IIRC, all CPUs that support
>virtualization also do lpae (they have to) and all CPUs that
>do lpae also do idiv, but the opposite is not true.
>
>	Arnd

The ARM ARM says anything with virt has idiv, lpae doesn't matter. ARMv7-R also has idiv. I've no idea if anyone runs Linux on those though.
-- 
M?ns Rullg?rd

From: khilman@ti.com (Kevin Hilman)
Date: Wed, 30 May 2012 11:07:52 -0700
Subject: [PATCH] ARM: OMAP3/4: consolidate cpuidle Makefile
In-Reply-To: <4FC59CDD.1030100@linaro.org> (Daniel Lezcano's message of "Wed,
 30 May 2012 06:06:53 +0200")
References: <1336644177-13834-1-git-send-email-daniel.lezcano@linaro.org>
 <4FB08D24.7070101@ti.com> <4FC59CDD.1030100@linaro.org>
Message-ID: <87pq9l8ruv.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 05/14/2012 06:42 AM, Rajendra Nayak wrote:
>> On Thursday 10 May 2012 03:32 PM, Daniel Lezcano wrote:
>>> The current Makefile compiles the cpuidle34xx.c and cpuidle44xx.c files
>>> even if the cpuidle option is not set in the kernel.
>>>
>>> This patch fixes this by creating a section in the Makefile where these
>>> files are compiled only if the CONFIG_CPU_IDLE option is set.
>>>
>>> This modification breaks an implicit dependency between CPU_IDLE and
>>> PM as
>>> they belong to the same block in the Makefile. This is fixed in the
>>> Kconfig
>>> by selecting explicitely PM is CPU_IDLE is set.
>>>
>>> The linux coding style recommend to use no-op functions in the headers
>>> when the subsystem is disabled instead of adding big section in C files.
>> 
>> Looks good to me.
>> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
>
> Hi Kevin,
>
> I think I addressed all the points. Is it possible to consider this
> patch for inclusion ?
>

Yes.  I'll queue up as a cleanup for v3.6 with the reviewed-by from
Rajendra.

Thanks,

Kevin

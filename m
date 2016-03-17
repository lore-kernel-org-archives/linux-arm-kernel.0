From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Thu, 17 Mar 2016 18:31:44 -0400
Subject: [PATCH v2 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <20160317193600.GY6344@twins.programming.kicks-ass.net>
References: <1458147733-29338-1-git-send-email-cmetcalf@mellanox.com>
 <1458147733-29338-2-git-send-email-cmetcalf@mellanox.com>
 <20160317193600.GY6344@twins.programming.kicks-ass.net>
Message-ID: <56EB3050.3060607@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/17/2016 3:36 PM, Peter Zijlstra wrote:
> On Wed, Mar 16, 2016 at 01:02:10PM -0400, Chris Metcalf wrote:
>> Currently you can only request a backtrace of either all cpus, or
>> all cpus but yourself.  It can also be helpful to request a remote
>> backtrace of a single cpu, and since we want that, the logical
>> extension is to support a cpumask as the underlying primitive.
>>
>> This change modifies the existing lib/nmi_backtrace.c code to take
>> a cpumask as its basic primitive, and modifies the linux/nmi.h code
>> to use either the old "all/all_but_self" arch methods, or the new
>> "cpumask" method, depending on which is available.
>>
>> The existing clients of nmi_backtrace (arm and x86) are converted
>> to using the new cpumask approach in this change.
> So the past days I've been staring at RCU stall warns, and they can use
> a little of this. Their remote stack unwinds are less than useful.

Were you suggesting this as an improvement for a possible v3, or just a
kind of implicit ack of the patch series?  Thanks!

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com

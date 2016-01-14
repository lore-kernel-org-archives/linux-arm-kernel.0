From: Leonid.Yegoshin@imgtec.com (Leonid Yegoshin)
Date: Thu, 14 Jan 2016 11:42:02 -0800
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160114161604.GT3818@linux.vnet.ibm.com>
References: <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com> <56969F4B.7070001@imgtec.com>
 <20160113204844.GV6357@twins.programming.kicks-ass.net>
 <5696BA6E.4070508@imgtec.com> <20160114120445.GB15828@arm.com>
 <20160114161604.GT3818@linux.vnet.ibm.com>
Message-ID: <5697FA0A.6040601@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2016 08:16 AM, Paul E. McKenney wrote:
> On Thu, Jan 14, 2016 at 12:04:45PM +0000, Will Deacon wrote:
>> On Wed, Jan 13, 2016 at 12:58:22PM -0800, Leonid Yegoshin wrote:
>>> On 01/13/2016 12:48 PM, Peter Zijlstra wrote:
>>>> On Wed, Jan 13, 2016 at 11:02:35AM -0800, Leonid Yegoshin wrote:
>>>>
>>>>> I ask HW team about it but I have a question - has it any relationship with
>>>>> replacing MIPS SYNC with lightweight SYNCs (SYNC_WMB etc)?
>>>> Of course. If you cannot explain the semantics of the primitives you
>>>> introduce, how can we judge the patch.
>>>>
>>>>
>>> You missed a point - it is a question about replacement of SYNC with
>>> lightweight primitives. It is NOT a question about multithread system
>>> behavior without any SYNC. The answer on a latest Will's question lies in
>>> different area.
> What Will said!
>
> Yes, you can cut corners within MIPS architecture-specific code,
> but primitives that are used in the core kernel really do need to
> work as expected.
>
> 							Thanx, Paul
>
>
Absolutelly! Please use SYNC - right now it is not.

An the only point - please use an appropriate SYNC_* barriers instead of 
heavy bold hammer. That stuff was design explicitly to support the 
requirements of Documentation/memory-barriers.txt

It is easy - just use smp_acquire instead of plain smp_mb 
insmp_load_acquire, at least for MIPS.

- Leonid.
- Leonid.

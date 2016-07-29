From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Fri, 29 Jul 2016 14:16:07 -0400
Subject: [PATCH]: arm64: factor work_pending state machine to C
In-Reply-To: <20160711121953.GH31221@leverpostej>
References: <1459877922-15512-1-git-send-email-cmetcalf@mellanox.com>
 <1459877922-15512-13-git-send-email-cmetcalf@mellanox.com>
 <e19d6de0-c754-d53b-3420-16d460a4cb33@mellanox.com>
 <20160708154901.GF6493@arm.com> <20160711114237.GE17735@arm.com>
 <20160711121953.GH31221@leverpostej>
Message-ID: <b2af2833-3e4f-10a9-f568-9f19efc9186f@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/11/2016 8:19 AM, Mark Rutland wrote:
> On Mon, Jul 11, 2016 at 12:42:37PM +0100, Will Deacon wrote:
>> On Fri, Jul 08, 2016 at 04:49:01PM +0100, Will Deacon wrote:
>>> On Fri, Jul 08, 2016 at 11:43:50AM -0400, Chris Metcalf wrote:
>>>> I am hopeful that this patch [1] can be picked up for the 4.8 merge window
>>>> in the arm64 tree.  As I mentioned in my last patch series that included
>>>> this patch [2], I'm hopeful that this version addresses the performance
>>>> issues that were seen with Mark's original patch.  This version tests the
>>>> TIF flags prior to calling out to the loop in C code.
>>> I still need to get round to measuring that again. This might also
>>> conflict with a late fix I just sent for 4.7.
>> FWIW, I've failed to measure any performance overhead from this change,
>> so it certainly looks better thsn Mark's original patch from that angle.
> FWIW, likewise, with perf bench sched atop of v4.7-rc6.

I don't see this commit pushed up as part of what's in 4.8 so far. Any chance
it's going to go in later in the merge window?  I'm just hoping to trim down the
task-isolation series by being able to drop this patch from its next iteration... :-)

Thanks!

[1] https://lkml.kernel.org/r/1459877922-15512-13-git-send-email-cmetcalf at mellanox.com

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com

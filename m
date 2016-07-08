From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Fri, 8 Jul 2016 12:11:56 -0400
Subject: [PATCH]: arm64: factor work_pending state machine to C
In-Reply-To: <20160708154901.GF6493@arm.com>
References: <1459877922-15512-1-git-send-email-cmetcalf@mellanox.com>
 <1459877922-15512-13-git-send-email-cmetcalf@mellanox.com>
 <e19d6de0-c754-d53b-3420-16d460a4cb33@mellanox.com>
 <20160708154901.GF6493@arm.com>
Message-ID: <6e652143-841d-a73d-0184-a7be417cecd5@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/8/2016 11:49 AM, Will Deacon wrote:
> Hi Chris,
>
> On Fri, Jul 08, 2016 at 11:43:50AM -0400, Chris Metcalf wrote:
>> Ping!
>>
>> I am hopeful that this patch [1] can be picked up for the 4.8 merge window
>> in the arm64 tree.  As I mentioned in my last patch series that included
>> this patch [2], I'm hopeful that this version addresses the performance
>> issues that were seen with Mark's original patch.  This version tests the
>> TIF flags prior to calling out to the loop in C code.
> I still need to get round to measuring that again. This might also
> conflict with a late fix I just sent for 4.7.
>
> Is your task isolation series all ready apart from this? It seems like
> there's still discussion over there.

No, discussion of task isolation is still ongoing.  Alas :-)

I'm trying to pick off low-hanging fruit where possible - I think this refactoring
is independently good for arm64 regardless of whether task isolation makes it in for
the 4.8 merge window or not, so figured I'd break it out.

If you get a chance to remeasure, that will be great.  Thanks!

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com

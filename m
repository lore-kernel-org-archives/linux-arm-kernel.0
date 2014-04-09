From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 09 Apr 2014 11:11:06 -0700
Subject: [PATCH] arm64: Add user_debug command line option
In-Reply-To: <20140409084101.GC13737@arm.com>
References: <1397007908-17993-1-git-send-email-lauraa@codeaurora.org>
 <20140409084101.GC13737@arm.com>
Message-ID: <53458D3A.8080806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/9/2014 1:41 AM, Catalin Marinas wrote:
> On Wed, Apr 09, 2014 at 02:45:08AM +0100, Laura Abbott wrote:
>> arm had a useful command line option to print out debug
>> information on user signals. This is somewhat like a more verbose
>> version of show_unhandled_signals. Add the user_debug command line
>> option to print out more information in a similar manner to
>> arm.
> 
> Is this because you want to print information for handled signals as
> well? What is the use case? (there are alternatives like ptrace as
> well).
> 

Yes. We've found user_debug to be helpful in correlating userspace
crashes to other events that are spewed in the system log. Example
from last week: userspace program crashes, bad page state and panic
happens soon after. Some kernel driver was not cleaning up after
itself properly after the crash. Without seeing the userspace crash
logs it would have been much more difficult to correlate the bad
page state to anything.

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 12 Apr 2018 18:38:39 -0400
Subject: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
In-Reply-To: <20180412215855.GB27802@saruman>
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman> <20180412215855.GB27802@saruman>
Message-ID: <33c9c074-e0a5-7552-9993-269cd85101aa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2018 5:58 PM, James Hogan wrote:
> On Thu, Apr 12, 2018 at 10:51:49PM +0100, James Hogan wrote:
>> On Tue, Apr 03, 2018 at 08:55:04AM -0400, Sinan Kaya wrote:
>>> While a barrier is present in writeX() function before the register write,
>>> a similar barrier is missing in the readX() function after the register
>>> read. This could allow memory accesses following readX() to observe
>>> stale data.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Both patches look like obvious improvements to me, so I'm happy to apply
>> to my fixes branch.
> 
> Though having said that, a comment to go with the rmb() (as suggested by
> checkpatch) to detail the situation we're concerned about would be nice
> to have.

I can send a new version. No worries. 

Functional correctness is more important at this moment. I can accommodate
any nice to haves.

> 
> Cheers
> James
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

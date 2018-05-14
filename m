From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Mon, 14 May 2018 09:10:42 -0500
Subject: [PATCH] edac: altera: Add Stratix10 SDRAM Uncorrectable Errors
In-Reply-To: <20180512103331.GC27593@pd.tnic>
References: <1526079610-5527-1-git-send-email-thor.thayer@linux.intel.com>
 <20180512103331.GC27593@pd.tnic>
Message-ID: <2a21f8e1-4376-c148-de33-f39778716d80@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2018 05:33 AM, Borislav Petkov wrote:
> On Fri, May 11, 2018 at 06:00:10PM -0500, thor.thayer at linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> On Stratix10, uncorrectable errors are routed to the SError
>> exception instead of the IRQ exceptions. In Stratix10,
>> uncorrectable SErrors must be treated as fatal and will cause
>> a panic.
>> Older Altera/Intel parts printed out a message for UE so do
>> that here using the notifier framework.
>>
>> Record the UE in sticky registers that retain the state
>> through a reset. Check these registers on probe and printout the
>> error on startup.
>>
>> Depends on previous patch:
>> commit 2a4ff60626b0 ("arm64: dts: stratix10: add sdram ecc")
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>>   drivers/edac/altera_edac.c | 67 +++++++++++++++++++++++++++++++++++++++-------
>>   drivers/edac/altera_edac.h |  8 +++++-
>>   2 files changed, 64 insertions(+), 11 deletions(-)
> 
> Ok, I think I have collected everything. Pls double-check me I haven't missed
> anything:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=for-next
> 
> Thx.
> 
Yes, You have the entire series (aside from DT that Dinh is taking). 
Thank you!

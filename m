From: anup.patel@broadcom.com (Anup Patel)
Date: Thu, 27 Jul 2017 10:28:57 +0530
Subject: [PATCH 4/6] dma: bcm-sba-raid: Break
 sba_process_deferred_requests() into two parts
In-Reply-To: <20170726171554.GK3053@localhost>
References: <1501047404-14456-1-git-send-email-anup.patel@broadcom.com>
 <1501047404-14456-5-git-send-email-anup.patel@broadcom.com>
 <20170726171554.GK3053@localhost>
Message-ID: <CAALAos9-RScL49BbtvwgWLkJ+uvhDFDFAmywQZQdbtXy+Ud+AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 10:45 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Jul 26, 2017 at 11:06:42AM +0530, Anup Patel wrote:
>> This patch breaks sba_process_deferred_requests() into two parts
>> sba_process_received_request() and _sba_process_pending_requests()
>> for readability.
>>
>> In addition,
>
> that should be a separate patch then... no?
>
>> we remove redundant SBA_REQUEST_STATE_RECEIVED state
>
> this should be one more...

OK, I will make this separate patch.

>
>> and ensure that all requests in a chained request should be freed
>> only after all have been received.
>
> and then this, right?

OK.

>
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  drivers/dma/bcm-sba-raid.c | 130 ++++++++++++++++-----------------------------
>>  1 file changed, 47 insertions(+), 83 deletions(-)
>>
>> diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
>> index db5e3db..b92c756 100644
>> --- a/drivers/dma/bcm-sba-raid.c
>> +++ b/drivers/dma/bcm-sba-raid.c
>> @@ -97,9 +97,8 @@ enum sba_request_flags {
>>       SBA_REQUEST_STATE_ALLOCED       = 0x002,
>>       SBA_REQUEST_STATE_PENDING       = 0x004,
>>       SBA_REQUEST_STATE_ACTIVE        = 0x008,
>> -     SBA_REQUEST_STATE_RECEIVED      = 0x010,
>> -     SBA_REQUEST_STATE_COMPLETED     = 0x020,
>> -     SBA_REQUEST_STATE_ABORTED       = 0x040,
>> +     SBA_REQUEST_STATE_COMPLETED     = 0x010,
>> +     SBA_REQUEST_STATE_ABORTED       = 0x020,
>
> so we changed this is patch 1, only to change it here. why....!!!!
>
> so let me stop here again and repeat myself again about splitting stuff up,
> blah blah, good patches, blah blah, read the Documentation blah blah.. and
> hope someones listening :(

OK, I will address your comments.

Regards,
Anup

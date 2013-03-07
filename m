From: davidb@codeaurora.org (David Brown)
Date: Wed, 06 Mar 2013 21:21:54 -0800
Subject: [PATCH 3/6] ssbi: Fix exit mismatch in remove function
In-Reply-To: <20130307013042.GB2910@kroah.com> (Greg Kroah-Hartman's message
 of "Thu, 7 Mar 2013 09:30:42 +0800")
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1362616187-21089-4-git-send-email-davidb@codeaurora.org>
 <20130307013042.GB2910@kroah.com>
Message-ID: <8yaobevvl71.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Wed, Mar 06, 2013 at 04:29:44PM -0800, David Brown wrote:
>> msm_ssbi_remove is referenced with __exit_p, but not declared with
>> __exit.  This causes a warning when the driver is not built as a
>> module:
>> 
>> drivers/ssbi/ssbi.c:341:23: warning: 'msm_ssbi_remove' defined but not used [-Wunused-function]
>> 
>> Fix by adding the __exit declaration to the function.
>> 
>> Signed-off-by: David Brown <davidb@codeaurora.org>
>> ---
>>  drivers/ssbi/ssbi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/ssbi/ssbi.c b/drivers/ssbi/ssbi.c
>> index 86d8416..4d503da 100644
>> --- a/drivers/ssbi/ssbi.c
>> +++ b/drivers/ssbi/ssbi.c
>> @@ -337,7 +337,7 @@ err_get_mem_res:
>>  	return ret;
>>  }
>>  
>> -static int msm_ssbi_remove(struct platform_device *pdev)
>> +static int __exit msm_ssbi_remove(struct platform_device *pdev)
>
> No, remove the __exit_p marking instead, unless you want your kernel to
> be oopsed :)

Thanks.  Oopsing is not fun.

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

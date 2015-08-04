From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 4 Aug 2015 15:58:41 -0500
Subject: [PATCH v2 3/3] soc: ti: Add wkup_m3_ipc driver
In-Reply-To: <20150720061559.GX17550@atomide.com>
References: <1437166592-25378-1-git-send-email-d-gerlach@ti.com>
 <1437166592-25378-4-git-send-email-d-gerlach@ti.com>
 <20150720061559.GX17550@atomide.com>
Message-ID: <55C12781.1070007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2015 01:16 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [150717 13:59]:
>> +
>> +/* Public functions */
> ...
>> +EXPORT_SYMBOL_GPL(wkup_m3_set_mem_type);
>> +EXPORT_SYMBOL_GPL(wkup_m3_set_resume_address);
>> +EXPORT_SYMBOL_GPL(wkup_m3_request_pm_status);
>> +EXPORT_SYMBOL_GPL(wkup_m3_prepare_low_power);
>> +EXPORT_SYMBOL_GPL(wkup_m3_finish_low_power);
>
> I think you can avoid exporting these SoC specific functions
> by just exporting wkup_m3_request() and wkup_m3_free() type
> functions with a data structure containing the necessary
> function pointers.

Ok thanks for the comment, I can try that change out, I agree it 
probably isn't necessary to export so much.

Regards,
Dave

>
> Regards,
>
> Tony
>

From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 29 Aug 2017 10:09:49 -0600
Subject: [PATCH] fpga: make xlnx_pr_decoupler_br_ops const
In-Reply-To: <78e2ed1d-ea20-eb68-b6b4-d993a98984a6@xilinx.com>
References: <1503941531-17977-1-git-send-email-bhumirks@gmail.com>
 <78e2ed1d-ea20-eb68-b6b4-d993a98984a6@xilinx.com>
Message-ID: <CAAtXAHcf1bjyFg9XPZRmJS4Pw7=+P_E4TB-euJBSrj6ZGBSAig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 12:00 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 28.8.2017 19:32, Bhumika Goyal wrote:
>> Make this const as it is only passed to a const argument of the function
>> fpga_bridge_register.
>>
>> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>  drivers/fpga/xilinx-pr-decoupler.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
>> index e359930..0d77430 100644
>> --- a/drivers/fpga/xilinx-pr-decoupler.c
>> +++ b/drivers/fpga/xilinx-pr-decoupler.c
>> @@ -79,7 +79,7 @@ static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
>>       return !status;
>>  }
>>
>> -static struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
>> +static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
>>       .enable_set = xlnx_pr_decoupler_enable_set,
>>       .enable_show = xlnx_pr_decoupler_enable_show,
>>  };

Must've been a leftover from when I worked on integrating a simple
GPIO based one.
I'll have to rebase that and submit it.
>>
>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
>
> Thanks,
> Michal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Moritz

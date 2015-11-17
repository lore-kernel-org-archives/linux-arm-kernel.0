From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 17 Nov 2015 10:08:12 -0800
Subject: [PATCH] fpga: zynq-fpga: Avoid hammering clk_{enable/disable}.
In-Reply-To: <564B6988.5020104@xilinx.com>
References: <1447780317-27758-1-git-send-email-moritz.fischer@ettus.com>
 <564B6988.5020104@xilinx.com>
Message-ID: <CAAtXAHfLZ1DTtp5sMJAn=G26dEv7np-tN_fKPGxdFsO0uPq+eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michal,

On Tue, Nov 17, 2015 at 9:53 AM, Michal Simek <michal.simek@xilinx.com> wrote:

>> +#ifdef CONFIG_PM
>
> remove this

Will do.
>
>> +static int zynq_fpga_runtime_suspend(struct device *dev)
>
> add __maybe_unused here

Will do.

>> +static int zynq_fpga_runtime_resume(struct device *dev)
>
> and here

Will do.

>> +}
>> +
>> +#endif
>
> and remove this.

Will do.

> Body has nothing specific what it is available only for CONFIG_PM that's
> why it should just work.

You're right. I'll resubmit once other people took another look. Not
high priority ;-)

Cheers,

Moritz

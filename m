From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 24 Sep 2018 16:45:58 +0200
Subject: [PATCH 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
In-Reply-To: <20180922142838.6bde6b9c@windsurf> (Thomas Petazzoni's message of
 "Sat, 22 Sep 2018 14:28:38 +0200")
References: <20180921154326.10776-1-gregory.clement@bootlin.com>
 <20180921154326.10776-2-gregory.clement@bootlin.com>
 <20180922142838.6bde6b9c@windsurf>
Message-ID: <87lg7reyxl.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On sam., sept. 22 2018, Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

[...]
>> +{
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		struct device *cpu_dev = get_cpu_device(cpu);
>> +		struct clk *clk = clk_get(cpu_dev, 0);
>> +
>> +		if (IS_ERR(clk))
>> +			dev_warn(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
>> +
>> +		if (clk_is_match(clk, cur_clk))
>
> Is it OK to call clk_is_match() is clk being an error ?
>

yes the function check the validity of the pointers.

[...]

> Once again, this is not a full review, I haven't reviewed the logic of
> the driver itself, just a few obvious things I noticed.

Thanks for this first level review, I took into account all your remarks.

Gregory


>
> Best regards,
>
> Thomas Petazzoni
> -- 
> Thomas Petazzoni, CTO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

From: b32955@freescale.com (Huang Shijie)
Date: Fri, 29 Apr 2011 09:42:20 +0800
Subject: [PATCH v6 1/3] MTD : add the common code for GPMI controller
	driver
In-Reply-To: <20110428192017.GO17290@n2100.arm.linux.org.uk>
References: <1303267549-18377-1-git-send-email-b32955@freescale.com>
	<1303267549-18377-2-git-send-email-b32955@freescale.com>
	<20110428192017.GO17290@n2100.arm.linux.org.uk>
Message-ID: <4DBA177C.50805@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi:
> On Wed, Apr 20, 2011 at 10:45:47AM +0800, Huang Shijie wrote:
>> +static inline int acquire_clock(struct gpmi_nfc_data *this, struct clk **clock)
>> +{
>> +	struct clk *c;
>> +
>> +	c = clk_get(&this->pdev->dev, NULL);
>> +	if (IS_ERR(c)) {
>> +		log("Can't own clock");
>> +		return PTR_ERR(c);
>> +	}
>> +	*clock = c;
>> +	return 0;
>> +}
>> +
>> +static void release_clock(struct gpmi_nfc_data *this, struct clk *clock)
>> +{
>> +	clk_put(clock);
>> +}
> Do you really need to abstract like this?  It appears to just complicate
> the code unnecessarily.
>
ok, I can remove the two functions.
>> +#define log(a, ...) printk(KERN_INFO "[ %s : %.3d ] "a"\n", \
>> +			__func__, __LINE__,  ## __VA_ARGS__)
> Also, I don't like this log() function.  You can do the same with:
>
> #define pr_fmt(fmt) "[ %s : %.3d ] " fmt, __func__, __LINE__
>
> and use pr_info() instead.  Note that it's generally frowned upon to
> hide the \n inside the pr_fmt().
>
ok, I will change it.

Thanks .


Best Regards
Huang Shijie

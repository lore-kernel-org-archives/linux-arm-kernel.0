From: majun258@huawei.com (majun (F))
Date: Sat, 30 May 2015 14:10:08 +0800
Subject: [PATCH 1/4]:Add mbigen driver to support mbigen interrupt
 controller
In-Reply-To: <1432964283.2984.9.camel@perches.com>
References: <55692C29.60003@huawei.com> <1432964283.2984.9.camel@perches.com>
Message-ID: <55695440.4050509@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe Perches:
	Thanks for you advice.
I will fixed it in next version

? 2015/5/30 13:38, Joe Perches ??:
> On Sat, 2015-05-30 at 11:19 +0800, majun (F) wrote:
>> This patch contains the mbigen device driver.
> 
> Trivial notes:
> 
> Please use scripts/checkpatch.pl on your patches and see
> if you want to correct any of the messages it produces.
> 
>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> 
> You could add
> #define pr_fmt(fmt) "mbigen: " fmt
> before any of the #includes so that all of the
> pr_<level>(fmt, ...) uses are prefixed with "mbigen: "
> 
>> +int mbi_parse_irqs(struct device *dev, struct mbi_ops *ops)
>> +{
>> +	pr_warn("%s:this function not use now\n", __func__);
> 
> Maybe pr_warn_once()
> 
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL(mbi_parse_irqs);
>> +
>> +void mbi_free_irqs(struct device *dev, unsigned int virq, unsigned int nvec)
>> +{
>> +	pr_warn("%s:this function not use now\n", __func__);
> 
> pr_warn_once()?
> 
>> +static struct mbigen *mbigen_get_device(struct mbigen_chip *chip,
>> +										unsigned int nid)
>> +{
>> +	struct mbigen *tmp, *mbigen;
>> +	bool found = false;
>> +
>> +	if (nid >= MG_NR) {
>> +		pr_warn("MBIGEN: Device ID exceeds max number!\n");
> 
> So this wouldn't need a "MBIGEN: " prefix
> 
> etc...
> 
> 
> .
> 

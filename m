From: Josh.wu@atmel.com (Wu, Josh)
Date: Tue, 6 Sep 2011 11:29:50 +0800
Subject: [PATCH] [media] at91: add code to initialize and manage
	theISI_MCK for Atmel ISI driver.
In-Reply-To: <20110905103339.GG6619@n2100.arm.linux.org.uk>
References: <1315218593-10822-1-git-send-email-josh.wu@atmel.com>
	<20110905103339.GG6619@n2100.arm.linux.org.uk>
Message-ID: <4C79549CB6F772498162A641D92D532802A09D8F@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell

On 09/05/2011 6:34 PM Russell King wrote:

> On Mon, Sep 05, 2011 at 06:29:53PM +0800, Josh Wu wrote:
>> +static int initialize_mck(struct atmel_isi *isi,
>> +			struct isi_platform_data *pdata)
>> +{
>> +	int ret;
>> +	struct clk *pck_parent;
>> +
>> +	if (!strlen(pdata->pck_name) || !strlen(pdata->pck_parent_name))
>> +		return -EINVAL;
>> +
>> +	/* ISI_MCK is provided by PCK clock */
>> +	isi->mck = clk_get(NULL, pdata->pck_name);

> No, this is not how you use the clk API.  You do not pass clock names via
> platform data.

> You pass clk_get() the struct device.  You then pass clk_get() a
> _connection id_ on that _device_ if you have more than one struct clk
> associated with the _device_.  You then use clkdev to associate the
> struct device plus the connection id with the appropriate struct clk.

I think I missed the struct device when called clk_get(). I will fix it in v2 version.

Best Regards,
Josh Wu

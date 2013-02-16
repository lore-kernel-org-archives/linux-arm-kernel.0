From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 16 Feb 2013 09:47:40 +0100
Subject: [PATCH v2] clk: Add axi-clkgen driver
In-Reply-To: <20130216025234.11471.8029@quantum>
References: <1358949892-19986-1-git-send-email-lars@metafoo.de>
 <20130216025234.11471.8029@quantum>
Message-ID: <511F47AC.102@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2013 03:52 AM, Mike Turquette wrote:
> Quoting Lars-Peter Clausen (2013-01-23 06:04:52)
>> +static const struct of_device_id axi_clkgen_ids[] = {
>> +       { .compatible = "adi,axi-clkgen-1.00.a" },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, axi_clkgen_ids);
> 
> This method is deprecated.  Can you convert over to the newer
> of_clk_init method?  See:
> 
> http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=commit;h=f2f6c2556dcc432e50003bc8fa4d62d95906f149

Hi,

I'm not sure this makes sense here. That would mean completely bypassing the
device driver model. And since this device is on a kind of external bus it may
or may not be present at the time of_clk_init() runs.

- Lars

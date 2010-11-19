From: cyril@ti.com (Cyril Chemparathy)
Date: Fri, 19 Nov 2010 12:11:57 -0500
Subject: [PATCH v6 05/12] davinci: add spi devices on tnetv107x evm
In-Reply-To: <4CE6A516.402@mvista.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
	<1290182156-20104-6-git-send-email-cyril@ti.com>
	<4CE6A516.402@mvista.com>
Message-ID: <4CE6AFDD.50806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2010 11:25 AM, Sergei Shtylyov wrote:
[...]
>> +		ret = gpio_request(EVM_SPI_CS_GPIO, "spi chipsel");
> 
>     Why not just:
> 
> 		int ret = gpio_request(EVM_SPI_CS_GPIO, "spi chipsel");
> 
>     Also, and empty line after declaration wouldn't hurt.
> 
[...]
>> +	return gpio_set_value(gpio, cs ? 1 : 0);
> 
>     Why not do it right with gpio_direction_output() call?

Sure.  I might as well change to use gpio_request_one() while I'm at it.

If I get enough comments to warrant another revision of this series, I
will put in this change at the time.  Otherwise, I'd rather roll this in
with other patches on my pending list.  Is that ok?

Thanks for taking a look, Sergei.

Regards
- Cyril.

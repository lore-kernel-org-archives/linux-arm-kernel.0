From: preid@electromag.com.au (Phil Reid)
Date: Tue, 7 Nov 2017 09:02:50 +0800
Subject: [PATCH v5 4/7] i2c: designware: add i2c gpio recovery option
In-Reply-To: <1509984581.25007.47.camel@linux.intel.com>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
 <1509590430-11968-5-git-send-email-preid@electromag.com.au>
 <1509984581.25007.47.camel@linux.intel.com>
Message-ID: <a0265848-2496-d347-a40f-ce83e7dfd945@electromag.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/11/2017 00:09, Andy Shevchenko wrote:
> On Thu, 2017-11-02 at 10:40 +0800, Phil Reid wrote:
>> From: Tim Sander <tim@krieglstein.org>
>>
>> This patch contains much input from Phil Reid and has been tested
>> on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the
>> SCL and SDA GPIO's.
>>
>> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Shame on me, I totally forgot one important comment on all this.
> 
> How do we switch pinctrl back to the native function? Is it guaranteed
> by pinctrl framework and all underneath drivers?
> 
> 
G'day Andy,

That is a good question. I don't have an understanding of how the pinctrl
framework works with respect to requesting gpios.
My device (Intel / Altera Cyclone V SOC) doesn't have a pinctrl for the i2c / gpio mux as
yet. It's all setup by the bootloader and they don't expect you to change it.
I'm using two separate GPIO's "wired" to the i2c bus via the SOC FPGA for the recovery.
Tim was doing the same.

-- 
Regards
Phil Reid

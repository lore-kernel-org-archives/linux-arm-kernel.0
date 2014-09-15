From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 15 Sep 2014 16:06:42 +0300
Subject: [PATCH] spi: davinci: request cs_gpio's from probe
In-Reply-To: <20140913162858.GG7960@sirena.org.uk>
References: <1410533640-21469-1-git-send-email-grygorii.strashko@ti.com>
 <20140913162858.GG7960@sirena.org.uk>
Message-ID: <5416E462.7010406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2014 07:28 PM, Mark Brown wrote:
> On Fri, Sep 12, 2014 at 05:54:00PM +0300, Grygorii Strashko wrote:
> 
>>   static void davinci_spi_cleanup(struct spi_device *spi)
>>   {
>> -	if (spi->cs_gpio >= 0)
>> -		gpio_free(spi->cs_gpio);
>>   }
> 
> This function is now empty so should be removed.  I've applied for now
> but please send a followup fixing this.
> 

The function davinci_spi_cleanup() will be reused by following patch
"[PATCH v3] spi: davinci: add support for adding delay between word's transmissions"
http://www.spinics.net/lists/devicetree/msg49141.html

So, in broonie/spi.git/for-next it will not be empty.

Again, I've missed description of this dependency, sorry for that.

Regards,
-grygorii

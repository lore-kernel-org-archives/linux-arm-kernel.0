From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 02 Aug 2013 09:39:49 -0700
Subject: [PATCH v7] watchdog: Add MOXA ART watchdog driver
In-Reply-To: <20130802114159.GK2884@e106331-lin.cambridge.arm.com>
References: <1375098093-8975-1-git-send-email-jonas.jensen@gmail.com>
 <1375101228-10930-1-git-send-email-jonas.jensen@gmail.com>
 <20130802114159.GK2884@e106331-lin.cambridge.arm.com>
Message-ID: <51FBE0D5.3070007@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2013 04:41 AM, Mark Rutland wrote:
> On Mon, Jul 29, 2013 at 01:33:48PM +0100, Jonas Jensen wrote:
>> Add watchdog driver for MOXA ART SoCs.
>>
[ ... ]
>> +
>> +	err = watchdog_register_device(&moxart_wdt->dev);
>> +	if (unlikely(err))
>> +		return err;
>
> This is a probe path. Is the use of unlikely() really appropriate here?
> I suspect it doesn't make any appreciable difference, and should go.
>
Just wondering, for my education - why ? Is there s rule that unlikely()
shall not be used in the probe path ? If so, I would like to know it and
its reasoning to be able to apply it to my own reviews.

Thanks,
Guenter

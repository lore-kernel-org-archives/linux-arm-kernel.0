From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 28 Jun 2013 16:50:39 +0200
Subject: [PATCH 3/4] hwmon: Add a simple driver to read the MXS SoC
 temperature
In-Reply-To: <51CD9B19.90407@metafoo.de>
References: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372236673-20725-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20130626143927.GB31998@roeck-us.net> <20130627091732.GP5803@lukather>
 <20130627142758.GA5812@roeck-us.net> <51CC91E8.50605@free-electrons.com>
 <51CD9B19.90407@metafoo.de>
Message-ID: <51CDA2BF.5050501@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/06/2013 16:18, Lars-Peter Clausen wrote:
> On 06/27/2013 09:26 PM, Alexandre Belloni wrote:
>>
>> They are already registered as IIO_TEMP but only implement read_raw. Also,
>>
>> iio_hwmon_read_val() is using iio_read_channel_processed() and that will
>> basically only read one of the 2 channels. As I documented, you actually
>> need to read both channel 8 and channel 9 and then compute the value in
>> Kelvins. I'm not sure how you want me to do that in the current framework.
> What are these two channels actually measuring? Is the value of a single
> channel meaningful on it's own? If not it might make sense to update the IIO
> driver to just have one temperature channel.

It's not actually meaningful on its own. So, what you would do is expose
one iio channel for two ADC channels and do the computation in read_raw
? or read_processed ? Then using iio-hwon to export it. ?

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

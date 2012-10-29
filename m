From: x0148406@ti.com (Afzal Mohammed)
Date: Mon, 29 Oct 2012 13:33:35 +0530
Subject: [PATCH v4 3/5] rtc: omap: dt support
In-Reply-To: <5084523F.2070800@gmail.com>
References: <cover.1350633036.git.afzal@ti.com>
 <061c670b0a05570d7b83d8a8f105ee5b35583f7f.1350633036.git.afzal@ti.com>
 <5084523F.2070800@gmail.com>
Message-ID: <508E3857.6080109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Monday 22 October 2012 01:21 AM, Daniel Mack wrote:
> On 19.10.2012 11:59, Afzal Mohammed wrote:

>> +static const struct of_device_id omap_rtc_of_match[] = {
>> +	{	.compatible	= "ti,da830-rtc",
>> +		.data		=&omap_rtc_devtype[OMAP_RTC_DATA_DA830_IDX],

> Wouldn't it make sense to list all the compatible models here? The
> advantage of a compatible list is that we can name the models
> explicitly, or maybe at least "davinci-rtc". Is there any reason for
> this particular name?

Exact name followed by compatible models needs to be
specified in DT node only, right ? (when driver for the
first variant can handle it)

And when additional features of newer IP's has to be
leveraged, new entries can be added in the driver
match table.

First known variant of SoC for DT is da830 (exact name),
hence it was used.

Regards
Afzal

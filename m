From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 15:23:31 +0530
Subject: [PATCH 01/12] mtd: nand: davinci: store the core chipselect
 number in platform data
In-Reply-To: <3dccc5af-2df1-8374-e4e8-0a8b9ea1ae99@ti.com>
References: <20180430082453.8091-1-brgl@bgdev.pl>
 <20180430082453.8091-2-brgl@bgdev.pl>
 <3dccc5af-2df1-8374-e4e8-0a8b9ea1ae99@ti.com>
Message-ID: <8b7e4588-5a35-6c18-fe60-148d6ccf778c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 May 2018 02:55 PM, Sekhar Nori wrote:
> On Monday 30 April 2018 01:54 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We have the 'ti,davinci-chipselect' property in the device tree, but
>> when using platform data the driver silently uses the id field of
>> struct platform_device as the chipselect. This is confusing and we
>> almost broke the nand support again recently after converting the
>> platform to common clock framework (which changed the device id in the
>> clock lookup - the problem is gone now that we no longer acquire the
>> clock in the nand driver.
>>
>> This patch adds a new filed - core_chipsel - to the platform_data.
> 
> s/filed/field
> 
>> Subsequent patches will convert the platforms to using this new field.
> 
> Can you add a comment for this new field too, like how we have for most
> other fields?
> 
> Curious on what 'core' in core_chipsel means. Something to do with
> chip-select offset we have on DA850?

Looks like you may have just picked the terminology from DaVinci NAND
driver (introduced back in 2009). But in this context, it means the
0-indexed chip-select number that of the asynchronous memory interface
to which the NAND device is connected.

So, may be a comment here will suffice.

Thanks,
Sekhar

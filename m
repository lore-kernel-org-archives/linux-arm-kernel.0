From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 May 2018 15:42:36 +0530
Subject: [PATCH 00/12] mtd: nand: davinci: stop using pdev->id as
 chipselect
In-Reply-To: <20180430184751.574550cc@bbrezillon>
References: <20180430082453.8091-1-brgl@bgdev.pl>
 <20180430120930.4768a7cb@bbrezillon>
 <CAMRc=Mf2TKsuiudxPdEFStrstHH65jHb6JFJ0Ort9GvWDSo9bQ@mail.gmail.com>
 <20180430184751.574550cc@bbrezillon>
Message-ID: <859f5a71-d8c9-0a9c-f8e9-5194bf394960@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 April 2018 10:17 PM, Boris Brezillon wrote:
> On Mon, 30 Apr 2018 18:45:06 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
>> 2018-04-30 12:09 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
>>> Hi Bartosz,
>>>
>>> On Mon, 30 Apr 2018 10:24:41 +0200
>>> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>
>>>> We have the 'ti,davinci-chipselect' property in the device tree, but
>>>> when using platform data the driver silently uses the id field of
>>>> struct platform_device as the chipselect. This is confusing and we
>>>> almost broke the nand support again recently after converting the
>>>> platform to common clock framework (which changed the device id in the
>>>> clock lookup - the problem is gone now that we no longer acquire the
>>>> clock in the nand driver.
>>>>
>>>> This series adds a new field to davinci-nand platform data, then makes
>>>> all board use it and finally modifies the two drivers that make use of
>>>> it.
>>>>
>>>> Bartosz Golaszewski (12):
>>>>   mtd: nand: davinci: store the core chipselect number in platform data
>>>
>>> Raw NAND related patches (that is, everything that is not onenand or
>>> SPI NAND) should use the "mtd: rawnand: " prefix now. Other than that,
>>> I'm fine with the patch series, just let me know how you want to have it
>>> merged (through the MTD tree or the davinci tree).
>>>
>>> Thanks,
>>>
>>> Boris
>>
>> I think Sekhar could pick all those patches up for 4.18.
> 
> Okay, then I'd need an immutable branch containing these changes.

Boris, sure!

> 
>>
>> Sekhar - do you want me to resend the series with the commit message
>> changed as requested by Boris, or can you fix it when applying the
>> series?

Bartosz, No need to resend. I also wanted couple of changes on 1/12
which I can do locally too.

Thanks,
Sekhar

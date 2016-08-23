From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 23 Aug 2016 12:58:07 -0700
Subject: [PATCH v2 03/22] usb: ulpi: Support device discovery via device
 properties
In-Reply-To: <147043245520.26915.14153612182716236022@sboyd-linaro>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-4-stephen.boyd@linaro.org>
 <20160708090458.GB20485@shlinux2>
 <147043245520.26915.14153612182716236022@sboyd-linaro>
Message-ID: <CAJOFmgz=BSq=mmo4-2p-BZLbb=qeE-2paUcgCv0_vx72PTYfWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 5, 2016 at 2:27 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> Quoting Peter Chen (2016-07-08 02:04:58)
>> On Thu, Jul 07, 2016 at 03:20:54PM -0700, Stephen Boyd wrote:
>> > @@ -39,6 +42,10 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
>> >       struct ulpi *ulpi = to_ulpi_dev(dev);
>> >       const struct ulpi_device_id *id;
>> >
>> > +     /* Some ULPI devices don't have a product id so rely on OF match */
>> > +     if (ulpi->id.product == 0)
>> > +             return of_driver_match_device(dev, driver);
>> > +
>>
>> How about using vendor id? It can't be 0, but pid may be 0.
>> See: http://www.linux-usb.org/usb.ids
>
> Heikki suggested a product id of 0 would mean we need to use DT
> matching. Should it be changed to vendor id instead?

Any comments here?

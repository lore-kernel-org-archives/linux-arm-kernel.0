From: eliad@wizery.com (Eliad Peller)
Date: Wed, 11 Mar 2015 13:50:47 +0200
Subject: [PATCH v5 2/3] wl18xx: add basic device-tree support
In-Reply-To: <2121942.zIG9BfPsTV@wuerfel>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <1425915402-10012-2-git-send-email-eliad@wizery.com>
 <CABxcv=mygdT2Q+ByVKPx4+o_Oj9KSy=zVX9ng9yN25ivkfSn1A@mail.gmail.com>
 <2121942.zIG9BfPsTV@wuerfel>
Message-ID: <CAB3XZEcUC5H5b3rpFWQ_NG7fAT22x-MO9HajpD15WG6G=s7=NQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 11:51 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > +static void wlcore_del_platform_data(struct wl12xx_platform_data *pdata)
>> > +{
>> > +       kfree(pdata);
>> > +}
>> > +
>>
>> This function seems to be an unnecessary, why not just call kfree() directly?
>>
>> Or better, maybe the resource-managed devm_*() functions can be used
>> so the data doesn't have to be explicitly freed?
>
> As I said earlier, I think it would be best not to dynamically allocate anything
> here at all. As Eliad explained, the data is used by two different drivers:
> wl12xx and wl18xx, and only the latter is converted for now, but after the
> conversion, it should not need the platform data structure any more, only
> the irq number that gets passed in from DT.
>
sure, i'll try taking care of it (probably with additional patch after
the conversion)

Eliad.

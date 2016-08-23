From: nm@ti.com (Nishanth Menon)
Date: Tue, 23 Aug 2016 13:38:14 -0500
Subject: [PATCH 2/5] firmware: Add basic support for TI System Control
 Interface (TI-SCI) protocol
In-Reply-To: <5d03a04f-9184-10e4-43c9-8834e8a39545@ti.com>
References: <20160819225159.10758-1-nm@ti.com>
 <20160819225159.10758-3-nm@ti.com>
 <5d03a04f-9184-10e4-43c9-8834e8a39545@ti.com>
Message-ID: <CAGo_u6oAU-4Gab2H5S6mRET8AoUMc+wGHofnK3BaZQzR-340JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2016 at 11:20 AM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
[...]

>> +
>> +static int ti_sci_remove(struct platform_device *pdev)
>> +{
>> +     struct ti_sci_info *info;
>> +     int ret = 0;
>> +
>> +     info = platform_get_drvdata(pdev);
>> +
>> +     mutex_lock(&ti_sci_list_mutex);
>> +     if (info->users)
>> +             ret = -EBUSY;
>> +     else
>> +             list_del(&info->node);
>> +     mutex_unlock(&ti_sci_list_mutex);
>
> shouldn't the mbox channels be freed in remove?
>
> mbox_free_channel(info->chan_tx);
> mbox_free_channel(info->chan_rx);

Uggh.. yes.. my bad. thanks for catching this. will fix with a v2 next
week if there are no further comments.

--
Regards,
NIshanth Menon

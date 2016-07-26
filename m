From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Jul 2016 10:24:48 +0200
Subject: [PATCH v3 1/4] hwmon: iio_hwmon: delay probing with late_initcall
In-Reply-To: <209942367.uny0GxrY2s@ws-stein>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-2-git-send-email-quentin.schulz@free-electrons.com>
 <209942367.uny0GxrY2s@ws-stein>
Message-ID: <10d14cc4-26f1-8f2d-2997-3b2bc323c40e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/2016 10:21, Alexander Stein wrote:
> On Tuesday 26 July 2016 09:43:44, Quentin Schulz wrote:
>> iio_channel_get_all returns -ENODEV when it cannot find either phandles and
>> properties in the Device Tree or channels whose consumer_dev_name matches
>> iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
>> which might be probed after iio_hwmon.
> 
> Would it work if iio_channel_get_all returning ENODEV is used for returning 
> EPROBE_DEFER in iio_channel_get_all? Using late initcalls for driver/device 
> dependencies seems not right for me at this place.

Then what if the iio_channel_get_all is called outside of the probe of a
driver? We'll have to change the error code, things we are apparently
trying to avoid (see v2 patches' discussions).

Thanks,
Quentin

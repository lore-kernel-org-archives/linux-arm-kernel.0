From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 20 Jul 2015 08:37:01 +0200
Subject: [PATCH V4 RFC 0/3] nvmem: add ocotp support for i.MX23 and i.MX28
In-Reply-To: <201507200007.30100.marex@denx.de>
References: <1437343499-16422-1-git-send-email-stefan.wahren@i2se.com>
 <201507200007.30100.marex@denx.de>
Message-ID: <55AC970D.6090707@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Am 20.07.2015 um 00:07 schrieb Marek Vasut:
> On Monday, July 20, 2015 at 12:04:56 AM, Stefan Wahren wrote:
>> This patch series brings read-only support for the On-Chip OTP cells
>> in the i.MX23 and i.MX28 processor.
>>
>> It has been a long time since V3 of this series [1]. The last version has
>> been rejected because there was no standard interface to the OTP data. So
>> this version bases on V7 of the new NVMEM framework [2] which required a
>> nearly complete rewrite of the driver.
>>
>> [1] -
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/295228.
>> html [2] -
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355652.htm
>> l
> Are you sure you even want this support in kernel ?

definitely. But only read-only support make sense. Please believe me, i
didn't wait since last year for the NVMEM framework just for fun.

> Isn't it enough to have
> this in some manufacturing-time mutated bootloader to program the OTP once
> and never touch it again ?

No, our products uses a previous version of this patch series to set the
MAC address of a network interface from OTP data. I also get some
feedback from other users that they are happy about this driver.

Regards
Stefan

>
> Best regards,
> Marek Vasut

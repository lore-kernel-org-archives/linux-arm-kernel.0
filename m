From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 20 Jul 2015 08:45:21 +0200
Subject: [PATCH V4 RFC 2/3] nvmem: add driver for ocotp in i.MX23 and
 i.MX28
In-Reply-To: <201507200012.13608.marex@denx.de>
References: <1437343499-16422-1-git-send-email-stefan.wahren@i2se.com>
 <1437343499-16422-3-git-send-email-stefan.wahren@i2se.com>
 <201507200012.13608.marex@denx.de>
Message-ID: <55AC9901.1040402@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Am 20.07.2015 um 00:12 schrieb Marek Vasut:
> On Monday, July 20, 2015 at 12:04:58 AM, Stefan Wahren wrote:
>> This patch brings read-only support for the On-Chip OTP cells
>> in the i.MX23 and i.MX28 processor. The driver implements the
>> new NVMEM provider API.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> How come this driver isn't doing any manipulation with the VDDIO
> voltage -- or did I miss that? I seem to remember that the VDDIO
> had to be lowered to 2.8V before the fuses could be programmed
> and restored to 3.3V afterward. See for example recent mainline
> u-boot, drivers/misc/mxs_ocotp.c .

Why should the driver implement VDDIO manipulation when there is only
read-only support for the OTP bits? There is no ambition to implement
write support. Maybe i should clarify that in the comments.

Btw i'm on your side that because programming the OTP from userspace is
to dangerous.

Best regards
Stefan

>
> Best regards,
> Marek Vasut
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

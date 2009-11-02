From: thomas.ab@samsung.com (Thomas Abraham)
Date: Mon, 2 Nov 2009 15:18:00 +0900
Subject: [PATCH 6/7] S3C6410: Add platform data for S3C IDE controller
	driver
In-Reply-To: <20091101130707.GJ8096@trinity.fluff.org>
References: <1257051536-8170-1-git-send-email-thomas.ab@samsung.com>
	<20091101130707.GJ8096@trinity.fluff.org>
Message-ID: <84c135f50911012218o7142ff23y571517d8e96a6734@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 1, 2009 at 10:07 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Sun, Nov 01, 2009 at 01:58:56PM +0900, Thomas Abraham wrote:
>> This patch adds platform data for S3C IDE controller driver in
>> S3C6410 platform.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>> ?arch/arm/mach-s3c6410/mach-smdk6410.c | ? ?8 +++++++-
>> ?1 files changed, 7 insertions(+), 1 deletions(-)
>> -
>> +#ifdef CONFIG_BLK_DEV_IDE_S3C
>> + ? ? &s3c_device_cfcon,
>> +#endif
>> ? ? ? &smdk6410_smsc911x,
>> ?};
>
> Firstly, doing stuff if the driver is enabled or not is not a good idea,
> as it means re-installing the kernel if you then go and build the driver
> as a module at a later date.
>
> Two, since I guess that the IDE gpio setup should be the same across all
> s3c6410 based systems, then you should look at supplying a standard
> platform data that the board can use instead of having to duplicate this
> across all the boards.
>

Ok. I will remove the conditional compilation and move the platform
data from SMDK board file. Since the IDE driver is not accepted, these
patches will be updated and resent again with the libata based driver.

Thanks Ben for reviewing the patches.

Thomas.

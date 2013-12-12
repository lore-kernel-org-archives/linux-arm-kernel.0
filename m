From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 12 Dec 2013 08:20:17 +0530
Subject: [PATCH 5/5] ARM: dts: Setup the interrupt parent for max77686
In-Reply-To: <CAD=FV=Vkobnvk1tic5eLkoXzniqRYFM4BhWkW+_7AL25Hd9iwQ@mail.gmail.com>
References: <1386763029-8516-1-git-send-email-a.kesavan@samsung.com>
 <1386763029-8516-6-git-send-email-a.kesavan@samsung.com>
 <CAD=FV=Vkobnvk1tic5eLkoXzniqRYFM4BhWkW+_7AL25Hd9iwQ@mail.gmail.com>
Message-ID: <CAM4voambaGq=r6HfHhXrsF_7sE0Z2Op+OLWqZOmhL6uvfr9zuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Thu, Dec 12, 2013 at 5:27 AM, Doug Anderson <dianders@chromium.org> wrote:
> Abhliash,
>
> On Wed, Dec 11, 2013 at 3:57 AM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
>> Fix the following warning message:
>> [ 2921.671238] WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:399 irq_create_mapping+0xe4/0xfc()
>> [ 2921.679907] irq_create_mapping(, b) called with NULL domain
>> [ 2921.685462] Modules linked in:
>> [ 2921.688498] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc1-00026-g36cc776 #67
>> [ 2921.696154] [<c0013c80>] (unwind_backtrace+0x0/0xf8) from [<c00110cc>] (show_stack+0x10/0x14)
>> [ 2921.704654] [<c00110cc>] (show_stack+0x10/0x14) from [<c03779fc>] (dump_stack+0x64/0xa4)
>> [ 2921.712725] [<c03779fc>] (dump_stack+0x64/0xa4) from [<c001c830>] (warn_slowpath_common+0x64/0x84)
>> [ 2921.721663] [<c001c830>] (warn_slowpath_common+0x64/0x84) from [<c001c8e4>] (warn_slowpath_fmt+0x30/0x40)
>> [ 2921.731210] [<c001c8e4>] (warn_slowpath_fmt+0x30/0x40) from [<c005a564>] (irq_create_mapping+0xe4/0xfc)
>> [ 2921.740590] [<c005a564>] (irq_create_mapping+0xe4/0xfc) from [<c029c85c>] (max77686_rtc_probe+0x110/0x21c)
>> [ 2921.750221] [<c029c85c>] (max77686_rtc_probe+0x110/0x21c) from [<c02253a8>] (platform_drv_probe+0x18/0x48)
>>
>> Also setup the default state of the max77686 irq line.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>>  arch/arm/boot/dts/cros5250-common.dtsi |   11 +++++++++++
>>  1 file changed, 11 insertions(+)
>
> Thank you for sending stuff upstream, but I'm afraid this patch has
> already landed:
>
> c61248a ARM: dts: Add max77686 RTC interrupt to cros5250-common
>
> My patch matches yours but also includes the "wakeup-source" property.

I was working on Kgene's for-next; I do see your patch in linux-next.

Regards,
Abhilash

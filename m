From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 18 May 2010 16:01:58 +0900
Subject: [PATCH 1/9] ARM: S5PV210: Add audio platform devices
In-Reply-To: <20100518053915.GO27571@trinity.fluff.org>
References: <1274159402-19265-1-git-send-email-jassi.brar@samsung.com>
	<1274159414-19297-1-git-send-email-jassi.brar@samsung.com>
	<20100518052419.GM27571@trinity.fluff.org>
	<AANLkTinKcpaxhThIkUXCNgrYoXSaZUGhxkTe1u8Px6QJ@mail.gmail.com>
	<20100518053915.GO27571@trinity.fluff.org>
Message-ID: <AANLkTin1PUUrhNRQHAjJu3mvoaLkEymOVlAgFmUztHkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 2:39 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Tue, May 18, 2010 at 02:34:21PM +0900, Jassi Brar wrote:
>> On Tue, May 18, 2010 at 2:24 PM, Ben Dooks <ben-linux@fluff.org> wrote:
>> > On Tue, May 18, 2010 at 02:10:14PM +0900, Jassi Brar wrote:
>>
>> .....
>>
>> >> +struct platform_device s5pv210_device_iis0 = {
>> >> + ? ? .name ? ? ? ? ? ? = "s3c64xx-iis-v4",
>> >> + ? ? .id ? ? ? ? ? ? ? = -1,
>> >> + ? ? .num_resources ? ?= ARRAY_SIZE(s5pv210_iis0_resource),
>> >> + ? ? .resource ? ? ? ? = s5pv210_iis0_resource,
>> >> + ? ? .dev = {
>> >> + ? ? ? ? ? ? .platform_data = &s3c_i2s_pdata,
>> >> + ? ? },
>> >> +}; EXPORT_SYMBOL(s5pv210_device_iis0);
>> >
>> > do we really need to be exporting these devices like this,
>> > how much is needed otuside of machine support?
>> Not used except by machine code. Every platform device of
>> Samsung has been declared that way and I just don't wanna
>> stick my neck out where I can do without :)
>
> not all of them have, and i'll probably go around finding
> and culling any more as soon as possible.
Ok. Thanks.

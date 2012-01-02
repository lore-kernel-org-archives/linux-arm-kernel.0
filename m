From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 2 Jan 2012 23:21:46 +0530
Subject: [RFC][PATCH 1/4] lcd: platform-lcd: Eliminate need for platform
 data
In-Reply-To: <20120102115959.GG2899@opensource.wolfsonmicro.com>
References: <1325483675-21908-1-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-2-git-send-email-thomas.abraham@linaro.org>
 <20120102115959.GG2899@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwQrfp6R=kSzXr6y0unDk9FtNxoy3Lt5QabdNMg9Qux=bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2 January 2012 17:29, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jan 02, 2012 at 11:24:32AM +0530, Thomas Abraham wrote:
>
>> @@ -10,12 +10,3 @@
>> ? * published by the Free Software Foundation.
>> ? *
>> ?*/
>> -
>> -struct plat_lcd_data;
>> -struct fb_info;
>> -
>> -struct plat_lcd_data {
>> - ? ? void ? ?(*set_power)(struct plat_lcd_data *, unsigned int power);
>> - ? ? int ? ? (*match_fb)(struct plat_lcd_data *, struct fb_info *);
>> -};
>
> This is going to break all existing users as it will stop them compiling
> - they'd either need to be converted en masse to the new style as part
> of the commit doing this or the driver would need to support both
> platform data and new style configuration simultaneously.

Yes, it is true that it will break other users and is mentioned it in
the cover letter of this patchset.

Your point on maintaining support for both old and new formats is
helpful. But I am not sure if maintaining support for both formats is
the right thing to do. As most of the ARM platforms will switch to
using dt, maybe converting all of them to new format would be better.
I will try doing this and prepare a patch.

Thanks,
Thomas.

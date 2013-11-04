From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 04 Nov 2013 09:20:08 +0900
Subject: [PATCHv4] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <20131101095754.GJ27864@ulmo.nvidia.com>
References: <20131019104555.GI18477@ns203013.ovh.net>
 <2730370.0UKsY9Ox0H@avalon> <20131024110524.GB11296@ulmo.nvidia.com>
 <1389386.JnbumUe76M@avalon> <003701ced693$2f856150$8e9023f0$%han@samsung.com>
 <20131101095754.GJ27864@ulmo.nvidia.com>
Message-ID: <004101ced8f3$9e4e7ec0$daeb7c40$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 01, 2013 6:58 PM, Thierry Reding wrote:
> On Fri, Nov 01, 2013 at 08:44:48AM +0900, Jingoo Han wrote:
>> On Friday, October 25, 2013 10:58 PM, Laurent Pinchart wrote:
>>> On Thursday 24 October 2013 13:05:25 Thierry Reding wrote:

[....]

>>>> Or is there still a reason to have more than a single bit for backlight
>>>> state? I don't know any hardware that actually makes a difference
>>>> between FB_BLANK_NORMAL, FB_BLANK_VSYNC_SUSPEND, FB_BLANK_HSYNC_SUSPEND
>>>> or FB_BLANK_POWERDOWN.
>>
>> On Exynos side, I have never seen that FB_BLANK_VSYNC_SUSPEND,
>> FB_BLANK_HSYNC_SUSPEND are used for controlling display panels or
>> Display controllers.
>>
>> However, I heard that FB_BLANK_VSYNC_SUSPEND, FB_BLANK_HSYNC_SUSPEND are
>> used for some monitors.
> 
> I think that those may make sense in the context of fbdev, and looking
> at some fbdev drivers seems to substantiate that.
> 
> However, I don't think backlights have any such capability. I mean they
> are either on or off, right? There's no such thing as partially off, or
> partially on. How would a backlight behave differently if the panel was
> in HSYNC suspend mode or VSYNC suspend mode?

Hi Thierry Reding.

I agree with you.
In the case of backlight, there is no need that a backlight behaves
differently in HSYNC suspend mode or VSYNC suspend mode.

Best regards,
Jingoo Han

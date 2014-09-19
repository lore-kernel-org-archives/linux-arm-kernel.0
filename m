From: joe@perches.com (Joe Perches)
Date: Fri, 19 Sep 2014 12:52:27 -0700
Subject: [PATCH v10 5/6] rtc: max77686: Use ffs() to calculate tm_wday
In-Reply-To: <541C838B.7070207@collabora.co.uk>
References: <1411122377-10426-1-git-send-email-javier.martinez@collabora.co.uk>
 <1411122377-10426-6-git-send-email-javier.martinez@collabora.co.uk>
 <1411137561.24444.5.camel@joe-AO725> <541C838B.7070207@collabora.co.uk>
Message-ID: <1411156347.24444.31.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-09-19 at 21:27 +0200, Javier Martinez Canillas wrote:
> Hello Joe,

Hello Javier.

> On 09/19/2014 04:39 PM, Joe Perches wrote:
> > On Fri, 2014-09-19 at 12:26 +0200, Javier Martinez Canillas wrote:
> >> The function max77686_rtc_calculate_wday() is used to
> >> calculate the day of the week to be filled in struct
> >> rtc_time but that function only calculates the number
> >> of bits shifted. So the ffs() function can be used to
> >> find the first bit set instead of a special function.
> > 
> > This isn't the same logic.  Perhaps you want fls.
> >
> 
> Right, the removed function has the same logic than fls() - 1 but the value
> stored in data[RTC_WEEKDAY] is:
> 
> data[RTC_WEEKDAY] = 1 << tm->tm_wday;
> 
> so for this particular case, it doesn't matter since ffs() == fls() always.

I didn't look that far.

I just wanted to show that the logic wasn't the same.

Perhaps you can specify that ffs==fls in the changelog.

From: carlo.caione@gmail.com (Carlo Caione)
Date: Fri, 15 Nov 2013 23:50:56 +0100
Subject: [PATCH v3 1/2] ARM: sun4i/sun7i: RTC driver
In-Reply-To: <20131106141357.GQ26440@lukather>
References: <1383172738-8206-1-git-send-email-carlo.caione@gmail.com>
 <20131106141357.GQ26440@lukather>
Message-ID: <CAOQ7t2a=KdNb-4_E_PRP53yYPiNmKzRN69Urg8EZ=4JE-6-Mig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 3:13 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Carlo,

Hi Maxime,
A couple of points for the incoming v4

>> +static int sunxi_rtc_settime(struct device *dev, struct rtc_time *rtc_tm)
>> +{
>> +     struct sunxi_rtc_dev *chip = dev_get_drvdata(dev);
>> +     u32 date = 0;
>> +     u32 time = 0;
>> +     int year;
>> +     int t;
>> +
>> +     year = rtc_tm->tm_year + 1900;
>
> So, that means that the A10 RTC starts a year 1900, and the A20 at
> year 2010? Why not just put those in your year_offset field directly?

1900 is the offset of the parameter tm_year with respect to the current year.
year_offset is used to make tm_year fit inside the limited range of
the year field of the SUNXI_RTC_YMD register.

>> +
>> +     /*
>> +      * wait about 70us to make sure the the time is really written into
>> +      * target
>> +      */
>> +     usleep_range(70, 100);
>
> Isn't the write operation supposed to be done already?

Yes, it is supposed to be, but this waiting was already present in the
original version of the driver by aw so I'll leave it in v4.

Best,

--
Carlo Caione

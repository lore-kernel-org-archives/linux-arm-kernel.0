From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 28 Aug 2017 17:50:52 +0200
Subject: [PATCH v2 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <d20fbc21-bd8f-c191-ed51-03487868e7b0@suse.de>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de>
 <20170827091301.wbuzxkh7opz4blrc@piout.net>
 <d20fbc21-bd8f-c191-ed51-03487868e7b0@suse.de>
Message-ID: <20170828155052.thythswlgcsfusay@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27/08/2017 at 13:30:59 +0200, Andreas F?rber wrote:
> Well, I found your rtc_year_days rather confusing and had to play with
> the arguments until I got it working as expected, so I wanted an inline
> function (or macro) as abstraction from my three callers.
> 
> Sadly the naming is rather confusing as I am looking for the number of
> days 365..366, whereas your rtc_year_days is meant to return 0..365 and
> I would just like to extract the 12th array element but need to counter
> the -1 subtraction. rtc_year_days(31, 11, year) + 1 is not intuitive
> either - reads like November (and ranges are not documented).
> 
> What about exporting a convenient rtc_days_in_year(year) from rtc-lib.c
> accessing the table directly without rtc_year_days detour? Alternatively
> an inline function in rtc.h to the same effect without the array?
> 

This could have been done but what you did in your v3 is fine too. It
will always be time to move that to the core later.

> Also despite is_leap_year() returning a bool || expression you keep
> using it as array index or integer to add. That assumes true == 1,
> whereas to my knowledge only false is guaranteed to be 0 and any
> non-zero value means true. So I'd expect the code to be like this:

sizeof(bool) (actually _Bool) is 1 so it can only be 0 or 1.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

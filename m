From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 5 Feb 2016 14:02:59 +0100
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half
 timeout panic support
In-Reply-To: <CADyBb7unAHEOMfruWS82RkHK6uwPAWCxUx9jqzSkiHU4LHDSeA@mail.gmail.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
 <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
 <56B2423B.1020109@codeaurora.org>
 <CADyBb7uULCn97ea19zH8dB4QX1QA8=AXL94d6gXgFxXM8haBNA@mail.gmail.com>
 <56B24642.8090105@codeaurora.org>
 <CADyBb7s_QeU=pYqN9G+5WMtx-L+=QC6uZR6N6ZWPOixnkHzPjw@mail.gmail.com>
 <56B24AB5.3070001@codeaurora.org>
 <CADyBb7usPpY=YLjecXce63zY5e1tniPLmNsVY=8CJHJsCqBgQw@mail.gmail.com>
 <56B2DEE4.7060901@roeck-us.net>
 <CADyBb7unAHEOMfruWS82RkHK6uwPAWCxUx9jqzSkiHU4LHDSeA@mail.gmail.com>
Message-ID: <20160205140259.72a33699@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 5 Feb 2016 17:51:52 +0800, Fu Wei wrote:

> OK, my thought is
> 
> if panic is enabled :
> |--------WOR-------WS0--------WOR-------WS1
> |------timeout------(panic)------timeout-----reset

I'm quite certainly missing something completely obvious here, but how
can you get the WS1 interrupt *after* raising a panic? Aren't all
interrupts disabled and the system fully halted once you get a panic(),
especially when raised from an interrupt handler? If that's the case,
how can the system continue to do things, such as receiving the WS1
interrupt and resetting ?

Again, I'm probably missing something obvious, but I'm interested to
understand the reasoning here.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

From: k@japko.eu (Krzysztof Adamski)
Date: Mon, 22 Feb 2016 09:00:42 +0100
Subject: [linux-sunxi] Re: [PATCH v3] Fix sun7i pin assignment for IRQ's
In-Reply-To: <4cf9dbe3-faa6-4729-87fd-0e7d9ce463b0@googlegroups.com>
References: <1456060845-20692-1-git-send-email-henry@nitronetworks.nl>
 <20160221171830.GD19169@lukather>
 <4cf9dbe3-faa6-4729-87fd-0e7d9ce463b0@googlegroups.com>
Message-ID: <20160222080041.GF18745@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 21, 2016 at 11:27:46AM -0800, Henry Paulissen wrote:
>
>Op zondag 21 februari 2016 18:18:37 UTC+1 schreef Maxime Ripard:
>
>>
>> Your commit log is going to need some work. Which bugs? What tests did
>> you make? Why are you making these changes while the datasheet says
>> otherwise?
>>
>
>Its a fix for a not yet existing bug. I was fiddling around with IRQ's and
>couldn't get them to work.
>I took a dumpster dive into it and found a shitload of contradicting
>manuals and datasheets.
>
>
>Take for example the A20 user manual:
>http://dl.linux-sunxi.org/A20/A20%20user%20manual%20v1.3%2020141010.pdf
>
>(pin PI14)
>Page 237: EINT26 is on mux *5* in the pin overview.
>Page 288: EINT26 is on mux *6* in the registers.
>
>Page 233: EINT12 is on pin PC19 mux6 in the pin overview.
>Page 236: EINT12 is on pin PH12 mux6 in the pin overview.
>Page 253: EINT12 is *not* on pin PC19 on the registers.
>Page 281: EINT12 is on pin PH12 mux6 in the registers.
>
>So manual may say otherwise, but I hope I have proven that the manual isn't
>to be trusted.
>
>My patch is based onto testing from both me and Andre (apritzel).
>He with a Banana PI M1 and me with a Cubietruck (both A20 soc).
>
>We did a basic test by connecting a pulsing signal to a port and configure
>kernel to use irq.
>
>e.g.
>echo pin# > /sys/class/gpio/export
>echo in > /sys/class/gpio/gpio#/direction
>echo rising > /sys/class/gpio/gpio#/edge
>
>and check on /proc/interrupts to see if a irq was attached and if it was
>receiving.
>
>Im not sure what andre his pulse source was, but mine was a 1pps coming
>from a gps.

That's quite clear to anybody reading this mailinglist but it won't be 
to anyone reading just commit message (and there will be many of them).  
You should try to put some of this into the commit message.

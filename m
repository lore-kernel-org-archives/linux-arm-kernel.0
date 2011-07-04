From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 04 Jul 2011 21:14:19 +0200
Subject: Future of S3C6410 platform
Message-ID: <2635745.FvrjgPkNLz@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

List,

I am writing to ask what is the planned future for the (now obsolete?) S3C6410 
platform. Is there any ongoing work on bringing more feature-complete support 
for it?

The platform is really far behind its newer friends and here is what bothers 
me most:
- missing basic features as NOHZ support
- buggy drivers (in mainline!, s3c-fb requesting irq before fully initializing 
driver data, same goes for the adc driver)
- totally broken usb gadget driver - I could not get it to work on my platform 
in any way (Samsung GT-i5700 phone; I am getting a Tiny6410 soon, so I will 
check whether it is not a board specific issue) without rewriting control 
endpoint handling code, not even mentioning about DMA support, which I still 
cannot get to work
- poor OneNAND support (mostly in terms of performance)
- no power domain support
- no support for advanced features of the chip (ie. functionality provided by 
old, and really _bad_, s3c modules)

I have already added NOHZ support, fixed fb and adc bugs, refactored control 
endpoint handling in udc driver (no DMA yet), done some improvement to OneNAND 
driver (still a big work in progress though, this is a topic for another 
message) and implemented power domain management + other minor changes/fixes. 

All of this is available in my tree at 
git://github.com/tom3q/spica-2.6.38.git, but I am going to prepare patches 
containing all the changes a bit later, after I rebase all my work to latest 
Linux sources, as I worked mostly on Android 2.6.38 sources.

Best regards,
Tomasz Figa

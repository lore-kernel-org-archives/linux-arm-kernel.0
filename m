From: michal.bachraty@gmail.com (michal.bachraty at gmail.com)
Date: Wed, 20 Mar 2013 06:55:35 -0700 (PDT)
Subject: [PATCH v3] clk: add si5351 i2c common clock driver
In-Reply-To: <fa.XCuSmq9Zwp3+wqFO8NEjpwADVZ0@ifi.uio.no>
References: <fa.WZVD0OA/Ooajh6BejiLf7TwBsJ8@ifi.uio.no>
 <fa.iIqrS6k+Vb5mLqAeL7iTsNsbKyo@ifi.uio.no>
 <fa.L0b41q+fYFZG0WOFTGKLhn/cGPA@ifi.uio.no>
 <fa.XCuSmq9Zwp3+wqFO8NEjpwADVZ0@ifi.uio.no>
Message-ID: <6e120226-8a3c-415f-90f2-c44e7b6bbf96@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

Thanks for writing this driver!
I have tested your si5351 clock driver and his tuning capabilities. It works well, it generates proper clock frequency, but when new frequency is generated, little clock gap (1ms) is generated. Si5351 datasheet and WP claims, clock tuning can be without gaps - http://www.silabs.com/Support%20Documents/TechnicalDocs/Si5350-51-Frequency-Shifting-WP.pdf
I made some tests with Si5351A chip and I found that when tuning touch only Multisynth registers, it can tune without gaps. There is no need for soft PLL reset. I found also, accessing Multisynth registers is not atomic, so there can be another frequency at output, while not all registers are written. Writing only to one register seems to be atomic.
I'm using this chip for master audio clock frequency generator and tuning about +-50ppm. The question is, if driver you made has capability for tuning without gaps in +-50pmm (or any other) range with about 1ppm step and if not, it is possible to add this functionality? 

Thanks,

Michal

From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 16 Feb 2011 09:48:33 +0100
Subject: platform data and mfd design question
In-Reply-To: <4D5AF554.2030208@codeaurora.org>
References: <4D5AF554.2030208@codeaurora.org>
Message-ID: <4D5B8F61.3090105@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2011 10:51 PM, Abhijeet Dharmapurikar wrote:
> Msm on the other hand declares the struct mfd_cell subdevice[] array in
> the board file and passes this on to the core driver via platfom data.
>    

This way the platform data tells the core driver what kind of
silicon it has "hey, PM8058, guess what, you have an RTC!"
which looks backwards to me, especially given that it does
not need any fancy platform data at all, just two IRQ numbers
which the core driver can very well handle.

For example: if the platform data (which is about how the
components are connected on the board etc) does not
provide the RTC resource, all of a sudden it appears to the
system as if the PM8058 does not have an RTC, but it does...


Yours,
Linus Walleij

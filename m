From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 26 Apr 2016 13:22:32 +0200
Subject: clk: bcm2835: what is the best way to limit the selection of
 parent clocks in the device-tree
In-Reply-To: <571DCED0.9010008@martin.sperl.org>
References: <571DCED0.9010008@martin.sperl.org>
Message-ID: <571F4F78.6000504@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

Am 25.04.2016 um 10:01 schrieb Martin Sperl:
> Hi!
>
> On the raspberry pi the pcm (and other) clock has multiple parent
> clocks that the driver may select from to get the "best fit" clock.
>
> This list of parents of valid for each clock is hard-coded in the driver.
>
> But this "standard" list of parents includes some clocks that are
> independently controlled by the firmware with - unfortunately for
> now - no notification of changes going back to the linux kernel.
> This is mostly needed for powermanagement and ARM clock
> modifications as well as to avoid overheating.
>
> So how is the best way to define those parent clocks one wants to
> use for an individual clock?

since the device tree should describe the hardware this should be kept
in the driver. So we can't get into trouble if the firmware change it's
behavior.

Regards
Stefan

From: wens213@gmail.com (wens Tsai)
Date: Tue, 6 Sep 2016 19:02:27 +0800
Subject: sunxi: Endless musb_bus_suspend warnings when booting A23 tablet with
 OTG
Message-ID: <CAGb2v648CnhjvEtrxdXxRYFjW_Oe-Rqf3DkiHwNR9uWt7FC3hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

I've built the latest sunxi-next branches of Linux and U-boot and
tried it on my Q8 A23 tablet. My tablet has an OTG adapter with a
USB ethernet adapter connected all the time. Upon booting into
Linux I get an endless stream of:

    musb_bus_suspend 2586: trying to suspend as a_wait_bcon while active

messages. To get out of this I have to physically remove the OTG
adapter. Booting without the OTG adapter to begin with also gets
rid of the problem.

Have you run into this problem? I wonder if we should disable VBUS
just before leaving U-boot? Now that we support DRIVEVBUS this
shouldn't be a problem.

Regards
ChenYu

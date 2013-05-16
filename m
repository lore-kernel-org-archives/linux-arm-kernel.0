From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 16 May 2013 10:26:24 +0200
Subject: [PATCHv9 5/9] clk: mvebu: create parent-child relation for PCIe
 clocks on Armada 370
In-Reply-To: <20130516094417.24b1ca0d@skate>
References: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368624323-24311-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130515214154.12127.73539@quantum> <20130516094417.24b1ca0d@skate>
Message-ID: <51949830.70306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 09:44 AM, Thomas Petazzoni wrote:
> Dear Mike Turquette,
>
> On Wed, 15 May 2013 14:41:54 -0700, Mike Turquette wrote:
>> Quoting Thomas Petazzoni (2013-05-15 06:25:19)
>>> The Armada 370 has two gatable clocks for each PCIe interface, and we
>>> want both of them to be enabled. We therefore make one of the two
>>> clocks a child of the other, as we did for the sataX and sataXlnk
>>> clocks on Armada XP.
>>
>> Ack for patches #5 and #6.  Do you want me to take them?
>
> I don't know, I guess with your Ack, it would be easier to carry them
> through the Marvell maintainers and then the arm-soc tree, so that we
> can test arm-soc and have all the pieces needed in here.
>
> That said, Sebastian Hesselbarth has submitted a big rework of the
> mvebu clock drivers, which would conflict with this patch, and
> Sebastian's rework would most likely go through your tree. If that's
> the case, I guess it would be better to let you take #5 and #6 in this
> patch series.

I also requested to take the restructure patches through ARM tree. They
are only touching files in drivers/clk/mvebu and by taking them through
ARM, we can update PCIe clock patches easily. The dependency between
Thomas' and my patches basically is that I renamed files that Thomas
now commits to. (I switched clk/mvebu from per-function files to per-soc
files).

> That's something to be discussed with the Marvell maintainers (Jason
> Cooper, Andrew Lunn, Gregory Clement).

Sebastian

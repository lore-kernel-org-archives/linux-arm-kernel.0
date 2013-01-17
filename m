From: davem@davemloft.net (David Miller)
Date: Wed, 16 Jan 2013 22:10:21 -0500 (EST)
Subject: [PATCH v2 1/1 net-next] net: fec: enable pause frame to
 improve rx prefomance for 1G network
In-Reply-To: <CAHrpEqRV7PonDpqAvGkDf7QqSeUj+mVbnF2rA-Zjb9xfWh-_2g@mail.gmail.com>
References: <1358153387-19275-1-git-send-email-Frank.Li@freescale.com>
 <CAHrpEqRV7PonDpqAvGkDf7QqSeUj+mVbnF2rA-Zjb9xfWh-_2g@mail.gmail.com>
Message-ID: <20130116.221021.1688403542986325196.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <lznuaa@gmail.com>
Date: Thu, 17 Jan 2013 10:50:36 +0800

> Any feedback about this patch?

Well it's full of stylistic problems.

>> +       /* enable pause frame*/
>> +       if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
>> +               ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
>> +                       fep->phy_dev && fep->phy_dev->pause)) {

This is mis-idented.

>> +
>> +               rcntl |= FEC_ENET_FCE;

That empty line before this assignment is spurious.

>> +       pause->rx_pause = pause->tx_pause;
>> +
>> +}

That empty line is unnecessary, remove it.

>> +       /* default enable pause frame auto negotiation */
>> +       if (pdev->id_entry &&
>> +                       (pdev->id_entry->driver_data & FEC_QUIRK_HAS_GBIT))

You can't possibly tell me that this indentation looks right
to you.

You must style things like this:

	if (condition1 &&
	    condition2)

That is, you must line up the first character on the second and
subsequent lines at the first column after the openning parenthesis of
the first line.

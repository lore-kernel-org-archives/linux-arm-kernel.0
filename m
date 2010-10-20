From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 20 Oct 2010 07:08:20 +0200
Subject: net{space,xbig} TCLK determination
Message-ID: <20101020050820.GD12979@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The net{space,xbig} board support files have this:

	static void netspace_v2_timer_init(void)
	{
		kirkwood_tclk = 166666667;
		orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
	}

This is a pretty ugly hack -- if kirkwood_find_tclk() is not
determining the right TCLK on these boards, then that would be the
real bug, and it should be fixed there, and not by putting hacks
like these in board support files.


thanks,
Lennert

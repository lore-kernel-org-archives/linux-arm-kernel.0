From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 Nov 2011 08:41:22 +0100
Subject: [PATCH 3/5] [orion] Move address map setup out of the drivers
 and into platform.
In-Reply-To: <alpine.LFD.2.02.1111141855340.3307@xanadu.home>
References: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
 <1321128007-3520-4-git-send-email-andrew@lunn.ch>
 <alpine.LFD.2.02.1111141855340.3307@xanadu.home>
Message-ID: <20111115074122.GA2012@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I understand that you might want to get rid of the annoying platform 
> data pointer for the mbus values.  But I think that this could be done 
> some other way though.  IMHO the mbus initialization code for 
> peripherals should remain in the drivers, and a different way to query 
> the needed information be elaborated instead.  Otherwise this is like 
> throwing out the baby with the bath water.

I'm open to suggestion.

What do you think about the idea of keeping the first two patches,
i.e. *_mbus_dram_info out of mach-* and into plat-orion. Then
providing a function orion_mbus_dram_info() which returns its. Keep
the address map setup code in the drivers, remove struct
mbus_dram_target_info from platform_data and use this function
instead?

	Thanks
		Andrew

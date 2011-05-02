From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 2 May 2011 22:24:49 +0200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <4DBF1342.6070406@bluewatersys.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
	<20110502153852.GI1212@game.jcrosoft.org>
	<4DBF1342.6070406@bluewatersys.com>
Message-ID: <20110502202449.GB13724@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> So I don't see how you can "detect" the CPU without first knowing
> >> which CPU and therefore where the DBGU register is anyway.
> >> And probing different addresses for a value is not an acceptable solution.
> > we have 2 different register 0xfffff200 and 0xffffee00
> > which are the DBGU or the PIOA
> > 
> > and on the PIOA at the offset 0x40 if you try to read the cpu will always
> > return 0x0, and have no effect on the soc
> > 
> > so I do not think there is a big issue to read 2 register to detect the soc
> > automatically
> 
> This does rely on Atmel not making another soc which has the DBGU at an
> address which does cause a conflict (low possibility, but would be very
> annoying). It's also really ugly to read random registers until we get
> the one we want.
> 
> However, I still do not see what is wrong with the current approach of
> the boards explicitly specifying the soc type. The correct soc/cpu type
> can already be determined without changing the code. So why are we
> changing the code?
Because some hardware design architecture such as CPU module do allow to have
the SAME board with different SOC. So have one machine ID per combinaison because
we just change the soc is a non-sense.

And it's not random address it's specific 2 address with specific value per soc

Best Regards,
J.

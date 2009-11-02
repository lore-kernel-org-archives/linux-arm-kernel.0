From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 2 Nov 2009 17:54:25 +0800
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <20091102093840.GA11426@elf.ucw.cz>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
	<20091101205449.GT14091@buzzloop.caiaq.de>
	<20091101213343.GA31345@elf.ucw.cz> <20091101220341.GA16698@elf.ucw.cz>
	<771cded00911020122o3bb5cc96q957c8be1ce7cae46@mail.gmail.com>
	<20091102093840.GA11426@elf.ucw.cz>
Message-ID: <f17812d70911020154n2f787a7bu907799b9f7f4e18a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The original patch is also poorly changelogged. What is the advantage
> of ICHP and why do we want default priorities?
>

That's going to simplify the "get_irqnr_and_base" macro significantly
and make it much easier to adopt pxa950 which has more than 64
IRQs. And besides, it's priority based, so we do want to handle IRQ
numbers from high priority to low from software either.

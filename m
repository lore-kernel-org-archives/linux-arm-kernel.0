From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 7 Sep 2010 22:22:30 +0100
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <4C8692DE.1020202@bluewatersys.com>
References: <4C85BEFD.402@bluewatersys.com>
	<569801.35222.qm@web180310.mail.gq1.yahoo.com>
	<AANLkTinq98+ryOOKx1o1o21x9VnHz3nRCHh=5Wwixn4o@mail.gmail.com>
	<4C8692DE.1020202@bluewatersys.com>
Message-ID: <20100907222230.4a3594be@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Adding:
> 
> 	 device->output_pin = -EINVAL;

gpio numbers are unsigned in the rest of the API

It's unfortunate that 0 was used for a GPIO - I take it this is too late
to get fixed as we had to fix IRQ numbering and the like ?

From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Jun 2013 15:47:49 +0200
Subject: [PATCH 7/8] arm: mvebu: add another earlyprintk Kconfig option
In-Reply-To: <20130605134552.GK3803@titan.lakedaemon.net>
References: <1370415901-4721-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370415901-4721-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130605134552.GK3803@titan.lakedaemon.net>
Message-ID: <20130605154749.29b51f40@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Wed, 5 Jun 2013 09:45:52 -0400, Jason Cooper wrote:

> >  	config DEBUG_MVEBU_UART
> 
> Perhaps we should change this to DEBUG_MVEBU_UART_LEGACY?

> > +	config DEBUG_MVEBU_UART_ALTERNATE
> 
> And this to DEBUG_MVEBU_UART?

I'm fine with doing that, but it means that people who will keep their
current .config that has CONFIG_DEBUG_MVEBU_UART=y will suddenly see
their earlyprintk use 0xf1 instead of 0xd0. So in terms of kconfig
backward compatibility, it's not the nicest thing, but if you believe
that's ok, I'll change the patch as you proposed.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

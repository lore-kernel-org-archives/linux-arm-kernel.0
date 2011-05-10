From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 May 2011 22:36:30 +0200
Subject: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
In-Reply-To: <20110510220214.916621d1.ospite@studenti.unina.it>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
	<20110509202325.GD16919@n2100.arm.linux.org.uk>
	<20110509203612.GC21323@opensource.wolfsonmicro.com>
	<20110510220214.916621d1.ospite@studenti.unina.it>
Message-ID: <20110510203629.GB8726@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 10:02:14PM +0200, Antonio Ospite wrote:

> So, I am going to remove the ifdefs anyway but use IS_ERR_OR_NULL();
> how does that sound? Am I still missing anything?

Looks good to me.

> Or changing the regulator_get() stub to return an error (-ENOSYS?) might
> be worth it?

No, the whole point of stubbing out the API is that it allows most
consumers which just do simple enables and disables to run without
needing to worry if the regulator API is compiled in or not.

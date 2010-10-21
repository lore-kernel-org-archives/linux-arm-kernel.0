From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 21 Oct 2010 19:55:13 -0400 (EDT)
Subject: [PATCH] sdio: fix suspend/resume regression
In-Reply-To: <1287704855.12734.14.camel@maxim-laptop>
References: <1286788315.3101.11.camel@sven>
	<1286955116-22793-1-git-send-email-ohad@wizery.com>
	<1287704855.12734.14.camel@maxim-laptop>
Message-ID: <alpine.LFD.2.00.1010211952110.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Oct 2010, Maxim Levitsky wrote:

> So what happens if you set .suspend to NULL? instead of -ENOSYS return?

At run time, the driver may decide to handle the suspend request and 
return 0, or decide to simply return -ENOSYS if it doesn't want to 
bother with the suspend meaning that the card should be removed, or 
return another error code meaning that the suspend request must be 
aborted.



Nicolas

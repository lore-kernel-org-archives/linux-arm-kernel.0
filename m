From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 7 Mar 2013 09:27:21 +0100
Subject: [PATCH 00/16] big.LITTLE low-level CPU and cluster power
 management
In-Reply-To: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130307082721.GB28982@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Review comments are welcome!
> 
> [*] General design information on the b.L switcher can be found here:
>     http://lwn.net/Articles/481055/
>     However the code is only accessible to Linaro members for the
>     time being.

Assuming the lwn article is accurate:

Hmm. So we have hw capable of running 8 cores, and then we introduce strange
switching code, because "scheduler is not ready". Sounds like a bad idea.

I'd say:

* expose all 8 cores.

* as long as scheduler is not ready, you can offline "the other" set of cores...
	/sys/.../cpu/..../online

That way, I suspect scheduler will be fixed rather quickly.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

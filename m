From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Mar 2013 20:30:01 +0000
Subject: [PATCH 05/32] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <20130304172850.5e18fbfb@skate>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302122236.37491.arnd@arndb.de> <20130304172850.5e18fbfb@skate>
Message-ID: <201303042030.01817.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 March 2013, Thomas Petazzoni wrote:
> FWIW, a patch that is doing what I was initially proposing has been
> merged for 3.9, and it doesn't contain the
> IS_ENABLED(CONFIG_HAS_IOPORT) test you were proposing (and which I
> think was correct). See:
> 
> commit 9ed8a30f3471347c1b763bd062fa78ae80f18eae
> Author: Jingoo Han <jg1.han@samsung.com>
> Date:   Wed Feb 27 17:02:42 2013 -0800
> 

Sigh.

I'll take it as an additional incentive to finally clean up the logic behind
CONFIG_HAS_IOPORT by introducing a CONFIG_HAS_IOPORT_MAP symbol to replace it.

Thanks for the heads up.

	Arnd

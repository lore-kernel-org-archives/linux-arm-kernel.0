From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 18 Feb 2011 14:35:00 +0000
Subject: [PATCH v2 13/13] tty: pruss SUART driver
In-Reply-To: <90BDE50764124CA8AAD560BB1E92C062@subhasishg>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-14-git-send-email-subhasish@mistralsolutions.com>
	<20110211162814.6ff274f1@lxorguk.ukuu.org.uk>
	<90BDE50764124CA8AAD560BB1E92C062@subhasishg>
Message-ID: <20110218143500.23b3044b@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Feb 2011 19:17:38 +0530
"Subhasish Ghosh" <subhasish@mistralsolutions.com> wrote:

> Hello,
> 
> Regarding the semaphore to mutex migration.
> We are using down_trylock in interrupt context,
> mutex_trylock cannot be used in interrupt context, so we cannot use mutex in 
> our driver.

Then you probably need to rework your locking. Best bet might be to fix
all the other stuff and report the driver, and people can think about the
locking problem.

Alan

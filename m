From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Feb 2013 16:27:28 +0000
Subject: [PATCH 24/35] mfd: ab8500: Remove unnecessary 'struct device'
 declaration
In-Reply-To: <20130225144904.GM4417@gmail.com>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
 <201302251433.36121.arnd@arndb.de> <20130225144904.GM4417@gmail.com>
Message-ID: <201302251627.29072.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 February 2013, Lee Jones wrote:
> > and others that use 'struct device'. C99 requires that a struct is declared
> > in advance  before you use it in a function declaration.
> 
> Hmm... I wonder why it doesn't complain then?
> 
> I'll remove the patch.

It's only a problem if the file is included before any other header declares
'struct device'. It may well be that this currently never happens, but it's
better to be safe and have a header that can be included in any order:
relying on a specific inclusion order can easily break with 'make randconfig'
turning off specific features that you did not know you relied on.

	Arnd

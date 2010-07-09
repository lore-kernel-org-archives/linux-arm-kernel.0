From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Jul 2010 19:25:39 +0200
Subject: [PATCH v2 5/5] colibri-pxa3xx: add touchscreen support
In-Reply-To: <201007091921.32323.pieterg@gmx.com>
References: <201007082249.59852.pieterg@gmx.com>
	<201007091853.41395.arnd@arndb.de>
	<201007091921.32323.pieterg@gmx.com>
Message-ID: <201007091925.39357.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 July 2010, pieterg wrote:
> Note that this would not happen normally.
> The concern was raised as to what would happen if the user accidentally put 
> two different AC97/touchscreen controllers in the kernelconfig, while there 
> is only one AC97 interface.
> And my observation is that nothing serious happens in that case.

Yes, I understand that it's not serious. I'm arguing instead that it's still
wrong. If you ship a kernel with support for two dozen different controllers,
you certainly wouldn't want to list them all as present devices and
have to go through loading each driver at boot time, just to find that
they are not actually present.

	Arnd

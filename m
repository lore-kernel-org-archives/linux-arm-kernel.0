From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 21:19:56 +0000
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <1357764194-12677-6-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-6-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <201301092119.57067.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013, Thierry Reding wrote:
> The I/O map cache is used to map large regions of physical memory in
> smaller chunks to avoid running out of vmalloc()/ioremap() space.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Can you explain why this is necessary and which problem it solves?
The implementation looks reasonable, but it's not clear to me if
we really need this new interface.

In what cases does it actually save ioremap space?

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 12:44:07 +0200
Subject: [PATCH v4 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130409103445.GA2268@localhost>
References: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201304091140.51839.arnd@arndb.de> <20130409103445.GA2268@localhost>
Message-ID: <201304091244.07662.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Ezequiel Garcia wrote:
> Ah! yes, you're right...
> 
> Well, in that case the only issue I can foresee is that if we decide
> to use of_platform_populate we won't be able to unregister child
> devices from the remove() callback.
> 
> Indeed, the benefits of using of_platform_populate are interesting,
> but I don't know how much of an issue this represents.
> 
> If we can't unregister child devices, we can't remove address windows.
> Now, this is not a big deal, since we plan to define them statically in
> the DT anyway.
> In that case, it seems we shouldn't allow this driver to be a module, uh?
> 
> (actually we currently can't have mvebu-devbus as a module, because
> mbus API is not exported, but we can fix that if we want).

I think it's still reasonable to make it a module, but it might need to
be one without a module_exit() call to prevent unloading.

We could also try to add the opposite of of_platform_populate to remove
an entire subtree.

	Arnd

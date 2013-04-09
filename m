From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 9 Apr 2013 08:00:32 -0300
Subject: [PATCH v4 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <201304091244.07662.arnd@arndb.de>
References: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201304091140.51839.arnd@arndb.de>
 <20130409103445.GA2268@localhost>
 <201304091244.07662.arnd@arndb.de>
Message-ID: <20130409110031.GB2268@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 12:44:07PM +0200, Arnd Bergmann wrote:
> On Tuesday 09 April 2013, Ezequiel Garcia wrote:
> > Ah! yes, you're right...
> > 
> > Well, in that case the only issue I can foresee is that if we decide
> > to use of_platform_populate we won't be able to unregister child
> > devices from the remove() callback.
> > 
> > Indeed, the benefits of using of_platform_populate are interesting,
> > but I don't know how much of an issue this represents.
> > 
> > If we can't unregister child devices, we can't remove address windows.
> > Now, this is not a big deal, since we plan to define them statically in
> > the DT anyway.
> > In that case, it seems we shouldn't allow this driver to be a module, uh?
> > 
> > (actually we currently can't have mvebu-devbus as a module, because
> > mbus API is not exported, but we can fix that if we want).
> 
> I think it's still reasonable to make it a module, but it might need to
> be one without a module_exit() call to prevent unloading.
> 
> We could also try to add the opposite of of_platform_populate to remove
> an entire subtree.
> 

Yes, good idea.

I'll send a v5 in a minute, with your acked-by,
maintaining the of_platform_device_create for now.

I think at this point it's reasonable to add of_platform_populate
as a follow-up patch, together with the mbus-related fixes.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

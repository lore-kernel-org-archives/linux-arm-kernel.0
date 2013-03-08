From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 8 Mar 2013 10:50:23 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <201303081541.29410.arnd@arndb.de>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303081350.15429.arnd@arndb.de> <20130308150655.2bad20ce@skate>
 <201303081541.29410.arnd@arndb.de>
Message-ID: <20130308175023.GE4094@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 03:41:29PM +0000, Arnd Bergmann wrote:

> If you want the boot loader to tell the kernel to autoconfigure all the
> mappings, an absent ranges property would be the right thing. This makes
> a lot of sense if you want to go fully dynamic, but I thought that you
> were not attempting to go that far yet.
> 
> I think we really want the ranges to be populated at run-time though,
> and have it match exactly the windows that we decide to put in, so that
> of_address_translate works.

Right, so taking these two paragraphs together - if you have an absent
ranges you are imagining that the mbus driver would write out a new
fully populated ranges to the DTB? That would be necessary to keep
of_address_translate working.

If so we are talking about exactly the same thing - the in memory DTB
would still have working address translation.

An absent ranges makes some sense from a spec perspective - however do we
have the kernel infrastructure to grow an in memory DTB node?

Jason

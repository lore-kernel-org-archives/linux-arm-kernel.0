From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 20 May 2011 23:44:10 +0530
Subject: [PATCH 4/4] davinci: create new common platform header for davinci
In-Reply-To: <201105201927.22386.arnd@arndb.de>
References: <1305900841-4020-1-git-send-email-manjunath.hadli@ti.com>
	<201105201927.22386.arnd@arndb.de>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D09AD34@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, May 20, 2011 at 22:57:22, Arnd Bergmann wrote:
> On Friday 20 May 2011 16:14:01 Manjunath Hadli wrote:
> > remove the code from individual platform header files for
> > dm365, dm355, dm644x and dm646x and consolidate it into a
> > single and common header file dmx.h.
> > Include the new header file in individual platform header
> > files as a pre-cursor for deleting these headers in follow
> > up patches.
> > 
> > Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> 
> I probably missed the discussion that led to this patch, but
> please explain the motivation behind the change in the changelog.
> 
> Your current changelog reads like this is pointless churn,
> which may or may not be the case. The diffstat shows 27 lines
> being removed in total, which is roughly the amount of copyright
> headers.

Well, it started with the need to get rid of using IO_ADDRESS()
on "system module" which is a bunch of SoC specific registers
found on dm365, dm355, dm644x and dm646x SoCs (all at the same
base address, but having different SoC specific register content).

Please see the previous discussion here:

http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-April/022523.html

We could have probably avoided the churn by sticking DAVINCI_SYSMODULE_VIRT()
into yet another (unrelated or new) header file, but it made sense to have a 
single header file containing platform private stuff for all these SoCs.

Thanks,
Sekhar

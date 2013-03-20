From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Mar 2013 17:44:17 +0000
Subject: [PATCHv2 1/2] ARM: socfpga: Enable soft reset
In-Reply-To: <20130320152915.GA32083@amd.pavel.ucw.cz>
References: <1363707936-17769-1-git-send-email-dinguyen@altera.com>
 <20130320152915.GA32083@amd.pavel.ucw.cz>
Message-ID: <20130320174417.GO4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 04:29:15PM +0100, Pavel Machek wrote:
> Hi!
> 
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Enable a cold or warm reset to the HW from userspace.
> > 
> > Also fix a few sparse errors:
> > 
> > warning: symbol 'sys_manager_base_addr' was not declared. Should it be static?
> > warning: symbol 'rst_manager_base_addr' was not declared. Should it be static?
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> 
> Tested-by: Pavel Machek <pavel@denx.de>
> 
> Would it make sense to apply something like this? Struct looks cleaner
> than offset defines... 

Structs used to define offsets is technically dodgy according to the C
standards, so I personally really do not like this practice, and I will
not use it ever myself where offsets matter.

Your use is fine though, but only because we know how the compiler behaves
on ARM - and that's a very important point with doing this.  We're reliant
on that compiler behaviour if we go down this path.

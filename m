From: stuartl@vrt.com.au (Stuart Longland)
Date: Tue, 14 Oct 2014 09:36:44 +1000
Subject: Where is DRAM initialisation done?
In-Reply-To: <CAOMZO5DfsimNGHS5KB133GHQuyD2hQx6ChNcVqm_ZraLY9VhMw@mail.gmail.com>
References: <CAOMZO5Dj3N=KGKyMtg+FdAx55uFoDvuTA2GmjhwJJU-B7P0DmA@mail.gmail.com>
 <CAOMZO5DfsimNGHS5KB133GHQuyD2hQx6ChNcVqm_ZraLY9VhMw@mail.gmail.com>
Message-ID: <543C620C.3050302@vrt.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,
On 14/10/14 09:11, Fabio Estevam wrote:
> On Mon, Oct 13, 2014 at 8:02 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Mon, Oct 13, 2014 at 7:45 PM, Stuart Longland <stuartl@vrt.com.au> wrote:
>>
>>> Does anyone happen to know where in the mainline kernel this is done, if
>>> at all?
>>
>> The DDR is initialized only by the bootloader.
>>
>> You can check arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c in U-boot.
> 
> Also, maybe it can help if you have access to the old source code
> where the DDR is initialized.
> 
> The 'old' way of doing the DDR init is via a separate package called 'bootlets'.
> 
> So if you have access to the bootlets code, it would be easy to port
> the DDR init into U-boot.

Yes, I do have their bootlets code which was how they implemented the
old bootloader.  It's stuffed inside the kernel source tree they provide
(3rd link in my last email).

Copying and pasting bits out of that (and reading the datasheets) got me
where I am now, it's then I went digging and found some similar code in
their kernel itself, and so I wondered about the mainline kernel doing
the same.

At least now I know to focus my efforts on U-Boot itself: the kernel
should work if I get U-Boot working correctly.

Anyway, this has hopefully pointed me in the right direction, and I'll
keep bashing away at U-Boot to hopefully get a result there.

I think I see a light at the end of the tunnel and hopefully not light
from an oncoming train. :-)

Many thanks.
Regards,
-- 
Stuart Longland
Systems Engineer
     _ ___
\  /|_) |                           T: +61 7 3535 9619
 \/ | \ |     38b Douglas Street    F: +61 7 3535 9699
   SYSTEMS    Milton QLD 4064       http://www.vrt.com.au

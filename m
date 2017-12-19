From: b-liu@ti.com (Bin Liu)
Date: Tue, 19 Dec 2017 13:33:47 -0600
Subject: [PATCH 1/2] usb: musb: un-break davinci glue layer
In-Reply-To: <CF323D845261FD4F9B1E997381250334E344CBEB@maildb.hanover.local>
References: <20171208192355.32735-1-amery@hanoverdisplays.com>
 <20171219172220.GD14090@uda0271908>
 <CF323D845261FD4F9B1E997381250334E344CBEB@maildb.hanover.local>
Message-ID: <20171219193347.GE14090@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 05:33:14PM +0000, Alejandro Mery wrote:
> Hi Bin,
> 
> On 19/12/17 17:22, Bin Liu wrote:
> > Hi Alejandro,
> >
> > On Fri, Dec 08, 2017 at 07:23:54PM +0000, Alejandro Mery wrote:
> >> MUSB's davinci glue was made to depend on BROKEN by Felipe Balbi back in
> >> 2013 because of lack of active development. needed changes were actually trivial
> >>
> >> Fixes: 787f5627bec8 (usb: musb: make davinci and da8xx glues depend on BROKEN)
> >> Signed-off-by: Alejandro Mery <amery@hanoverdisplays.com>
> > Thanks for the effort to re-enable this driver. But due to lack of
> > development, other than the phy and fifo mode which you try to fix with
> > these two patches, the driver still doesn't fit in the current driver
> > framework, for example,
> >
> > - the driver depends on mach/ header for CPU and board type;
> > - clk control is not separated;
> > - gpio control vbus should use extcon driver;
> I'll try to fix these issues but it will take a while. I'm still
> struggling to get USB working at all on the DM365 EVM

Thanks for the effort.

> 
> >
> > So I feel it is not ready to un-broken it yet, unless others have
> > different opinion.
> >
> > But I could take these two patches if not remove BROKEN from Kconfig.
> 
> do you want a v2 for that?

That will be great!

Thanks,
-Bin.

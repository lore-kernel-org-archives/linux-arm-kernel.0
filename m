From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Jan 2017 11:16:28 +0000
Subject: [PATCH v20 13/17] acpi/arm64: Add GTDT table parse driver
In-Reply-To: <CADyBb7tdfw+wbTZbcnsaHRa=aG6i9acLp7rzMpfMs-vOHXL6pQ@mail.gmail.com>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-14-fu.wei@linaro.org>
 <e69d80d1-0954-b1be-817e-c0be6fc24b77@linaro.org>
 <CADyBb7tdfw+wbTZbcnsaHRa=aG6i9acLp7rzMpfMs-vOHXL6pQ@mail.gmail.com>
Message-ID: <20170119111628.GC11176@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 06:32:55PM +0800, Fu Wei wrote:
> On 19 January 2017 at 17:11, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > On 2017/1/18 21:25, fu.wei at linaro.org wrote:
> >> From: Fu Wei <fu.wei@linaro.org>

> >> +       else if (!gtdt->platform_timer_count)
> >> +               pr_debug("No Platform Timer.\n");
> >> +       else
> >> +               timer_count = gtdt->platform_timer_count;
> >> +
> >> +       if (timer_count) {
> >> +               platform_timer = (void *)gtdt +
> >> gtdt->platform_timer_offset;
> >> +               if (platform_timer < (void *)table +
> >> +                                    sizeof(struct acpi_table_gtdt)) {
> >> +                       pr_err(FW_BUG "invalid timer data.\n");
> >
> >
> > It's ok but I didn't see other ACPI tables parsing did this check,
> > maybe we can just remove it :)
> 
> here, I want to make sure the FW is valid.
> Once there is a FW bug, we could just return with error.  :-)

Yes, please keep the check!

If anything, it would be nicer for the other ACPI code to verify things
a little more stringently.

Thanks,
Mark.

From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Nov 2016 18:55:40 +0000
Subject: [PATCH v3 2/6] arm64: arch_timer: Introduce a generic erratum
 handing mechanism for fsl-a008585
In-Reply-To: <20161104182050.GA1651@buserror.net>
References: <1478264794-14652-1-git-send-email-dingtianhong@huawei.com>
 <1478264794-14652-2-git-send-email-dingtianhong@huawei.com>
 <20161104182050.GA1651@buserror.net>
Message-ID: <20161104185540.GA22791@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 01:20:50PM -0500, Scott Wood wrote:
> On Fri, Nov 04, 2016 at 09:06:30PM +0800, Ding Tianhong wrote:
> > The workaround for hisilicon,161601 will check the return value of the system counter
> > by different way, in order to distinguish with the fsl-a008585 workaround, introduce
> > a new generic erratum handing mechanism for fsl-a008585 and rename some functions.
> > 
> > v2: Introducing a new generic erratum handling mechanism for fsl erratum a008585.
> > 
> > v3: Introducing the erratum_workaround_set_sne generic function for fsl erratum a008585
> >     and make the #define __fsl_a008585_read_reg to be private to the .c file instead of
> >     being globally visible. After discussion with Marc and Will, a consensus decision was
> >     made to remove the commandline parameter for enabling fsl,erratum-a008585 erratum,
> >     and make some generic name more specific, export timer_unstable_counter_workaround
> >     for module access.
> 
> The command line paramter was added at Marc's request to provide a way of
> enbaling the workaround in a KVM guest, until API is added to allow QEMU to
> discover the need to set the property in the guest device tree.  Is there an
> alternative?

Yes -- generate the device-tree property to indicate that there's an issue.

Will

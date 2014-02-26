From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Feb 2014 19:03:33 +0000
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <20140226175055.3502.49656@capellas-linux>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140222103840.GH21483@n2100.arm.linux.org.uk>
 <20140222120910.GA9012@e102568-lin.cambridge.arm.com>
 <20140223200208.12998.47604@capellas-linux>
 <20140225113251.GB6855@e102568-lin.cambridge.arm.com>
 <20140225175531.18229.77850@capellas-linux>
 <20140226102427.GA22839@e102568-lin.cambridge.arm.com>
 <20140226175055.3502.49656@capellas-linux>
Message-ID: <20140226190333.GD22839@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 05:50:55PM +0000, Sebastian Capella wrote:
> Quoting Lorenzo Pieralisi (2014-02-26 02:24:27)
> > On Tue, Feb 25, 2014 at 05:55:31PM +0000, Sebastian Capella wrote:
> > 
> > Please add:
> > 
> > "swsusp_save() is executed in the suspend finisher so that the CPU context
> > pointer and memory are part of the saved image, which is required by the
> > resume kernel image to restart execution from swsusp_arch_suspend()"
> > 
> > >  * soft_restart is not technically needed, but is used
> > >  * to get success returned from cpu_suspend.
> > >  * After resume, the hibernation snapshot is written out.
> > 
> > "When soft reboot completes, the hibernation snapshot is written out."
> > 
> > Resume is confusing since this code is resuming twice :D on image saving
> > and on kernel image restoration.
> 
> Thanks Lorenzo!
> 
> Here's what I've got.
> 
> /*
>  * Snapshot kernel memory and reset the system.
>  *
>  * swsusp_save() is executed in the suspend finisher so that the CPU
>  * context pointer and memory are part of the saved image, which is
>  * required by the resume kernel image to restart execution from
>  * swsusp_arch_suspend().
>  *
>  * soft_restart is not technically needed, but is used to get success
>  * returned from cpu_suspend.
>  * 
>  * When soft reboot completes, the hibernation snapshot is
>  * written out.
>  */
> 
> Does this look ok?  I'll prepare a v4 patchset.

Yes it does, I will wait and review v4 then.

Thank you,
Lorenzo

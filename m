From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 22 Oct 2015 14:43:34 +0200 (CEST)
Subject: [RFC PATCH v6 3/3] arm: fix a migrating irq bug when hotplug cpu
In-Reply-To: <20151022111307.GS32532@n2100.arm.linux.org.uk>
References: <1443087135-17044-1-git-send-email-yangyingliang@huawei.com>
 <1443087135-17044-4-git-send-email-yangyingliang@huawei.com>
 <CAMuHMdWyvaecQHOzFnxVZus_Pfkxjw1XfkGdcLK=D2ThaoJMzA@mail.gmail.com>
 <20151021202907.GN32532@n2100.arm.linux.org.uk>
 <20151022092629.GQ32532@n2100.arm.linux.org.uk> <5628C0DD.50900@huawei.com>
 <20151022111307.GS32532@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.11.1510221429300.7380@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Oct 2015, Russell King - ARM Linux wrote:
> On Thu, Oct 22, 2015 at 06:56:29PM +0800, Yang Yingliang wrote:
> > I described it in v2 cover letter and kept the change history in v6
> > cover letter. There is no comment on the change when patch the was
> > reviewing in v2, so I thought it's ok and I kept the change in the
> > next versions.
> 
> Cover letters don't always get read, neither do changelogs.
> 
> However, there's a principle here: never mix moving code around with
> changes to that code.  Always move code with as few changes as possible
> in one patch, and then make changes in a subsequent patch.
> 
> The "few changes as possible" means that if you need to make changes
> for it to end up building in its new location, such as removing a
> 'static' or adding an 'EXPORT_SYMBOL' then those are fine, but the
> main body of the code should remain identical, even down to style.
> 
> Any changes (such as, in this case, replacing pr_debug with pr_warn)
> should be done as a distinctly separate patch so that such changes
> are immediately obvious to reviewers.
> 
> > Need I send a patch to the Thomas branch to revert the change ?
> 
> I think wait for Thomas and Catalin to reply.  Your patch series is
> currently merged into two different trees (Thomas' and Catalin's
> trees) and what action is needed depends on how they want to handle
> it.
> 
> The solutions are:
> * A patch to restore the pr_debug() which Thomas applies, and Catalin
>   and myself then pull Thomas' tree again, which potentially creates
>   a messier history.
> 
> * Catalin drops the ARM64 change and Thomas' tree from the ARM64 tree,
>   Thomas drops the original commit, and we start again doing it
>   correctly.
> 
> Which is up to Catalin and Thomas.

I'd have to do a revert as it's in the middle of other changes. So I
prefer to do an incremental fix.

I committed the change into the irq/for-arm branch and pushed it out.

Thanks,

	tglx

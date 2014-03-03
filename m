From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Mon, 3 Mar 2014 11:53:24 +0530
Subject: [PATCH v6 00/14] uprobes: Add uprobes support for ARM
In-Reply-To: <53131DBE.7020500@linaro.org>
References: <1392017945-4507-1-git-send-email-dave.long@linaro.org>
 <20140301123026.GD21483@n2100.arm.linux.org.uk>
 <53131DBE.7020500@linaro.org>
Message-ID: <20140303062324.GB20583@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Oleg,
>

> I've been looking at arch/Kconfig and kernel/trace/Kconfig where
> they deal with uprobes.  The relevant items are CONFIG_UPROBES and
> CONFIG_UPROBE_EVENT.  It just doesn't look right to me.  It looks

It should be me who should take the blame for this and not Oleg.  This
was discussed more than couple of times.  I can recollect couple of
discussions here.
http://article.gmane.org/gmane.linux.kernel/1017186
http://article.gmane.org/gmane.linux.kernel/1001605

I know there were more discussions on this, but I cant dig them out at
this time.  Finally it was decided that
1. Users shouldnt have to select more than one config to select Uprobes.
2. There was no point in selecting Uprobes and not having Uprobe_event
and vice versa.

>From the above, If a user chose UPROBE_EVENT, (which is the interface
for uprobes), we would automatically assume that he wants to use Uprobes
framework.

> like "select" is used in part maybe just to avoid the recursive
> dependency error that would be generated if "depends on" were used
> in both places.

We did "Select Uprobes" not because of avoiding recursive dependency but
as told above, to select the framework, given that user has chosen the
framework. We dont want to give a choice to user to choose uprobe_event
but not choose Uprobes or vice versa.

> However I don't think UPROBES should be dependent on
> UPROBE_EVENT, only the other way around.  As RK noted in previous

Whats the point of having the framework(Uprobes) without an interface?

> email (copied in part below) the select does not pull in the lower
> level dependencies.  This all works on x86 only because
> arch/x86/Kconfig defines CONFIG_PERF_EVENT (which feels like a big
> hammer).  We don't need to do this on ARM, and we don't do it.  The
> result is that, unless PERF_EVENT is set separately, uprobes tends
> not to build.  I was lucking-out in my testing due to other default
> config items turning on PERF_EVENT.
>

--
Thanks and Regards
Srikar Dronamraju

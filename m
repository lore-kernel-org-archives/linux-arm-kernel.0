From: geoff@infradead.org (Geoff Levand)
Date: Tue, 13 May 2014 15:26:55 -0700
Subject: [PATCH 0/8] arm64 kexec kernel patches
In-Reply-To: <20140509162240.GC16418@e106331-lin.cambridge.arm.com>
References: <cover.1399594544.git.geoff@infradead.org>
 <20140509162240.GC16418@e106331-lin.cambridge.arm.com>
Message-ID: <1400020015.11178.70.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for taking the time to review the patches in such detail.

On Fri, 2014-05-09 at 17:22 +0100, Mark Rutland wrote:

> As I've covered in my reply to patch 7 [1] I don't think this is a good
> approach. I think a vastly better approach is to make kexec depend on
> cpu hotplug support in SMP, and enable a simple hotplug-capable boot
> protocol (e.g. extend spin-table with a cpu-return-addr).
> 
> That way the in-kernel portions of kexec can use the existing
> infrastructure without tonnes of point hacks, and we enable a generic
> hotplug capable mechanism for those systems which cannot implement PSCI.

I think this is a sound approach.  As I was working on the kexec code I
felt the same, that the core SMP CPU management should be doing more and
kexec should just use that existing support.

I'll look into splitting off what spin-table handling I have in kexec
into a patch to update the hotplug support.
 
> >   https://git.linaro.org/people/geoff.levand/kexec-tools.git
> 
> Is the master branch up-to-date?  The commit dates on all branches I can
> see imply they haven't been updated in a while, and the code looks like
> it needs some cleanup (there are some unused functions, hard-coded
> values, etc).

I'm working on the cleanup of kexec-tools now.  I pushed out a version
that should boot vanilla 2nd stage kernels and the branches in my repo.

-Geoff

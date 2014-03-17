From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Mar 2014 23:52:29 +0000
Subject: [GIT PULL] uprobes: Add uprobes support for ARM
In-Reply-To: <531F5799.2070302@linaro.org>
References: <1394223040-17129-1-git-send-email-dave.long@linaro.org>
 <531F5799.2070302@linaro.org>
Message-ID: <20140317235229.GQ21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 02:36:09PM -0400, David Long wrote:
>   git://git.linaro.org/people/dave.long/linux.git uprobes-v7
> 
> for you to fetch changes up to e55c35236b8adf79453a998506ec6081833b9484:
> 
>   ARM: add uprobes support (2014-03-11 11:40:29 -0400)

I pulled this a week ago into my devel-testing (which is unpublished),
and while it hasn't shown any signs of functional problems, I was just
about to merge it into devel-stable when I noticed the history.

This is based upon:

Merge branch 'for-next' of git://git.samba.org/sfrench/cifs-2.6
+ Linux 3.11
+ Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
+ Linux 3.12-rc5
+ Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
+ Linux 3.13-rc3
+ Linux 3.13-rc4
+ Linux 3.13-rc8
+ Linux 3.14-rc2
+ Linux 3.14-rc4
+ Linux 3.14-rc5
|
[your uprobes patches]

where each + is a merge of the named commit into the previous.  This is
the kind of thing which will make Linus quite unhappy: please base
patches off a plain -rc release, not off a merge commit.

I'm sure there's others on the mailing list who can guide you on this
point, but I do need to ask you to re-spin without those merges.  I'm
happy to take a respin of it provided it's based on 3.14-rc5 (so I can
more easily confirm that there aren't any changes which I haven't
already tested.)

Thanks, and sorry about the lateness of this email.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.

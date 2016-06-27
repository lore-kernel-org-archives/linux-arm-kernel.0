From: james.morse@arm.com (James Morse)
Date: Mon, 27 Jun 2016 12:04:35 +0100
Subject: [PATCH v20 01/14] arm64: hibernate: Don't hibernate on systems
 with stuck CPUs
In-Reply-To: <97dcd35763eddf1b4c50a26d16389f313269f0c8.1466702804.git.geoff@infradead.org>
References: <cover.1466702804.git.geoff@infradead.org>
 <97dcd35763eddf1b4c50a26d16389f313269f0c8.1466702804.git.geoff@infradead.org>
Message-ID: <57710843.40806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 23/06/16 18:54, Geoff Levand wrote:
> From: James Morse <james.morse@arm.com>
> 
> Hibernate relies on cpu hotplug to prevent secondary cores executing
> the kernel text while it is being restored.
> 
> Add a call to cpus_are_stuck_in_kernel() to determine if there are
> CPUs not counted by 'num_online_cpus()', and prevent hibernate in this
> case.
> 
> Fixes: 82869ac57b5 ("arm64: kernel: Add support for hibernate/suspend-to-disk")
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/kernel/hibernate.c | 6 ++++++
>  1 file changed, 6 insertions(+)


... this patch isn't necessary for kexec, it wired up the helper function you
have in patch 2 for hibernate.

Please drop this in any future posting!


Thanks,

James

From: horms@verge.net.au (Simon Horman)
Date: Tue, 15 Jan 2013 09:42:30 +0900
Subject: shmobile and struct sys_timer removal conflicts
In-Reply-To: <50F445E5.6010203@wwwdotorg.org>
References: <50F445E5.6010203@wwwdotorg.org>
Message-ID: <20130115004230.GZ7185@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 10:52:37AM -0700, Stephen Warren wrote:
> Simon,
> 
> I notice that the following shmobile-related commits in next-20130114
> add new ARM machine descriptors, but set the .timer field rather than
> the new .init_time field. I believe the code in these commits won't
> build in linux-next or Linux 3.9 once it's released:
> 
> a625586 ARM: mach-shmobile: kzm9g: Reference DT implementation
> ac0876f ARM: shmobile: armadillo800eva: Reference DT implementation
> be1fc65 ARM: shmobile: add a reference DT implementation for mackerel
> 66f1162 ARM: mach-shmobile: sh73a0: Minimal setup using DT
> 
> In order to solve this problem, you'll need to adjust those changes
> according to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git timer/cleanup
> 
> (where "adjust" is probably "rebase on top of")

Hi Stephen,

thanks. I'll get this sorted out.

From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Jun 2017 11:04:19 +0100
Subject: [PATCH] arm64: fix missing __user in compat_vfp_{get,set}()
In-Reply-To: <20170628145816.24807-1-luc.vanoostenryck@gmail.com>
References: <20170628145816.24807-1-luc.vanoostenryck@gmail.com>
Message-ID: <20170629100418.GC14607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 04:58:16PM +0200, Luc Van Oostenryck wrote:
> compat_vfp_get() & compat_vfp_set() are two helpers reading
> or writting some values via {get,put}_user() which need a
> pointer annotated with '__user'.
> The buffers used by the two helpers are correctly '__user'
> annotated but need to be casted to a real type before being
> given to {get,put}_user().
> 
> The problem is that this cast lack a '__user' annotation.
> 
> Fix this by adding the missing '__user'.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/arm64/kernel/ptrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This doesn't apply against the arm64 for-next/core branch, due to
changes from Dave reworking this to use user_regset_copyout.

Will

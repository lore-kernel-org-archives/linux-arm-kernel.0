From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 25 Oct 2013 10:22:30 +0200
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <52699E8B.3000305@wwwdotorg.org>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <1382544332.8522.40.camel@shinybook.infradead.org>
 <20131023185114.GA7863@ulmo.nvidia.com>
 <52699E8B.3000305@wwwdotorg.org>
Message-ID: <20131025082229.GD19622@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 11:26:19PM +0100, Stephen Warren wrote:
> On 10/23/2013 07:51 PM, Thierry Reding wrote:
> > On Wed, Oct 23, 2013 at 05:05:32PM +0100, David Woodhouse wrote:
> >> On Wed, 2013-10-23 at 17:06 +0200, Thierry Reding wrote:
> >>> +       /* check if binding is experimental */
> >>> +       if (dev != device || drv != driver) {
> >>> +               pr_warn("of: device %s (%s) uses an experimental binding\n",
> >>> +                       np->name, np->full_name);
> >>> +
> >>
> >> In the discussions earlier I think we decided that this should set a
> >> taint flag too.
> > 
> > A taint flag seems somewhat drastic. It's not like using an experimental
> > binding should have an influence on the stability of the running kernel.
> > I always thought that taint flags were supposed to flag conditions where
> > code of unknown origin or code known to be broken was being executed
> > because they may destabilize the running kernel.
> > 
> > The worst that should happen if you run an experimental binding is that
> > some part of the system will just not come up.
> 
> IIRC, the purpose of the taint flag was to make it clear that the kernel
> or DT was not expected to function in the future, so don't be surpised
> if you upgrade it, and it stops working, without you taking explicit
> action, such as revising your DT to match the new kernel or vice-versa.

I understand that, but I was arguing that it doesn't match existing uses
of taint flags. The various flags that are currently defined all seem to
be set whenever some event occurs that could cause instability of the
currently running system, such as loading a proprietary or out-of-tree
module, forcing a module to be loaded, overriding firmware parameters...

All those seem to have the goal of appearing in crash logs, so that
whoever looks at the bug report can point users somewhere else since the
problem is likely to be caused by their own (bad) decision. Or ask users
to reproduce crashes or bugs without doing whatever they did to cause
the taint flag(s) to be set.

Experimental bindings shouldn't cause any crashes in the first place, or
not cause memory corruption or similar for that matter. If we don't want
to support an experimental binding, then all we should do is not support
any functionality that relies on them. That doesn't mean that runtime
stability is in any way affected.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131025/a79668d8/attachment.sig>

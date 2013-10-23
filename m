From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 23 Oct 2013 18:20:02 +0100
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <5267FA58.9050002@wwwdotorg.org>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org>
Message-ID: <20131023172001.GA3379@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Do we really want to polute the drivers and DT files with a ! in the
> compatible values? I thought we'd considered that, but chosen having the
> drivers that use unstable bindings depend on a Kconfig option as an
> alternative, not an additional step?

I'd even go further and use "unstable-" as the prefix instead of "!"
which is way more explicit.


> The one issue with doing this is that if a binding is thought to be
> unstable, but becomes stable later without any changes, we'll have to do
> busy-work to remove the ! in all the DT files, thus artificially
> introducing an incompatibility. Perhaps that's fine though?

I'd say yes. Going from unstable to stable is quite a step for a binding
and that should be visible and worth a patch IMO. Also, when looking at
a DTS file or some driver code, it will avoid
confusion/misinterpretation if one can see immediately the status of a
binding.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/394ec8ac/attachment-0001.sig>

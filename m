From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 23 Oct 2013 17:05:32 +0100
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <1382540779-6334-1-git-send-email-treding@nvidia.com>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
Message-ID: <1382544332.8522.40.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-23 at 17:06 +0200, Thierry Reding wrote:
> +       /* check if binding is experimental */
> +       if (dev != device || drv != driver) {
> +               pr_warn("of: device %s (%s) uses an experimental binding\n",
> +                       np->name, np->full_name);
> +

In the discussions earlier I think we decided that this should set a
taint flag too. If you've built a kernel with CONFIG_OF_EXPERIMENTAL
(which I think we were calling CONFIG_UNSTABLE_DT) then you have no
expectation that it will boot tomorrow, although it might work with your
DTB today.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/b0a97e2a/attachment-0001.bin>

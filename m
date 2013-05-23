From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 23 May 2013 18:41:34 +0800
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since always
 need it.
In-Reply-To: <20130523100409.GK18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com>
 <20130523090534.GJ18614@n2100.arm.linux.org.uk>
 <CAMuHMdWez-j1Maa3BD7ucmzv0_zFJnChERQiHFmkCaZUzG0_AA@mail.gmail.com>
 <201305231139.38233.arnd@arndb.de>
 <20130523100409.GK18614@n2100.arm.linux.org.uk>
Message-ID: <519DF25E.7060304@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2013 06:04 PM, Russell King - ARM Linux wrote:
> So, if you want to use this, then you should update the CONFIG_BUG text
> to include a warning to this effect:
> 
>      Warning: if CONFIG_BUG is turned off, and control flow reaches
>      a BUG(), the system behaviour will be undefined.
> 
> so that people can make an informed choice about this, because at the
> moment:
> 
>           Disabling this option eliminates support for BUG and WARN, reducing
>           the size of your kernel image and potentially quietly ignoring
>           numerous fatal conditions. You should only consider disabling this
>           option for embedded systems with no facilities for reporting errors.
>           Just say Y.
> 
> will become completely misleading.  Turning this option off will _not_
> result in "quietly ignoring numerous fatal conditions".
> 
> And I come back to one of my previous arguments - is it not better to
> panic() if we hit one of these conditions so that the system can try to
> do a panic-reboot rather than continue blindly into the unknown?

But I still suggest to delete CONFIG_BUG in common kernel.

Since currently, disable 'CONFIG_BUG' is not a common features (most of
architectures are always enable it), it is only belongs to some
architectures specific features (may some embedded systems).

It is not suitable to still let 'CONFIG_BUG' exist in
"asm-generic/bug.h" which is only for common features.

And each architecture can customize their own BUG(), if one architecture
wants to Disabling this option, let it specify its own BUG().

So, most of architectures need not consider this issue again.


Thanks.
-- 
Chen Gang

Asianux Corporation

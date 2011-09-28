From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 28 Sep 2011 08:21:05 -0700
Subject: MAC firmware does not load due to (commit 288d5abe usermodehelper)
In-Reply-To: <20110928120630.GB9456@netboy.at.omicron.at>
References: <20110928120630.GB9456@netboy.at.omicron.at>
Message-ID: <CA+55aFy4aZPdUNBR0O3SP1iRRJyeF9kPZxH9G_eYdxueYskF4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 5:06 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
>
> A warning appears on the console, shown below. ?I don't know what
> commit 288d5abe was trying to fix, but it sure made a regression for
> me. It probably would also spoil using NFS boot, too.
>
> Any ideas what to do about this?

Something seems to be calling ioctl() befor rest_init() has even
completed. Which sounds odd, but I wonder if the schedule() there
before it might have let 'init' get going.

Does something like the attached (UNTESTED) fix it?

                             Linus
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch.diff
Type: text/x-patch
Size: 678 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110928/ab9b1404/attachment.bin>

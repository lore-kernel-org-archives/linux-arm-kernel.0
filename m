From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 23 Sep 2010 14:05:56 +0800
Subject: pxa3xx_nand issues
In-Reply-To: <201009221912.24905.pieterg@gmx.com>
References: <201009221912.24905.pieterg@gmx.com>
Message-ID: <AANLkTikdru5gH=ySKw13CzrDwbhNCArgQqjcE2cydB4L@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 23, 2010 at 1:12 AM, pieterg <pieterg@gmx.com> wrote:
> In my search for the cause of the huge number of single/double bit errors
> I'm experiencing on colibri pxa320/310 devices, I've come across this
> commit
>
> http://git.kernel.org/?p=linux/kernel/git/ycmiao/pxa-linux-2.6.git;a=commit;h=7f9938d0fd6c778bd0ce296a3e3b50266de2b892
>
> According to the commitlog, it attempts to work around an issue regarding
> non-page-aligned reads.
> The workaround seems to force page-aligned access, by dropping the offset
> within the page (column address bytes).
> However, in my setup (with a jffs2 filesystem on nand), non-page-aligned
> reads never occur, but non-page-aligned writes occur very frequently.
> (during the jffs2 gc).
> These are also affected by this commit, while the commitlog does not state
> whether or not the same issue would occur for the program command, and in
> that case, whether or not the same workaround would apply.
>
> I've tried to revert the commit, but unfortunately this doesn't reduce the
> huge number of single/double bit errors (and jffs2 crc errors as a result)
> I'm getting.
>
> But having these non-aligned writes during GC, would that indicate a problem
> with my jffs2 image parameters perhaps?
> (though I cannot imagine this could actually cause double bit errors)
>

It might not be related to the commit above.  The NAND controller will
always read the whole page and ignoring the column address, that patch
tries to make less confusion. The offset is actually handled completely
by software (memorized).

Cc'ed Haojian and Lei.

> Rgds, Pieter
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

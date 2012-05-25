From: try2share@gmail.com (K K)
Date: Fri, 25 May 2012 18:20:28 +0530
Subject: Linux Kernel boot up stops after message "Uncompressing
 Linux....done, booting the kernel"
In-Reply-To: <20120524103221.GA1889@glitch>
References: <CACZ0kf88Ac8hne9RtLObi624okPw8Nkiv7++Uw8npPLW108mhw@mail.gmail.com>
 <CACZ0kf9yHJOAVEBx4e5dc_eCRT5dScrZHzbkx3_7P2QkzaHChQ@mail.gmail.com>
 <20120524103221.GA1889@glitch>
Message-ID: <CACZ0kf-6Vr+TSr96Br8wsE3Y38_4Gev-dYvqw1OgMZp2ProCcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> 2.6.32, really?

Yes kernel is 2.6.32.

>Two cases:

> 1. earlyprintk is configured and enabled but points to the
>    wrong console and your platform hangs on it because it's not
>    initialized/ready. the correct console seems ok, the uncompressor
>     is able to use it. check debug-macro.S to be sure it uses the
>    correct address.

> 2. earlyprintk is not enabled (or configured) and your kernel is
>     not finding the console (any console= on the cmdline? driver
>     issue?) or dies before finding it. try enabling earlyprintk (and
>     check debug-macro.S as well).

I have checked debug-macro.S , console was properly configured and enabled.
Now i can able to see the debug messages on the console.

Thanks..





On Thu, May 24, 2012 at 4:02 PM, Domenico Andreoli <cavokz@gmail.com> wrote:

> On Thu, May 24, 2012 at 10:52:46AM +0530, K K wrote:
> > Hi,
>
> Hi,
>
> > We have a lpc-3180 based board and it is up and running fine with 2.6.10
> > kernel version. We planned to port our board changes into 2.6.32 kernel
> > version.
>
> 2.6.32, really?
>
> > kernel build successfully. When we booting the board with the new 2.6.32
> > kernel we are getting following messages and its stops.
>
> Two cases:
>
>  1. earlyprintk is configured and enabled but points to the
>     wrong console and your platform hangs on it because it's not
>     initialized/ready. the correct console seems ok, the uncompressor
>     is able to use it. check debug-macro.S to be sure it uses the
>     correct address.
>
>  2. earlyprintk is not enabled (or configured) and your kernel is
>     not finding the console (any console= on the cmdline? driver
>     issue?) or dies before finding it. try enabling earlyprintk (and
>     check debug-macro.S as well).
>
> cheers,
> Domenico
>
> ps: post also the kernel configuration
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120525/7b925653/attachment-0001.html>

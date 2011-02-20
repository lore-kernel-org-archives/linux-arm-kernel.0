From: imirkin@alum.mit.edu (Ilia Mirkin)
Date: Sun, 20 Feb 2011 22:59:24 +0000
Subject: [PATCH] arm: imx: Zero entire imxdma structure
In-Reply-To: <1298239851-958-1-git-send-email-imirkin@alum.mit.edu>
References: <1298239851-958-1-git-send-email-imirkin@alum.mit.edu>
Message-ID: <AANLkTin4gJpzV6-bo15rn_AHVGvTD8+9vq3Q+ciLF8vB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 10:10 PM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> The semantic match that finds the problem:
> // <smpl>
> @@
> type T;
> identifier x;
> @@
>
> T *x;
> ...
> * memset(x, ..., ... * sizeof(x) * ...);
> // </smpl>
>
> Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
>
> ---
> ?arch/arm/mach-imx/dma-v1.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> Untested, lack of tool chain and hardware. But there's definitely something
> odd going on here, and this seemed like the most logical fix.

Doing some quick digging (as I've been discovering that a few of the
other patches I was planning on sending have already been sent out in
the past), I noticed that this same patch was already sent on Dec 9,
2009 by Julia Lawall[1] (back when it was plat-mxc/dma-mx1-mx2.c), and
then again by Vasiliy Kulikov[2] on Oct 10, 2010.

On each occasion, the response was positive, but patch has yet to make
it upstream. Weird.

-- 
Ilia Mirkin
imirkin at alum.mit.edu

[1] Message-ID: <Pine.LNX.4.64.0912092022040.1870@ask.diku.dk>
[2] Message-ID: <1286731703-17775-1-git-send-email-segooon@gmail.com>

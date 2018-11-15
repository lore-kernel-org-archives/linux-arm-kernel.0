From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Nov 2018 23:35:14 +0800
Subject: [linux-sunxi] [PATCH 14/15] arm64: dts: allwinner: h5: Add Video
 Engine and reserved memory node
In-Reply-To: <20181115145013.3378-15-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-15-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v64pVKG4mSAF48xR54yj00rQ6iTvgYQB9Bf-XWmH2FhVqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:51 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> This adds nodes for the Video Engine and the associated reserved memory
> for the H5. Up to 96 MiB of memory are dedicated to the CMA pool.
>
> The pool is located at the end of the first 256 MiB of RAM so that the
> VPU can access it. It is unclear whether this is still a hard
> requirement for this platform, but it seems safer that way.

I think we can actually test this. You could move the reserved memory
pool beyond 256 MiB, and have cedrus decode stuff, and try to display
the results. If it's gibberish, or the system crashes, it's likely the
memory access wrapped around at 256 MiB.

What do you think?

ChenYu

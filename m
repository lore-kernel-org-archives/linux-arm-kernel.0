From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 28 Feb 2010 20:58:14 -0700
Subject: [PATCH] iop-adma: redundant/wrong tests in iop_*_count()?
In-Reply-To: <4B76BD0B.2010307@gmail.com>
References: <4B76BD0B.2010307@gmail.com>
Message-ID: <e9c3a7c21002281958u4ee6fb94p55b7c5069dd08be5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 13, 2010 at 7:54 AM, Roel Kluin <roel.kluin@gmail.com> wrote:
> When we reach the loop, len is at least 1, we only stay in the loop when
> len is at least MAX_BYTE_COUNT + 1, MAX_BYTE_COUNT is subtracted in each
> iteration. So when we leave the loop, or didn't take it, len is at least 1.
> Testing whether len is non-zero appears redundant.
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> Or are the tests off by one? Then we'll need a different patch...

No, not off by one, just redundant.

Applied, thanks.

--
Dan

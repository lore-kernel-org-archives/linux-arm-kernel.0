From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 8 Mar 2017 12:28:23 +0800
Subject: [PATCH] reset: sunxi: fix for 64-bit compilation
In-Reply-To: <1488764156-22197-1-git-send-email-andre.przywara@arm.com>
References: <1488764156-22197-1-git-send-email-andre.przywara@arm.com>
Message-ID: <CAGb2v64SozB9vUpotkEOyUK33ba8hq9M-QRQUEzEQ565Bhd93g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 6, 2017 at 9:35 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> The Allwinner reset controller has 32-bit registers, so translating
> the reset cell number into a register and bit offset should not use
> any architecture dependent data size. Otherwise this breaks for 64-bit
> architectures like arm64.
> Fix this by making it clear that it's the hardware register width which
> matters here in the calculation.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Though I don't expect this driver to be used with arm64 chips.

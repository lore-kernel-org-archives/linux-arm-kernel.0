From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 23 Jan 2014 19:09:22 +0100
Subject: [PATCH 1/5] dt-bindings: document the s3c24xx software-reset
 register
In-Reply-To: <2635551.Gy9A9uhyAA@phil>
References: <3105326.uFdOVLyXH8@phil> <2635551.Gy9A9uhyAA@phil>
Message-ID: <52E15AD2.7000602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 06.01.2014 19:37, Heiko St?bner wrote:
> The S3C2412/S3C2413 as well as the S3C2443 and following contain a special
> register that restarts the system when written to. This adds a simple
> binding, so that it gets accessible on dt systems too.
>
> We distinguish between the two types (s3c2412, s3c2443) because the
> handling of the swrst register on the s3c2412 also needs to take care
> of a hardware glitch at reset time.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   .../devicetree/bindings/arm/samsung/s3c24xx-swrst.txt  |   16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/arm/samsung/s3c24xx-swrst.txt

Is there really a need to have separate bindings for this?

As far as I can see, the swreset register is a part of the clock 
controller, so restart function could be provided by clock driver and 
there would be no need to change anything in DT.

Best regards,
Tomasz

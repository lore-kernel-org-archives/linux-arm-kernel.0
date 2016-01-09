From: robh@kernel.org (Rob Herring)
Date: Sat, 9 Jan 2016 16:45:23 -0600
Subject: [PATCH 5/5] dt-bindings: bsm2835: fix bindings documentation to
 use new clock framework
In-Reply-To: <1452331558-2520-6-git-send-email-kernel@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-6-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160109224523.GA17329@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 09, 2016 at 09:25:57AM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> The bcm2835-i2s driver has been updated to use the new clock framework
> for the bcm2835 SOC.

You are breaking compatibility with the driver change. New kernels will 
not work with old dtbs as you have found. What should be done is fix the 
driver to work with the old and new dtb.
 
> This patch documents the required changes to the bindings.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

But I leave it to platform maintainers to decide if breaking 
compatibility is okay, so:

Acked-by: Rob Herring <robh@kernel.org>

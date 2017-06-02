From: s-anna@ti.com (Suman Anna)
Date: Fri, 2 Jun 2017 11:45:53 -0500
Subject: [PATCH v5 0/2] Add TI SCI Reset Driver
In-Reply-To: <20170524180930.9290-1-s-anna@ti.com>
References: <20170524180930.9290-1-s-anna@ti.com>
Message-ID: <04a25503-b675-8832-0323-eb7ecbaaefeb@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 05/24/2017 01:09 PM, Suman Anna wrote:
> Hi Philipp,
> 
> This series adds a reset controller driver that uses the TI SCI protocol
> to manage resets on some TI SoCs. It is a repost of the previous v4 [1]
> submission that has already been acked by Rob and Santosh, but with some
> minor changes. This series has been waiting for the ti-sci-pm-domains
> series to make it to mainline and because of the dependencies against
> a DT header file including the device id values. The ti-sci-pm-domains
> series is now merged and available in 4.12-rc1.
> 
> The main changes in v5 is to drop the include/dt-bindings/reset/k2g.h
> file based on some comments received from Arnd on a similar header usage
> in the ti-sci-pm-domains series. The ti-sci-pm-domains usage is being
> addressed in [2] and this reset series is refreshed to follow the same
> rule and drop the reset header file.
> 
> Patches are on top of 4.12-rc1 plus the recent Kconfig name change on
> the TI SYSCON reset driver [3].
> 
> Rob, Santosh,
> I have retained the Acks received from you on v4, but I am not sure
> since there are some minor changes to the series. Please provide any
> comments if you do not agree with the changes.
> 
> regards
> Suman
> 
> Changes from v4 [1]:
>  - Removed the include/dt-bindings/reset/k2g.h, and updated the
>    bindings document
>  - Minor checkpatch fixes to the driver patch
> 
> Changes from v3:
>  - Addressed Rob Herring's comments
>  - Added Santosh Shilimkar's Ack
> 
> Changes from v2:
>  - Merged DT binding patch and reset header patch
>  - Added locking for reset bit mask
> 
> Changes from v1:
>  - Revised dt binding
>  - CC Linux ARM list
> 
> [1] http://marc.info/?l=devicetree&m=147976458332492&w=2
> [2] http://marc.info/?l=linux-arm-kernel&m=149547831708124&w=2
> [3] https://patchwork.kernel.org/patch/9744909/
> 
> Andrew F. Davis (2):
>   Documentation: dt: reset: Add TI SCI reset binding
>   reset: Add the TI SCI reset driver
> 

Can you pick up this series for v4.13 if there are no comments. Btw, [2]
is acked by Rob. Will appreciate if you can fixup the patch header from
"Documentation: dt: reset: ..." to "dt-bindings: reset: ..." on the
first patch when applying. Thanks in advance.

regards
Suman

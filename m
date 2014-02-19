From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 19 Feb 2014 09:13:19 -0500
Subject: [PATCH v5 2/2] memory: ti-aemif: add bindings for AEMIF driver
In-Reply-To: <1392817210-14312-3-git-send-email-ivan.khoronzhuk@ti.com>
References: <1392817210-14312-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1392817210-14312-3-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <5304BBFF.3070502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 February 2014 08:40 AM, Ivan Khoronzhuk wrote:
> Add bindings for TI Async External Memory Interface (AEMIF) controller.
> 
> The Async External Memory Interface (EMIF16/AEMIF) controller is intended to
> provide a glue-less interface to a variety of asynchronous memory devices like
> ASRA M, NOR and NAND memory. A total of 256M bytes of any of these memories
> can be accessed via 4 chip selects with 64M byte access per chip select.
> 
> We are not encoding CS number in reg property, it's memory partition number.
> The CS number is encoded for Davinci NAND node using standalone property
> "ti,davinci-chipselect" and we need to provide two memory ranges to it,
> as result we can't encode CS number in "reg" for AEMIF child devices
> (NAND/NOR/etc), as it will break bindings compatibility.
> 
> In this patch, NAND node is used just as an example of child node.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

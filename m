From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 26 Apr 2016 08:26:03 -0400
Subject: [PATCH v3 3/4] arm: dts: lpc32xx: reparent SIC1 and SIC2
 interrupts from MIC
In-Reply-To: <1461618143-12310-1-git-send-email-vz@mleia.com>
References: <1461546041-25713-1-git-send-email-vz@mleia.com>
 <1461618143-12310-1-git-send-email-vz@mleia.com>
Message-ID: <1461673563.18338.20.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Tue, 2016-04-26 at 00:02 +0300, Vladimir Zapolskiy wrote:
> The change adds separate device nodes for SIC1 and SIC2 interrupt
> controllers and reparents all defined SIC1 and SIC2 interrupt
> producers to the correspondent interrupt controller, this is needed to
> perform switching to a new LPC32xx MIC/SIC interrupt controller driver.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
> Changes from v2 to v3:
> * fix io region size for MIC controller after moving SIC1/SIC2
>   controllers out,
> * move MIC 'reg' property up to follow 'compatible' property.
> 
> Changes from v1 to v2:
> * squashed two step change in lpc32xx.dtsi - new irqchip driver can be
>   used (i.e. board boots with access to userspace) with old DTS file,
>   so there is no need to fix DTS firstly and then switch to a new driver,
> * removed "interrupt-controller-name" and "wakeup-sources" properties
>   from all interrupt controllers,
> * removed outdated comment.
> 
>  arch/arm/boot/dts/lpc32xx.dtsi | 60 +++++++++++++++++++++++++++++-------------
>  1 file changed, 42 insertions(+), 18 deletions(-)
> 
Please use capital letter for the word ARM in the patch title.

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

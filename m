From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jun 2018 11:17:34 -0600
Subject: [PATCH V3 1/5] dt-bindings: mailbox: allow mbox-cells to be
 equal to 0
In-Reply-To: <1529676720-7533-2-git-send-email-aisheng.dong@nxp.com>
References: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
 <1529676720-7533-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180625171734.GA20153@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 10:11:56PM +0800, Dong Aisheng wrote:
> Mailbox devices may have only one channel which means the mbox-cells
> at least 1 does not make sense for this type devices. Let's remove
> that limitation to allow the mbox-cells to be equal to 0.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
>  * New patch introduced in v3 series
>  * Actually there're already users in kernel with mbox-cells set to 0.
>    See:
>    arch/arm/boot/dts/bcm283x.dtsi:145: #mbox-cells = <0>;
> ---
>  Documentation/devicetree/bindings/mailbox/mailbox.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

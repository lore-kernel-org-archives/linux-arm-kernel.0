From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 17:07:41 +0000
Subject: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
In-Reply-To: <1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201303261707.41563.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> +              mpic: main-intc at d0020000 {
> +                    #interrupt-cells = <1>;
> +                    interrupt-controller;
> +              };
> +
> +              msi: msi-intc at d0020000 {
> +                    #interrupt-cells = <1>;
> +                    interrupt-controller;
> +                    marvell,doorbell = <0xd0020a04>;
> +              };

I think the @d0020000 part needs to be removed for the nodes that
have no reg property.

I think I did not follow the entire discussion. What has led to having
two subnodes in the end, rather than a single node like this?


       interrupt-controller at d0020000 {
              compatible = "marvell,mpic";
              #interrupt-cells = <1>;
              #msi-cells = <1>;
              #address-cells = <1>;
              #size-cells = <1>;
              interrupt-controller;
              msi-controller;
              reg = <0xd0020a00 0x1d0>,
                     <0xd0021070 0x58>;
              marvell,doorbell = <0xd0020a04>;
       };


	Arnd

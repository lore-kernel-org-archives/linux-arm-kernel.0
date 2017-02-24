From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 24 Feb 2017 01:59:23 +0100
Subject: [PATCH 08/11] ARM: dts: Prepare Actions Semi S500 and LeMaker
 Guitar
In-Reply-To: <20170215165528.10052-9-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
 <20170215165528.10052-9-afaerber@suse.de>
Message-ID: <61878112-690f-ca5d-152b-68196f563e83@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.02.2017 um 17:55 schrieb Andreas F?rber:
> +		gic: interrupt-controller at b0021000 {
> +			compatible = "arm,cortex-a9-gic";
> +			reg = <0xb0021000 0x1000>,
> +			      <0xb0020100 0x0100>;
> +		};

This was lacking:

			interrupt-controller;
			#interrupt-cells = <3>;

leading to a hang when mapping an irq.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)

From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Feb 2015 19:06:02 +0000
Subject: amba uarts - arm type uarts fifo size provided by device tree
In-Reply-To: <1424285593-2886-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1424285593-2886-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <20150218190601.GI29429@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please Cc lakml for patches in this area in future.

On Wed, Feb 18, 2015 at 06:53:11PM +0000, Jorge Ramirez-Ortiz wrote:
> [PATCH 1/2] Documentation: bindings: add optional fifo size property
> [PATCH 2/2] drivers/tty: pl011: read fifo size from OF if present
> 
> 
> These patches aim at resolving an issue present on some of the amba pl011
> uarts.  

Which systems are affected? Neither of your two patches add the property
to any dts file.

> Some of these arm type uarts have their fifo sizes not defined in terms of the
> amba_rev register. 

What does said register actually contain?

Is this a full PL011, or a cut-down SBSA UART?

Mark.

> Those uarts should be able to declare their fifo sizes using the optional
> property "fifo-size" in the device tree. This device tree setting shall take
> precedence over any other values. 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

From: timur@tabi.org (Timur Tabi)
Date: Wed, 20 Mar 2013 20:35:42 -0500
Subject: [PATCH] Sound: sgtl5000 Allow codec clock frequency to be set.
In-Reply-To: <20130319170322.27828.7691.stgit@localhost>
References: <20130319170322.27828.7691.stgit@localhost>
Message-ID: <514A63EE.7000707@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Fuzzey wrote:
> +If a clock is provided, clock-frequency is optional
> +
> +If no clock is provided clock-frequency is required (this represents the codec
> +being clocked by an external signal not present in the clock tree)
> +
> +If both a clock and clock-frequency are provided the clock's rate will be set.
> +
> +
>   Example:
>
>   codec: sgtl5000 at 0a {
>   	compatible = "fsl,sgtl5000";
>   	reg = <0x0a>;
> +	clock-frequency = <20000000>;
> +	clocks = <&clks 162>; /* cko1 */

The code looks okay, but I'm not sure this example is right.  The binding 
says that clock-frequency is optional if 'clocks' is provided, but here 
you list both.  You should probably have two examples.

-- 
Timur Tabi

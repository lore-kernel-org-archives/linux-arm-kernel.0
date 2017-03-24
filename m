From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 24 Mar 2017 15:28:54 +0100
Subject: [PATCH v3 1/4] gpio: mvebu: Add limited PWM support
In-Reply-To: <20170324141815.7252-2-ralph.sennhauser@gmail.com>
References: <20170324141815.7252-1-ralph.sennhauser@gmail.com>
 <20170324141815.7252-2-ralph.sennhauser@gmail.com>
Message-ID: <20170324142854.GJ28518@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	if (val < state->duty_cycle)
> +		state->period = 1;
> +	else {
> +		val -= state->duty_cycle;
> +		if (val > UINT_MAX)
> +			state->period = UINT_MAX;
> +		else if (val)
> +			state->period = val;
> +		else
> +			state->period = 1;
> +	}

Hi Ralph

The coding style guide says that if one side of an if else clause has
{}, the other side must as well, even if it is a single statement.

    Andrew

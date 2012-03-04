From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 4 Mar 2012 15:26:48 +0100
Subject: [PATCH v5 4/4] clk: basic clock hardware types
In-Reply-To: <1330763341-3437-5-git-send-email-mturquette@linaro.org>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
 <1330763341-3437-5-git-send-email-mturquette@linaro.org>
Message-ID: <20120304142648.GB11546@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +#define DEFINE_CLK_GATE(_name, _parent_name, _parent_ptr,	\
> +				_flags, _reg, _bit_idx,		\
> +				_gate_flags, _lock)		\
> +	static struct clk _name;				\
> +	static char *_name##_parent_names[] = {			\
> +		_parent_name,					\
> +	};							\
> +	static struct clk *_name##_parents[] = {		\
> +		_parent_ptr,					\
> +	};							\
> +	static struct clk_gate _name##_hw = {			\
> +		.hw = {						\
> +			.clk = &_name,				\
> +		},						\
> +		.reg = _reg,					\
> +		.bit_idx = _bit_idx,				\
> +		.flags = _gate_flags				\

Hi Mike

Looks like a , is missing here after _gate_flags.

      Andrew

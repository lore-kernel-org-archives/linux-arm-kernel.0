From: davem@davemloft.net (David Miller)
Date: Mon, 10 Feb 2014 14:40:54 -0800 (PST)
Subject: [PATCH v2 1/3] net: stmmac:sti: Add STi SOC glue driver.
In-Reply-To: <1391770525-24349-1-git-send-email-srinivas.kandagatla@st.com>
References: <1391770455-24291-1-git-send-email-srinivas.kandagatla@st.com>
 <1391770525-24349-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20140210.144054.2066120014050984537.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: <srinivas.kandagatla@st.com>
Date: Fri, 7 Feb 2014 10:55:25 +0000

> +		if (dwmac->interface == PHY_INTERFACE_MODE_MII ||
> +			dwmac->interface == PHY_INTERFACE_MODE_GMII) {

This is not indented correctly, the first character on the second line should
line up exactly at the column after the openning parenthesis on the first
line.

The objective is not to indent using only TAB characters, which you
are doing here.

Rather, the objective is to use the appropriate number of TAB _and_
space characters necessary to reach the proper column.

> +		const char *rs;
> +		err = of_property_read_string(np, "st,tx-retime-src", &rs);

Please add an empty line after the local variable declaration.

> +		if (!strcasecmp(rs, "clk_125"))
> +			dwmac->is_tx_retime_src_clk_125 = true;
> +
> +	}

That empty line is superfluous, please delete it.

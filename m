From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 8 Dec 2016 18:29:23 +0100
Subject: [PATCH 1/3] rtc: armada38x: improve RTC errata implementation
In-Reply-To: <20161208171010.29446-2-gregory.clement@free-electrons.com>
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
 <20161208171010.29446-2-gregory.clement@free-electrons.com>
Message-ID: <20161208172923.GQ26852@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +struct str_value_to_freq {
> +	unsigned long value;
> +	u8 freq;
> +} __packed;
> +
> +static unsigned long read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
> +{
> +	unsigned long value_array[SAMPLE_NR], i, j, value;
> +	unsigned long max = 0, index_max = SAMPLE_NR - 1;
> +	struct str_value_to_freq value_to_freq[SAMPLE_NR];

Hi Gregory

This appears to be putting over 900 bytes on the stack. Is there any
danger of overflowing the stack? Would it be safer to make these
arrays part of armada38x_rtc?

       Andrew

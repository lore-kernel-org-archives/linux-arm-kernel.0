From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 02:40:36 +0200
Subject: [PATCH 15/18] dmaengine/amba-pl08x: Pass flow controller
	information with slave channel data
In-Reply-To: <2f6001455c4e54f56716a245c7e319eb25a9bb0d.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<2f6001455c4e54f56716a245c7e319eb25a9bb0d.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2MqrKxPDzCUtTVH8DrBR2JqcsyFpr-9ppS1=iR3uAPs2Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

I have the same comment as Russell basically:

> @@ -65,6 +69,7 @@ struct pl08x_channel_data {
> ? ? ? ?int max_signal;
> ? ? ? ?u32 muxval;
> ? ? ? ?u32 cctl;
> + ? ? ? u32 fc;

bool device_fc;

or similar. Then encode the necessary bits if the device controls
flow, and fall back to default (DMAC control) otherwise.

> ? ? ? ?dma_addr_t addr;
> ? ? ? ?bool circular_buffer;
> ? ? ? ?bool single;
> --
> 1.7.2.2

Thanks,
Linus Walleij

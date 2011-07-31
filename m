From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 30 Jul 2011 22:36:48 -0700
Subject: [PATCH 15/18] dmaengine/amba-pl08x: Pass flow controller
	information with slave channel data
In-Reply-To: <CAKnu2MqrKxPDzCUtTVH8DrBR2JqcsyFpr-9ppS1=iR3uAPs2Og@mail.gmail.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<2f6001455c4e54f56716a245c7e319eb25a9bb0d.1311936524.git.viresh.kumar@st.com>
	<CAKnu2MqrKxPDzCUtTVH8DrBR2JqcsyFpr-9ppS1=iR3uAPs2Og@mail.gmail.com>
Message-ID: <CAOh2x=n1FWvDX9n7RJwQJjm3+mnWJe5kAYdOg0nZ2D7BVt4nmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/30/11, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/7/29 Viresh Kumar <viresh.kumar@st.com>:
>
> I have the same comment as Russell basically:
>
>> @@ -65,6 +69,7 @@ struct pl08x_channel_data {
>>        int max_signal;
>>        u32 muxval;
>>        u32 cctl;
>> +       u32 fc;
>
> bool device_fc;
>
> or similar. Then encode the necessary bits if the device controls
> flow, and fall back to default (DMAC control) otherwise.
>

Yes. I thought of exactly the same code.

--
viresh

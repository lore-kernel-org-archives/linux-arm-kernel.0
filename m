From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 30 Jul 2011 22:39:03 -0700
Subject: [PATCH 18/18] dmaengine/amba-pl08x: Call pl08x_free_txd() instead
	of calling kfree() directly
In-Reply-To: <CAKnu2MqGpbVSkuuPCZoqXw+8-RVDFFf7ju4pGaGZ9vLOXRLVhQ@mail.gmail.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<90793b4b9824f8152aa4cea07fd91a8ecd3481e8.1311936524.git.viresh.kumar@st.com>
	<CAKnu2MqGpbVSkuuPCZoqXw+8-RVDFFf7ju4pGaGZ9vLOXRLVhQ@mail.gmail.com>
Message-ID: <CAOh2x=ng=wceMtLw21jw1QF_h_zeafNCdp3EYMVxm_nvchL_yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/30/11, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/7/29 Viresh Kumar <viresh.kumar@st.com>:
>
>> pl08x_prep_channel_resources() is calling kfree() directly for txd(). To
>> maintain consistency in code call pl08x_free_txd() instead.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>
> Good idea,
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yet there is a problem with this patch, as pointed by Russell.
pl08x_free_txd() must be called with channel lock taken. Will
check what can be done here.

--
viresh

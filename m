From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 5 Jul 2017 23:37:46 +0200
Subject: [PATCH 2/2] rtc: stm32: add STM32H7 RTC support
In-Reply-To: <1498470689-26829-3-git-send-email-amelie.delaunay@st.com>
References: <1498470689-26829-1-git-send-email-amelie.delaunay@st.com>
 <1498470689-26829-3-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170705213746.6hf5af57ty6wsfgs@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is mostly fine, even if I'm not too happy with the
s/ck_rtc/rtc_ck/.

On 26/06/2017 at 11:51:29 +0200, Amelie Delaunay wrote:
> -	rtc->ck_rtc = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(rtc->ck_rtc)) {
> -		dev_err(&pdev->dev, "no ck_rtc clock");
> -		return PTR_ERR(rtc->ck_rtc);
> +	match = of_match_device(stm32_rtc_of_match, &pdev->dev);
> +	if (match && match->data)
> +		rtc->data = (struct stm32_rtc_data *)match->data;
> +	else
> +		return -EINVAL;

This will never happen, you can remove that test.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

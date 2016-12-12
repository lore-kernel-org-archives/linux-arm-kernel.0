From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Mon, 12 Dec 2016 10:59:51 +0100
Subject: [PATCH 3/8] rtc: add STM32 RTC driver
In-Reply-To: <20161207183709.tbkapu34ljlg4skp@piout.net>
References: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
 <1480687801-19525-5-git-send-email-amelie.delaunay@st.com>
 <20161202175646.GA3284@linaro.org>
 <15bea9e9-adcc-edb0-1bd1-33d395c72eec@st.com>
 <20161207183709.tbkapu34ljlg4skp@piout.net>
Message-ID: <a2d3ddc0-c8f6-0f42-ad33-a92e0ac6aee4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On 12/07/2016 07:37 PM, Alexandre Belloni wrote:
> On 05/12/2016 at 10:43:14 +0100, Amelie DELAUNAY wrote :
>>>> +
>>>> +    device_init_wakeup(&pdev->dev, true);
>>>
>>> What happens if device_init_wakeup() returns an error?
>> It means that RTC won't be able to wake up the board with RTC alarm. I can
>> add a warning for the user in this case ?
>>>
>
> There is exactly one driver ever checking the return value of
> device_init_wakeup(). It basically always succeeds.
>
>
OK so, is it OK for everyone that I bet on the fact that it will always 
succeed?

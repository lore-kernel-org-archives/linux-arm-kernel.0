From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 7 Dec 2016 19:37:09 +0100
Subject: [PATCH 3/8] rtc: add STM32 RTC driver
In-Reply-To: <15bea9e9-adcc-edb0-1bd1-33d395c72eec@st.com>
References: <1480687801-19525-2-git-send-email-amelie.delaunay@st.com>
 <1480687801-19525-5-git-send-email-amelie.delaunay@st.com>
 <20161202175646.GA3284@linaro.org>
 <15bea9e9-adcc-edb0-1bd1-33d395c72eec@st.com>
Message-ID: <20161207183709.tbkapu34ljlg4skp@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2016 at 10:43:14 +0100, Amelie DELAUNAY wrote :
> >> +
> >> +    device_init_wakeup(&pdev->dev, true);
> >
> > What happens if device_init_wakeup() returns an error?
> It means that RTC won't be able to wake up the board with RTC alarm. I can
> add a warning for the user in this case ?
> >

There is exactly one driver ever checking the return value of
device_init_wakeup(). It basically always succeeds.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

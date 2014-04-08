From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 08 Apr 2014 18:27:02 +0200
Subject: mx27 running too slow
In-Reply-To: <CAOMZO5Ax9zymvSdts0=VTk05P7h6BxzO4MmEZ615h1npe=QY9A@mail.gmail.com>
References: <CAOMZO5CC1NwP14H7uuygX7ZviFJLriG41hyczzvzxYWKHJu5DQ@mail.gmail.com>	<CAOMZO5AUemi9r_NqXXpnYZUqbqHhYnSvrnmu11voM_MZsVUa6Q@mail.gmail.com>	<CAOMZO5CCst0HHWa5JO-8-T3AHiw68FUvKRgCiVvFBu=9JdJzjw@mail.gmail.com>	<1396967505.692277642@f295.i.mail.ru>
 <CAOMZO5Ax9zymvSdts0=VTk05P7h6BxzO4MmEZ615h1npe=QY9A@mail.gmail.com>
Message-ID: <53442356.5040604@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2014 06:22 PM, Fabio Estevam wrote:
>> Calibrating delay loop (skipped), value calculated using timer frequency.. 29.55 BogoMIPS (lpj=147777)
>>
>> Can you inspect code with "git-bisect"?
> 
> This is the result:
> 
> $ git bisect bad
> 1119c84aa3053bd415ba731ada1ecef24c8f82a2 is the first bad commit
> commit 1119c84aa3053bd415ba731ada1ecef24c8f82a2
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Wed Jan 22 12:35:44 2014 +0100
> 
>     ARM: imx: enable delaytimer on the imx timer
> 
>     The imx can support timer-based delays, so implement this.
>     Skips past jiffy calibration.
> 
>     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 

The BogoMIPS output is different and based on the timer clock. The
delay loop now check the timer instead of counting cycles / loops.
The different output is not a bug.

Sebastian

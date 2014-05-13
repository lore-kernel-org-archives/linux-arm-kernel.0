From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 13 May 2014 18:28:22 +0200
Subject: [PATCH] serial: st-asc: Fix data corruption during long console
 bursts
In-Reply-To: <1399997337-27950-1-git-send-email-daniel.thompson@linaro.org>
References: <1399997337-27950-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <53724826.9000907@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 05/13/2014 06:08 PM, Daniel Thompson wrote:
> On my test platform (B2020/STiH416) the serial port issues bad characters
> during the initial message avalanche as the console comes up. The problem
> also occurs when dense(ish) I/O is done using the polled I/O interface.
>
> The problem is fixed for me by using the FIFO half-empty bit rather than
> FIFO full bit. Note that using the half-empty bit causes the FIFO to be
> managed in a similar way to interrupt based I/O (i.e. where the hardware
> gets best test coverage).
>
> Running the FIFO half full will have no impact (good or bad) on console
> performance. The UART will still remain fully saturated and the busy-wait
> until the FIFO is empty in asc_console_write() will complete at the same
> time.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>   drivers/tty/serial/st-asc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime

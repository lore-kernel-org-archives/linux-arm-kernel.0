From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 24 Aug 2017 11:16:11 -0300
Subject: [PATCH] rtc: mxc: avoid disabling interrupts on device close
In-Reply-To: <20170823220024.22861-1-alexandre.belloni@free-electrons.com>
References: <20170823220024.22861-1-alexandre.belloni@free-electrons.com>
Message-ID: <CAOMZO5B2MxGt8DnXU8v1DG9LdbvxyN0FFDJm=dTO=18i=1r4mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 7:00 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Currently, the IRQs are disabled when the rtc character device is closed.
> This means that the device needs to stay open to get alarms while the usual
> use case will open the device, set the alarm and close the device as is
> done in rtcwake.
>
> Keep the alarm functional on character device release so the platform can
> actually wakeup
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Makes sense, thanks:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 22 Mar 2013 16:00:26 -0300
Subject: [PATCH v3 1/1 net-next] net: fec: put tx to napi poll function to
 fix dead lock
In-Reply-To: <20130320114824.GA6088@S2101-09.ap.freescale.net>
References: <1362368065-5809-1-git-send-email-Frank.Li@freescale.com>
 <20130320114824.GA6088@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5B-ipzyb2uiLW12fFd3PD3JfLS8R0YLM5vtLgFNz8abUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 8:48 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Frank,
>
> I'm running v3.9-rc3 image with NFS on imx6q, and seeing system fail
> to resume back.  The resume seems being stopped by fec driver.  If you
> wait long enough, you might see the repeated "eth0: tx queue full!."
> error message.

On mx28, only reverting this patch does not solve the suspend/resume issue.

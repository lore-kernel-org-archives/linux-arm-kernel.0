From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 29 Oct 2013 10:06:04 +0800
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <CAOesGMijji0JBJqne_j8kPedYFF82U7fh7KS92PV1hJztJXE6w@mail.gmail.com>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
 <CAOesGMjB6D3owftDUfmMbVNx8_EtY9-RXoGbS3Rmry4FQhSfZQ@mail.gmail.com>
 <20131028081408.GF2839@S2101-09.ap.freescale.net>
 <CAOesGMijji0JBJqne_j8kPedYFF82U7fh7KS92PV1hJztJXE6w@mail.gmail.com>
Message-ID: <20131029020603.GH2839@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 10:46:02AM -0700, Olof Johansson wrote:
> By the way, the errata document says that you must write it twice
> within one 32kHz clock period. You might want to write it three times
> just in case two of them happen to straddle that period by pure bad
> luck. I'm guessing it's rare enough that you haven't been able to
> reproduce it though.

With CPU running at hundred MHz, two writes in the row should not
straddle one 32kHz clock period - 31.25 us.

Shawn

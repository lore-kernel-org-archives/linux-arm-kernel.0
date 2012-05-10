From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 19:49:58 +0800
Subject: [PATCH V2 08/11] ARM: dts: imx6q-sabrelite: add sound device
 imx6q-sabrelite-sgtl5000
In-Reply-To: <20120510094508.GN3908@opensource.wolfsonmicro.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-9-git-send-email-richard.zhao@freescale.com>
 <20120510064816.GC17875@S2101-09.ap.freescale.net>
 <20120510093444.GI2982@b20223-02.ap.freescale.net>
 <20120510094113.GG17875@S2101-09.ap.freescale.net>
 <20120510094508.GN3908@opensource.wolfsonmicro.com>
Message-ID: <20120510114956.GI17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 10:45:08AM +0100, Mark Brown wrote:
> On Thu, May 10, 2012 at 05:41:15PM +0800, Shawn Guo wrote:
> 
> > The "Mic Bias" here is really a SGTL5000 internal supply.
> 
> If it is then what's providing the bias to the mic?  It's common for
> chips to have a micbias supply which comes out of the chip and is used
> by mics, this is my understanding of what this circuit is.

I did not make myself clear, but you made :)  Yes, this is exactly the
thing on my mind, and the circuit will look like:

     STGTL5000        BOARD
		|
      MIC_IN ---+--- JACK
	^	|     ^
	|	|     |
	|	|     |
    MIC_BAIS----+-----/
		|

Isn't you helped me create this understanding? [1]

Regards,
Shawn

[1] http://article.gmane.org/gmane.linux.alsa.devel/96351

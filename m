From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 27 Nov 2015 15:22:23 +0100
Subject: [PATCH] mmc: sdhci-of-at91: controller is suspended too early
In-Reply-To: <CAPDyKFpuemq05PZN6-p9gY6qvm23Fkxvr3u=4_xXPbBHeq4CRg@mail.gmail.com>
References: <1448556091-502-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFpuemq05PZN6-p9gY6qvm23Fkxvr3u=4_xXPbBHeq4CRg@mail.gmail.com>
Message-ID: <20151127142223.GA11016@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 03:11:58PM +0100, Ulf Hansson wrote:
> On 26 November 2015 at 17:41, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > When calling sdhci_add_host(), the controller is already suspended. It
> > causes to read 0 in registers.
> > Increment the device's usage counter before calling sdhci_add_host(),
> > decrement it after and put it in suspend if it is possible.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > Fixes: "mmc: sdhci-of-at91: add PM support"
> 
> Thanks, applied for next!
> 
> Actually I decided to squash this change into the "Fixes commit"
> itself, thus not breaking bisecting.

Ok perfect. Thanks

Regards

Ludovic

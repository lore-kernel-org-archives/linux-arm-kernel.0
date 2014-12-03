From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 3 Dec 2014 09:22:05 +0100
Subject: [PATCH v4 0/4] mmc: atmel-mci: cleanup and probe deferring
In-Reply-To: <CAPDyKFpuDOfw9BtYJhG0Fz6PsqUQP=gBg+4mWt9MRy_S6Yga5w@mail.gmail.com>
References: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFpuDOfw9BtYJhG0Fz6PsqUQP=gBg+4mWt9MRy_S6Yga5w@mail.gmail.com>
Message-ID: <20141203082205.GW2714@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 11:10:53AM +0100, Ulf Hansson wrote:
> On 1 December 2014 at 15:35, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > Hi Ulf,
> >
> > Same as previous series, based on your next branch, and no errors with
> > checkpatch so let me know if you still have troubles to apply my patches.
> >
> > Changes from v3:
> > - keep __init/__exit attributes for atmci_init/exit
> > - remove useless variable in atmci_configure_dma function
> >
> > Ludovic Desroches (4):
> >   mmc: atmel-mci: remove useless DMA stuff for non-dt devices
> >   mmc: atmel-mci: remove __init/__exit attributes
> >   mmc: atmel-mci: stop using specific initcall
> >   mmc: atmel-mci: use probe deferring if dma controller is not ready yet
> >
> >  drivers/mmc/host/atmel-mci.c | 76 ++++++++++++++++----------------------------
> >  1 file changed, 28 insertions(+), 48 deletions(-)
> 
> Thanks! Applied for next.
> 
> Patch 4, did have a minor checkpatch warning. I fixed it.

Thanks, yes I see it but I feel it is a bit too constraining when you already
have a function name doing 32 characters :p

> 
> Kind regards
> Uffe

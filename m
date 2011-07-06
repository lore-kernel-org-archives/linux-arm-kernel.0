From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 5 Jul 2011 23:12:16 -0400 (EDT)
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <CAGsJ_4xfZvZcXCfRk==iVmc-_GsyavB+cmnKztEvmRx-VLbLPg@mail.gmail.com>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<CAGsJ_4xfZvZcXCfRk==iVmc-_GsyavB+cmnKztEvmRx-VLbLPg@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1107052308340.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Barry Song wrote:

> 2011/7/6 Nicolas Pitre <nicolas.pitre@linaro.org>:
> > Having this value defined at compile time prevents multiple machines with
> > conflicting definitions to coexist. ?Move it to a variable in preparation
> > for having a per machine value selected at run time. ?This is relevant
> > only when CONFIG_ZONE_DMA is selected.
> >
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> that is definitely good. i am not sure whether it will be better if
> dma zone becomes a property in memory node of DT.

Certainly.  But one thing at a time.  This is the first step. Then, 
those machines that are converted to DT could more easily provide the 
information via this mechanism if they so desire.


Nicolas

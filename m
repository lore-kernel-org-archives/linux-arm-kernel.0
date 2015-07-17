From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 17 Jul 2015 14:38:24 +0530
Subject: [PATCH v3 2/2] dma: Add Xilinx zynqmp dma engine driver support
In-Reply-To: <CAGnW=BYbBnngujcMuEf3=jvra6DiBmN1xhM9DBPmXoa83xLSJw@mail.gmail.com>
References: <CAHLkNH+VLccurDfxEnwSEbr9YFv8ymZuibci7TW=WPutL7qbAQ@mail.gmail.com>
 <CAGnW=BbUBOzm5V_LP_YcCfJ9X+Yw8qGp6PE2xSM13E=qUXxUsw@mail.gmail.com>
 <20150717030545.GB5086@localhost>
 <CAGnW=BYbBnngujcMuEf3=jvra6DiBmN1xhM9DBPmXoa83xLSJw@mail.gmail.com>
Message-ID: <20150717090824.GF5086@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 09:54:48AM +0530, punnaiah choudary kalluri wrote:
your MUA is wrapping lines funny, please fix it

> >> I have explored using the virt-dma to reduce the common list processing, But
> >> in this driver descriptor processing and cleaning is happening inside
> >> the tasklet
> >> context and virt-dma assumes it is happening in interrupt context and using the
> >> spin locks accordingly. So, added code for the list management in side
> >> the driver.
> > And why would it bother you. There is a reson for that, it tries to submit
> > next txn as soon as possible, which is the right thing
> We have implemented hw descriptor queuing in tx_submit function, so
> controller can process descriptors with out interruption. We want to
> minimize disabling all the interrupts for the purpose of submitting new
> req or cleaning the descriptors.  Also if we adopt virt-dma, need to
> override the  tx_submit function So, decided to go with any one cleaner
> approach.
okay this doesnt seem right, tx_submit is supposed to submit the descriptor
to pending queue fo the driver (sw) and then issue pending will push it.
The is the flow as expected and documented by dmanegine API, please follow
that

And to follow you will get a tons of help from vchan

-- 
~Vinod

From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 24 Feb 2014 10:05:54 -0800
Subject: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <20140224174021.GA18563@joshc.qualcomm.com>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
 <92B0AE30-5CDF-43FC-8588-EEF0C5F86266@codeaurora.org>
 <1393237990.6481.15.camel@iivanov-dev>
 <20140224174021.GA18563@joshc.qualcomm.com>
Message-ID: <20140224180554.GE32621@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 24 Feb 09:40 PST 2014, Josh Cartwright wrote:

> On Mon, Feb 24, 2014 at 12:33:10PM +0200, Ivan T. Ivanov wrote:
> > On Fri, 2014-02-21 at 09:35 -0600, Kumar Gala wrote: 
> > > On Feb 20, 2014, at 6:38 PM, Bjorn Andersson <bjorn.andersson@sonymobile.com> wrote:
> > > 
> > > > This bus driver supports the QUP i2c hardware controller in the Qualcomm SOCs.
> > > > The Qualcomm Universal Peripheral Engine (QUP) is a general purpose data path
> > > > engine with input/output FIFOs and an embedded i2c mini-core. The driver
> > > > supports FIFO mode (for low bandwidth applications) and block mode (interrupt
> > > > generated for each block-size data transfer).
> > > > 
> > > > Cc: Andy Gross <agross@codeaurora.org>
> > > > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > > > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > > > ---
> > > > +config I2C_QUP
> > > > +	tristate "Qualcomm QUP based I2C controller"
> > > > +	depends on ARCH_MSM
> > > 
> > > ARCH_QCOM
> > 
> > There is no such symbol, still.
> 
> For what it's worth, the rename/split is in linux-next, and will land in
> 3.15 (as part of arm-soc cleanups).
> 
> Is the (short-term) problem of the lack of the symbol a problem?  Worse
> case, this driver lands before the ARCH_QCOM rename lands, and the
> driver is just not selectable.  Only when both are in place can the
> driver be selected.

As it's best case that this driver lands at the same time as that cleanup I do
agree. I'll "rebase" this ontop of Kumar's series for the next revision.

Regards,
Bjorn

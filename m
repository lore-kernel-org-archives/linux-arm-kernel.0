From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 22 Aug 2016 09:03:58 -0500
Subject: [PATCH v2] arm64: dts: qcom: Fix broken interrupt trigger settings
In-Reply-To: <57BAD2B5.3030800@arm.com>
References: <1470937850-10492-1-git-send-email-marc.zyngier@arm.com>
 <57BAD2B5.3030800@arm.com>
Message-ID: <20160822140358.GB30923@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 11:23:49AM +0100, Marc Zyngier wrote:
> Hi Andy,
> 
> On 11/08/16 18:50, Marc Zyngier wrote:
> > When a device uses the GIC as its interrupt controller and generates
> > SPIs, only the values 1 (edge rising) and 4 (level high) are legal.
> > 
> > Anything else is just plain wrong (can't be programmed into the HW),
> > and leads to aborted driver probes (USB doesn't work with 4.8-rc1
> > on a Dragonboard 410C).
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> > * From v1:
> >   - Fixed USB interrupts after review from Stephen
> 
> Any update on this?

Yeah I picked this up.  Thanks for the fix.

Andy

From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Apr 2013 11:29:49 +0100
Subject: [PATCH 1/2] mfd: db8500-prcmu: Return early if the TCPM cannot
 be located
In-Reply-To: <20130409100510.GP24058@zurbaran>
References: <1365071941-23475-1-git-send-email-lee.jones@linaro.org>
 <20130409100510.GP24058@zurbaran>
Message-ID: <20130409102949.GC25316@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Apr 2013, Samuel Ortiz wrote:

> Hi Lee,
> 
> On Thu, Apr 04, 2013 at 11:39:00AM +0100, Lee Jones wrote:
> > Currently we check to see if we obtained the Tightly Coupled Program
> > Memory (TCPM) base and only execute the code within the check if we
> > have it. It's more traditional to return early if we don't have it.
> > This way we can flatten most of the function's code down to a single
> > tab spacing.
> > 
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/db8500-prcmu.c |   40 +++++++++++++++++++++-------------------
> >  1 file changed, 21 insertions(+), 19 deletions(-)
> I had to apply this one manually, please check if it was done correctly from
> my mfd-next tree.

Yes, looks good.

I think it was only 'db8500_prcmu_early_init()' and the line numbers
which confused it.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

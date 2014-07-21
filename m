From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Jul 2014 08:46:27 +0100
Subject: [PATCH v2 4/4] mfd: pm8921: rename pm8921-core driver
In-Reply-To: <CABu_nUQDWbejZcQqFSJMhCokeMJXBcsCpsiJxz4gBsmtKiyivA@mail.gmail.com>
References: <1405613855-27572-1-git-send-email-svarbanov@mm-sol.com>
 <1405613855-27572-5-git-send-email-svarbanov@mm-sol.com>
 <CABu_nUQDWbejZcQqFSJMhCokeMJXBcsCpsiJxz4gBsmtKiyivA@mail.gmail.com>
Message-ID: <20140721074627.GT30888@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jul 2014, Prakash Burla wrote:
> On Thu, Jul 17, 2014 at 9:47 PM, Stanimir Varbanov <svarbanov@mm-sol.com> wrote:
> > The pm8921-core driver presently supports pm8921 and pm8058
> > Qualcomm PMICs.  To avoid confusion with new generation PMICs
> > (like pm8941) rename the pm8921-core driver to more
> > appropriate name pm8xxx-ssbi, which reflects better that
> > those chips use SSBI interface.
> >
> > Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> > ---
> >  drivers/mfd/Kconfig                          |   14 +++++-----
> >  drivers/mfd/Makefile                         |    2 +-
> >  drivers/mfd/{pm8921-core.c => pm8xxx-ssbi.c} |   38 +++++++++++++-------------
> >  3 files changed, 27 insertions(+), 27 deletions(-)
> >  rename drivers/mfd/{pm8921-core.c => pm8xxx-ssbi.c} (92%)
>  .
>  [Nope]

What does this mean?

> >  MODULE_LICENSE("GPL v2");
> > -MODULE_DESCRIPTION("PMIC 8921 core driver");
> > +MODULE_DESCRIPTION("PMIC PM8XXX SSBI driver");
> >  MODULE_VERSION("1.0");
> > -MODULE_ALIAS("platform:pm8921-core");
> > +MODULE_ALIAS("platform:pm8xxx-ssbi");
>  >How about adding the module author as svarbanov at mm-sol.com/qcom?
>       MODULE_AUTHOR("SVARBANOV<svarbanov@mm-sol.com>");

Module author has the same standards as Git author.

MODULE_AUTHOR("Stanimir Varbanov <svarbanov@mm-sol.com>");

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

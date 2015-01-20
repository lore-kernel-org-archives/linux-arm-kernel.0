From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Jan 2015 14:00:32 +0800
Subject: [PATCH 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <CAOMZO5DB1QSg4G9mnWbS_ypQabFaJ8z-a4sR3Cj5cnq75atRKw@mail.gmail.com>
References: <1420559265-7333-1-git-send-email-p.zabel@pengutronix.de>
 <1420559265-7333-3-git-send-email-p.zabel@pengutronix.de>
 <20150108130003.GE4928@dragon>
 <CAOMZO5DB1QSg4G9mnWbS_ypQabFaJ8z-a4sR3Cj5cnq75atRKw@mail.gmail.com>
Message-ID: <20150120060030.GO2766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 02:54:24PM -0200, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Thu, Jan 8, 2015 at 11:00 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > Before I start reviewing the patch, I would like to know if there is a
> > formal errata for this issue, including the bug description, recommended
> > workaround, and affected i.MX6 variants etc.
> 
> The latest mx6 reference manual available on the web shows the LDB
> clock gate in the correct position now.
> 
> It also adds the following note:
> 
> "NOTE: This clock path is not controlled by a clock gate (CG). For
> proper clock switching procedures refer to the Clock Switching
> Multiplexers section."

No.  The Clock Switching Multiplexers section documents the procedure
for the glitchy multiplexer with a clock gate in the right place, not
this buggy LDB multiplexer.

> 
> There is no formal errata available.
> 
> Please consider reviewing this series, as it addresses a real problem
> that affect many users.

I'm not going to review/take the patch until I see a formal errata
documenting the software workaround procedure for the issue.

Shawn

From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 May 2016 15:16:58 +0100
Subject: [PATCH 2/5] remoteproc: core: Add rproc OF look-up functions
In-Reply-To: <20160506184842.GE1256@tuxbot>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
 <1462454983-13168-3-git-send-email-lee.jones@linaro.org>
 <20160506184842.GE1256@tuxbot>
Message-ID: <20160510141658.GP19473@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 06 May 2016, Bjorn Andersson wrote:

> On Thu 05 May 06:29 PDT 2016, Lee Jones wrote:
> 
> > - of_rproc_byindex(): look-up and obtain a reference to a rproc
> >   		      using the DT phandle "rprocs" and a index.
> > 
> > - of_rproc_byname():  lookup and obtain a reference to a rproc
> >   		      using the DT phandle "rprocs" and "rproc-names".
> > 
> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> 
> I like the idea of having these helpers, but we already have
> rproc_get_by_phandle() so these helpers should be built upon that rather
> than adding the additional list.

Since this is a framework consideration, don't you think it would be
better to standardise the phandle name?  This is common practice when
coding at a subsystem level.  Some in use examples include; "clocks",
"power-domains", "mboxes", "dmas", "phys", "resets", "gpios", etc.

Considering the aforementioned examples, I figured "rprocs" would be
suitable.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

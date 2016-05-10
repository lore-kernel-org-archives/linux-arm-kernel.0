From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 May 2016 14:02:50 +0100
Subject: [PATCH 3/5] remoteproc: core: Add ability to select a firmware
 from the client
In-Reply-To: <20160506185914.GF1256@tuxbot>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
 <1462454983-13168-4-git-send-email-lee.jones@linaro.org>
 <20160506185914.GF1256@tuxbot>
Message-ID: <20160510130250.GM19473@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 06 May 2016, Bjorn Andersson wrote:

> On Thu 05 May 06:29 PDT 2016, Lee Jones wrote:
> 
> > ST Co-Processors can be loaded with different firmwares to execute
> > specific tasks without the need for unloading the rproc module.
> > 
> 
> I'm very much interested in ideas related to this and who "owns" the
> life cycle of remoteprocs, do you have any code I can take a look at
> that's using this interface?

I was part of a conversation on the list which should explain some of
your queries [0].  The conclusion was, that only the client can know
what which firmware it is compatible with.  This information can not
realistically either live in DT (or any other platform data) or within
RemoteProc.  I hope that link answers your questions.

[0] http://www.spinics.net/lists/devicetree-spec/msg00144.html

> > This patch provides a function which can update the firmware name.
> > 
> > NB: This can only happen if the rproc is offline.
> 
> How is this working in the case when the remoteproc provides vdevs that
> is holding references towards the rproc?
> 
> Do you unload rpmsg et al before doing this?

RemoteProc needs to be offline for the firmware name to be set, this
includes links to RPMsg, so yes, they would have to be unloaded.

> > Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 63 ++++++++++++++++++++++++++++++++++++
> >  include/linux/remoteproc.h           | 13 ++++++++
> >  2 files changed, 76 insertions(+)

Happy with the remainder of your comments -- will fix.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

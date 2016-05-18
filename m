From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 17 May 2016 21:09:43 -0700
Subject: QRTR merge conflict resolution
In-Reply-To: <20160518104320.23ae8557@canb.auug.org.au>
References: <20160510183934.GJ1256@tuxbot> <2606282.lG9qK7uBW0@wuerfel>
 <20160513221909.GC1256@tuxbot>
 <20160517.141154.1511755950068252376.davem@davemloft.net>
 <20160518104320.23ae8557@canb.auug.org.au>
Message-ID: <20160518040943.GO1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 17 May 17:43 PDT 2016, Stephen Rothwell wrote:

> Hi David,
> 
> On Tue, 17 May 2016 14:11:54 -0400 (EDT) David Miller <davem@davemloft.net> wrote:
> >
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Date: Fri, 13 May 2016 15:19:09 -0700
> > 
> > > I have prepared the merge of net-next and the conflicting tag from the
> > > Qualcomm SOC, please include this in your pull towards Linus to avoid
> > > the merge conflict.  
> > 
> > Pulled, thanks.
> 
> Except in the merge resolution, the 2 new functions added to
> include/linux/soc/qcom/smd.h (qcom_smd_get_drvdata and
> qcom_smd_set_drvdata) were not marked "static inline" :-(
> 

How silly of me to miss that, sorry about that.

I didn't spot this in my compile testing either, because this is the
only driver in the tree including that file that doesn't depend on
QCOM_SMD.

As there is no immediate problem with moving forward I suggest that I'll
fix this, through arm-soc, once the code has landed.

Regards,
Bjorn

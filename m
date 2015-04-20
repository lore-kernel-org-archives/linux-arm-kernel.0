From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 20 Apr 2015 14:04:26 +0100
Subject: [PATCH] ata: ahci_st: fixup layering violations / drvdata errors
In-Reply-To: <20150417145558.GD1954@htj.duckdns.org>
References: <1428519599-31885-1-git-send-email-computersforpeace@gmail.com>
 <552627BD.9060109@st.com>
 <20150409094310.GA29026@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150417145558.GD1954@htj.duckdns.org>
Message-ID: <20150420130426.GA906@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

On Fri, 17 Apr 2015, Tejun Heo wrote:
> On Thu, Apr 09, 2015 at 10:43:10AM +0100, Peter Griffin wrote:
> > Yes I can test, although not until Saturday as I only have remote
> > access to the board today & tomorrow and the hard drive isn't
> > plugged in.
> 
> What's the status on this patch?  Should I push it through
> for-4.1-fixes?

The layering violation which Brian identified does need fixing. However
please don't take this patch as it currently is, as it causes a NULL
ptr dereference.

I can send an updated version in a moment which: -
1) Fixes the conflict you will get when applying it for v4.1
   (due to my "st_configure_oob must be called after IP is clocked" patch).

2) Fixes the crash which this patch introduces.

regards,

Peter.

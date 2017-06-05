From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 5 Jun 2017 14:05:15 +0200
Subject: [PATCH v2] misc: atmel-ssc: Handle return value of
 clk_prepare_enable and clk_prepare
In-Reply-To: <20170605093652.4dpeb2ovjehfsxwl@piout.net>
References: <3a6a9ccd68fe298ab33009eaaace85c5af73e1ea.1496381884.git.arvind.yadav.cs@gmail.com>
 <20170603221753.lfiqthuc7dxy3dmc@piout.net>
 <aa38479b-0597-17ca-ab2b-1092ece77d11@gmail.com>
 <20170605093652.4dpeb2ovjehfsxwl@piout.net>
Message-ID: <20170605120515.GB6867@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 11:36:52AM +0200, Alexandre Belloni wrote:
> On 05/06/2017 at 14:53:30 +0530, Arvind Yadav wrote:
> > Hi,
> > 
> > Yes, Patch v1 was wrong that's why i have push v2.
> > clk_prepare and clk_prepare_enable can fail. There
> 
> No this is not true, they will never fail for the SSC.

How is anyone supposed to know this?  Just check the functions correctly
and move on, if they can never fail, wonderful, that's a code path that
is not going to be run.

> > is not harm to check it's return value. It'll not impact present
> > functionality.
> > 
> 
> It does impact boot time, this patch adds 112 bytes to a compressed
> kernel for no reason.

It solves the issue that if someone copy/paste from this code, they will
implement something incorrectly.  You can spare the 112 bytes (which
really, seems very large for just 2 error cases, are you sure that's
right?  Just drop the string if you care about size here.

thanks,

greg k-h

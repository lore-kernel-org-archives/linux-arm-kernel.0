From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 11 Dec 2013 09:17:39 +0000
Subject: [PATCH v3 07/15] mfd: menelaus: Limit the usage of the_menelaus
In-Reply-To: <20131210163220.GE22750@saruman.home>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-7-git-send-email-balbi@ti.com>
 <20131210085701.GP12675@lee--X1>
 <20131210163220.GE22750@saruman.home>
Message-ID: <20131211091739.GB16780@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Dec 2013, Felipe Balbi wrote:

> On Tue, Dec 10, 2013 at 08:57:01AM +0000, Lee Jones wrote:
> > > Pass a menelaus_chip pointer as argument to most functions so we can
> > > minimize the usage of the global the_menelaus pointer.
> > > 
> > > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  drivers/mfd/menelaus.c | 265 ++++++++++++++++++++++++++-----------------------
> > >  1 file changed, 142 insertions(+), 123 deletions(-)
> > 
> > How is this different from patch 6?
> 
> have you read the patch ? patch 6 converts *only* enable/disable irq
> functions.

Well it actually converts menelaus_ack_irq() too, but that's not the
point I was making.

I can see that the 'code' is different, but the functionality of the
patch is the same i.e. converting functions to pass around the
menelaus_chip pointer for eradication of the_menelaus global pointer.

I'm not concerned about the 'lines changed' count. The change your
making is trivial, thus there is no requirement to split unnecessarily
over 5 patches. Please squash them into a single functionality patch.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 11:19:30 -0700
Subject: [PATCH] clk: mvebu: cp110: Fix clock tree representation
In-Reply-To: <87bmfs1a8w.fsf@bootlin.com>
References: <20180228140751.10819-1-gregory.clement@bootlin.com>
 <87bmfs1a8w.fsf@bootlin.com>
Message-ID: <152148357023.242365.11271637218580901412@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2018-03-13 04:32:47)
> Hi,
>  
>  On mer., f?vr. 28 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
> 
> > Thanks to new documentation, we have a better view of the clock tree.
> > There were few mistakes in the first version of this driver, the main one
> > being the parental link between the clocks. Actually the tree is more
> > flat that we though. Most of the IP blocks require two clocks: one for
> > the IP itself and one for accessing the registers, and unlike what we
> > wrote there is no link between these two clocks.
> >
> > The other mistakes were about the name of the clocks: the root clock is
> > not the Audio PLL but the PLL0, and what we called the EIP clock is named
> > the x2 Core clock and is used by other IP block than the EIP ones.
> 
> Do you have any feedback on this patch?
> 
> I would like to have time to address them if you have any remark.
> 
> Else do you want a Pull Request or could you apply it directly?
> 
> The only other patch around the mvebu clocks was set a few days ago [1]
> and seems to be eventually a fix patch. That means that there would be
> only one patch in the Pull Request for 4.17, but I can do it if you
> prefer.
> 

Please don't send single patch PRs. I'll pick this up. Thanks.

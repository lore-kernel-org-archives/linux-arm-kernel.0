From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 30 Jan 2015 10:44:11 +0000
Subject: [PATCH 2/7] pm: at91: pm_suspend: add the WFI support for ARMv7
In-Reply-To: <B256D81BAE5131468A838E5D7A243641BFD3A0C2@penmbx01>
References: <1422266617-24381-1-git-send-email-wenyou.yang@atmel.com>
 <1422266761-24487-1-git-send-email-wenyou.yang@atmel.com>
 <20150128112551.GA13253@e102568-lin.cambridge.arm.com>
 <B256D81BAE5131468A838E5D7A243641BFD38E3C@penmbx01>
 <20150129122223.GA3937@red-moon>
 <B256D81BAE5131468A838E5D7A243641BFD3A0C2@penmbx01>
Message-ID: <20150130104411.GD8787@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 07:23:21AM +0000, Yang, Wenyou wrote:

[...]

> > > > > +	 */
> > > > > +	isb
> > 
> > This isb should not be there, unless you know a reason why it should and you
> > explain it to me.
> I encountered system lock during verifying the pm function. 
> Anyway, I will tested again whether it works after removing it. 

Re-checked the code flow, I see no reason why this isb should be there.
Adding barriers changes code execution, this might paper over some
issues instead of solving them, so every single barrier should be
commented and added with a specific purpose that I do not see here.

Lorenzo

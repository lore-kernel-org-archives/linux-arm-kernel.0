From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 8 Dec 2012 15:59:38 +0400
Subject: Question: Multiple board support is broken
In-Reply-To: <20121208112353.GD14363@n2100.arm.linux.org.uk>
References: <20121207193143.2d2029daf2041683bc7b2474@mail.ru>
 <20121207161754.GV14363@n2100.arm.linux.org.uk>
 <20121208122811.31c7b9b3a57b898c25204252@mail.ru>
 <20121208092618.GB14363@n2100.arm.linux.org.uk>
 <20121208135845.707d9f50ba9b2aaaef66bb3a@mail.ru>
 <20121208103812.GC14363@n2100.arm.linux.org.uk>
 <20121208151859.622041461fd51b347e4b44c3@mail.ru>
 <20121208112353.GD14363@n2100.arm.linux.org.uk>
Message-ID: <20121208155938.8faa133640a42ba33921f7f7@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 8 Dec 2012 11:23:53 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Sat, Dec 08, 2012 at 03:18:59PM +0400, Alexander Shiyan wrote:
> > Well, I understand your position on optimization. Can we at least replace
> > definition machine_arch_type by variable __machine_arch_type, which is passed
> > to the function setup_machine_tags() in setup_arch() procedure? Or have I
> > misunderstood something again?
> 
> Err, no I don't think you have.  Looks like the initial erroring out got
> broken by the addition of DT support and all the changes that happened
> after that.
> 
> Given that the initial assembly code which errored out on non-supported
> platforms seems to have been deleted, that does need to be changed.
> Please send a patch just for that.

Do it now, please check the following patch.

-- 
Alexander Shiyan <shc_work@mail.ru>

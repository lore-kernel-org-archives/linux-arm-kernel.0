From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 13 Dec 2012 11:55:24 +0000
Subject: [PATCH 01/12] regulator: gpio-regulator: Demote GPIO Regulator
 driver to start later
In-Reply-To: <20121210143141.GG6103@opensource.wolfsonmicro.com>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-2-git-send-email-lee.jones@linaro.org>
 <20121210140751.GB6103@opensource.wolfsonmicro.com>
 <20121210142836.GG9362@gmail.com>
 <20121210143141.GG6103@opensource.wolfsonmicro.com>
Message-ID: <20121213115524.GI27617@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Dec 2012, Mark Brown wrote:

> On Mon, Dec 10, 2012 at 02:28:36PM +0000, Lee Jones wrote:
> > On Mon, 10 Dec 2012, Mark Brown wrote:
> 
> > > This really isn't a good solution, especially not for a system that's DT
> > > based - on a DT system we can tell if there should be a GPIO present so
> > > we should be able to defer only when there's something that might
> > > provide the GPIO later on.
> 
> > Understood, but what's the solution for non-DT systems?
> 
> Provide a fixed regulator or something, perhaps we need a "definitely
> does not exist" regulator to help with this.  For every board you help
> with a sequencing bodge you're probably going to break another that
> needs different sequencing; for that matter it's not like GPIO
> controlled regulators are exclusively used for MMC, or that MMC
> exclusively uses GPIO - doing this for only one regulator is a bit of a
> red flag.

I understand your logic, hence why I wrote such a lengthy commit
message. However, I'm not sure I see a logical way around it. Asking
all users of MMCI to provide a not-regulator to declare that a
secondary regulator isn't available seems a little unreasonable to me.

Is there anything else we can do?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog 

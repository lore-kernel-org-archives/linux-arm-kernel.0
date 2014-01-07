From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 7 Jan 2014 14:54:04 +0200
Subject: [PATCH v2 1/6] ARM: tegra: export apb dma readl/writel
In-Reply-To: <52CB0CFE.4070901@wwwdotorg.org>
References: <1387891931-9854-1-git-send-email-pdeschrijver@nvidia.com>
 <1387891931-9854-2-git-send-email-pdeschrijver@nvidia.com>
 <52CB0CFE.4070901@wwwdotorg.org>
Message-ID: <20140107125404.GD26588@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 09:07:26PM +0100, Stephen Warren wrote:
> On 12/24/2013 06:32 AM, Peter De Schrijver wrote:
> > Export APB DMA readl and writel. These are needed because we can't access
> > the fuses directly on Tegra20 without potentially causing a system hang.
> 
> This does a lot more than just export the functions; it also changes the
> prototypes. I'm not sure why the prototype change was required/useful.
> This needs to be mentioned in the commit description/subject, and the
> reasoning explained too.
> 
> > diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
> 
> > +#if defined(CONFIG_TEGRA20_APB_DMA)
> > +void tegra_apb_io_init(void);
> 
> This seems to be an internal function; why is this one publicly
> prototyped and/or stubbed?
> 

Ah. this might be a leftover from a previous iteration... Need to check.

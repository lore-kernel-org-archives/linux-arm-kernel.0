From: koro.chen@mediatek.com (Koro Chen)
Date: Fri, 12 Jun 2015 16:24:48 +0800
Subject: [alsa-devel] [PATCH 1/3] ASoC: mediatek: Add AFE platform driver
In-Reply-To: <1434094677.2271.125.camel@x220>
References: <1433946276-25969-1-git-send-email-koro.chen@mediatek.com>
 <1433946276-25969-2-git-send-email-koro.chen@mediatek.com>
 <1434006187.24094.40.camel@x220> <1434074158.10969.5.camel@mtksdaap41>
 <1434094677.2271.125.camel@x220>
Message-ID: <1434097488.29733.0.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-06-12 at 09:37 +0200, Paul Bolle wrote:
> On Fri, 2015-06-12 at 09:55 +0800, Koro Chen wrote:
> > On Thu, 2015-06-11 at 09:03 +0200, Paul Bolle wrote:
> > > (What does negating a bool twice do?)
> > > 
> > Because bool actually can be unsigned char, although actually in this
> > driver, the caller always passes "true" or "false" to this function.
> 
> bool is _Bool in the kernel (see include/linux/types.h). So whenever you
> see a bool in the kernel you can assume it's either 0 or 1. Are there
> any cases where this conveniently simple rule doesn't hold?
> 
> But here the discussion is moot, because as you say, the function will
> only be passed false or true so we know "enable" is either 0 or 1 and
> double negating will do nothing.
> 
> > Do you think if this is the case, should I still need to do !!?
> 
> So you should not, as it's confusing at best.
> 
OK, thank you. I will drop it in the next version of patch.
> Thanks,
> 
> 
> Paul Bolle
> 

From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 03 Dec 2015 12:07:26 +0100
Subject: [alsa-devel] [PATCH] ASoC: mediatek: Use current HW pointer for
 pointer callback
In-Reply-To: <20151203110158.GD5727@sirena.org.uk>
References: <1449129208-63615-1-git-send-email-koro.chen@mediatek.com>
 <s5h8u5b98dp.wl-tiwai@suse.de>
 <20151203110158.GD5727@sirena.org.uk>
Message-ID: <s5hfuzjn635.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 03 Dec 2015 12:01:58 +0100,
Mark Brown wrote:
> 
> On Thu, Dec 03, 2015 at 10:41:38AM +0100, Takashi Iwai wrote:
> 
> > While reading this patch, I wondered how regmap can be used safely in
> > an irq-disabled context.  Mark, do we have any API for that?
> 
> We can use user supplied locks or spin_lock_irqsave().

I meant how to guarantee to make regmap_read() working in an already
spin-locked context, typically in an irq handler?  regmap_read()
involves with the regcache and it may invoke kmalloc().


Takashi

From: l.majewski@majess.pl (Lukasz Majewski)
Date: Sun, 23 Oct 2016 08:40:27 +0200
Subject: [PATCH v3 3/6] pwm: imx: support output polarity inversion
In-Reply-To: <20161022140118.7a6cb583@bbrezillon>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
 <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
 <5325a332099473a2d8382530f79c5a8e@agner.ch>
 <20161013001540.7f759158@jawa>
 <ff9ba34df2729204c617685dd26ea625@agner.ch>
 <20161013065812.0da91859@jawa> <20161020103018.44fb94ea@jawa>
 <1b72dcbc9a021e6fa3aef62f63bbf93f@agner.ch>
 <20161021234939.1a4f51f4@jawa> <20161022140118.7a6cb583@bbrezillon>
Message-ID: <20161023084027.4a2aae51@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

> > 
> > Could you be more specific here? 
> > 
> > As I mentioned before, the problem is not with the lack of
> > "atomic" API.  
> 
> Below is a quick and dirty I made on top of this patch to show you how
> atomic update can be implemented in this driver. 

Thank you for example patch.

I will implement the ->apply() callback and post patches very soon :-).

I had two issues with the ->apply() implementation:

- Do my work on top of this patch (https://lkml.org/lkml/2016/10/7/454
  as you did) to avoid rewriting work already done.

- In the example ->apply() implementation for rockchip
  (https://patchwork.kernel.org/patch/7228221/) the ->config() callback
  was not removed when ->apply() was implemented. I was confused with
  such approach, but as you explained in this mail, the solely ->apply()
  is enough.

> It's not tested, and
> probably not working, but it should give you a better idea of what is
> expected.

Thanks for explanation,

?ukasz Majewski
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161023/a40e15be/attachment.sig>

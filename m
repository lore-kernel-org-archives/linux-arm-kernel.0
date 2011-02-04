From: rabin@rab.in (Rabin Vincent)
Date: Fri, 4 Feb 2011 09:37:54 +0530
Subject: Question about ARM function graph tracing
In-Reply-To: <4D4B3D63.4090207@am.sony.com>
References: <4D4B3D63.4090207@am.sony.com>
Message-ID: <AANLkTinoFRE2ho9u9yF5nhfgr1gGouHV3anf2OX0mN2T@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 4, 2011 at 05:12, Tim Bird <tim.bird@am.sony.com> wrote:
> I sheepishly admit that I haven't been following mainline very
> well. ?I was happily surprised to see you have mainlined ARM
> function graph tracing. ?I gave it a test on my old OMAP
> OSK board, with the results shown below.

OMAP is missing a notrace annotation on omap_readl():

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg38911.html

Part of that patch was merged through rmk's work, but the
omap_readl() annotation seems to have been missed.

Also, if this is OMAP1 and not latest mainline, I think you
will need  a notrace on omap_rev() also (called from inside
omap_readl() until recently).

I think this is most probably what is wrong, since IIRC I saw
crashes like this on BeagleBoard before I added the notrace on
omap_readl.  Could you please try with these changes?

Rabin

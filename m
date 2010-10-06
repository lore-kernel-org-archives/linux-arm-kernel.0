From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 6 Oct 2010 22:41:31 +0900
Subject: [PATCH 4/7] ARM: oprofile: Move non-ARM code into separate
	init/exit
In-Reply-To: <20101006133309.GP13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
	<74092b0d162aafc21e408033cec6146e227363b5.1286222593.git.matt@console-pimps.org>
	<20101006133309.GP13563@erda.amd.com>
Message-ID: <20101006134130.GB29273@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 03:33:09PM +0200, Robert Richter wrote:
> On 04.10.10 16:44:22, Matt Fleming wrote:
> > @@ -388,7 +387,14 @@ out:
> >  	return ret;
> >  }
> >  
> > -void __exit oprofile_arch_exit(void)
> > +int __init oprofile_arch_init(struct oprofile_operations *ops)
> > +{
> 
> We should do here a:
> 
> 	memset(ops, 0, sizeof(*ops));
> 
> Otherwise it looks good.
> 
What kind of crap interface is oprofile peddling, seriously?

You expect every single architecture to clear this structure that gets
passed in from the oprofile code without having any idea if there are
defaults assigned or not, instead of just having the oprofile code clear
it out before passing it along?

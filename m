From: will.deacon@arm.com (Will Deacon)
Date: Sun, 3 Feb 2013 11:48:47 +0000
Subject: [PATCH 6/6] ARM: integrator: ensure ap_syscon_base is
 initialised when !CONFIG_MMU
In-Reply-To: <20130131225630.GB26523@quad.lixom.net>
References: <1359556069-28289-1-git-send-email-will.deacon@arm.com>
 <1359556069-28289-7-git-send-email-will.deacon@arm.com>
 <CACRpkdbFL6cA9wPdc7h8bTmH0t7PeVwmO+4LBwQGbSKNFJOS+Q@mail.gmail.com>
 <20130131223417.GB19961@mudshark.cambridge.arm.com>
 <20130131225630.GB26523@quad.lixom.net>
Message-ID: <20130203114847.GB27474@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 10:56:30PM +0000, Olof Johansson wrote:
> On Thu, Jan 31, 2013 at 10:34:17PM +0000, Will Deacon wrote:
> > [adding Olof and Arnd] Is it worth sending a pull request containing a
> > single patch, or can this patch just be picked directly?
> 
> Definitely ok to just send the patch like this. However -- where was
> the breakage introduced, i.e.  what should we apply the fix to?

I think it's been broken for a little while as it only affects !MMU
configurations, which aren't especially popular. My guess is that
83feba511e5d ("ARM: integrator: remove static AP syscon mapping") is what
caused the breakage.

The fix should apply against mainline.

Cheers,

Will

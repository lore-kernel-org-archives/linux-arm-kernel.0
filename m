From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 May 2014 22:46:47 +0200
Subject: [PATCHv4 0/5] Add DT support for fixed PHYs
In-Reply-To: <CAGVrzca7xi4_sGgF0FyFcM0Zo3-mMENP0-aoU=qoV9qshxNzsw@mail.gmail.com>
References: <1400249647-4643-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAGVrzca7xi4_sGgF0FyFcM0Zo3-mMENP0-aoU=qoV9qshxNzsw@mail.gmail.com>
Message-ID: <20140516224647.1a76edac@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Florian Fainelli,

On Fri, 16 May 2014 11:27:36 -0700, Florian Fainelli wrote:

> > Here is a fourth version of the patch set that adds a Device Tree
> > binding and the related code to support fixed PHYs. I'm hoping to get
> > this merged in 3.16.
> 
> Thanks for being persistent on this and coming back with these
> patches, that is really appreciated.
> 
> I gave this patch set a try on a brcmstb system with SYSTEMPORT and my
> latest changes to net/dsa/ to allow for different PHY setups to be
> used with the SoC integrated switch. This switch has a mix of fixed
> and real PHYs. This works like a charm, so long as you consistently
> use the "new" functions, and not the old ones, which is totally
> expected. This is excellent work!

Thanks a lot for your review and testing.

> As we discussed offline, I think we need to progressively get rid of
> of_phy_connect_fixed() to avoid having to debug situations where the
> old 'fixed-link' property used some sparse addressing scheme, which is
> now incompatible with the dynamic address allocation scheme.

Yes, agreed. As we discussed, my plan is to send a followup patch
series to fix the users of the old API to finally remove it. But I'd
like to do this once this series gets accepted and applied.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

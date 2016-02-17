From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 17 Feb 2016 11:02:31 -0800
Subject: [RESEND2 PATCH 1/3] memremap: add MEMREMAP_WC flag
In-Reply-To: <20160217115347.GA28433@e106950-lin.cambridge.arm.com>
References: <cover.1454950917.git.brian.starkey@arm.com>
 <9085d37fa97a762a46b9d58719c085368682c64f.1454950917.git.brian.starkey@arm.com>
 <20160208120317.313409dc0ae7634c25d3f021@linux-foundation.org>
 <20160209102300.GB23507@e106950-lin.cambridge.arm.com>
 <20160217115347.GA28433@e106950-lin.cambridge.arm.com>
Message-ID: <20160217110231.d4040207cc1456bd991ff0e7@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Feb 2016 11:53:48 +0000 Brian Starkey <brian.starkey@arm.com> wrote:

> Hi Andrew,
> 
> Would you pick these up if I rebase onto linux-next?

Sure.

> How strongly do you feel about the input argument modification vs.
> staying in-line with the rest of the function?

I see no reason why memremap() is modifying `flags' as it proceeds -
these flags are all disjoint so it's pointless.  I suggest you simply
take all that out in a preparatory patch.

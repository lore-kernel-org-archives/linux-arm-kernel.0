From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 13 Aug 2016 10:58:14 +1000
Subject: [PATCH 02/12] pinctrl: Add core pinctrl support for Aspeed SoCs
In-Reply-To: <CACRpkdaN=wR4amskqMapTJzaTTMJZe2EQWRnyLMQkq_zuhr2eA@mail.gmail.com>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
 <1468994313-13538-3-git-send-email-andrew@aj.id.au>
 <CACRpkdZ0p+jNHBV1AqhVWQ2Q8RRrHVfsAz3XU3_+f6My22=Zxg@mail.gmail.com>
 <1470962022.27272.68.camel@aj.id.au>
 <CACRpkdaN=wR4amskqMapTJzaTTMJZe2EQWRnyLMQkq_zuhr2eA@mail.gmail.com>
Message-ID: <1471049894.12231.41.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-08-12 at 15:18 +0200, Linus Walleij wrote:
> I would probably prefer that option (introduce another field)
> but you should make the overall decision, it's no strong opinion
> from my side.
> 
> > Would it be acceptable to document that requirement?

It might make it a bit less nasty (and easier to change later on
if necessary) to use some kind of:

	bool ast_signal_is_gpio(...)

And stick the strcmp in there.

Cheers,
Ben.

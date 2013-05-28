From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 May 2013 17:43:52 +0200
Subject: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
In-Reply-To: <51A4C564.4040301@zytor.com>
References: <519DCBEF.3090208@asianux.com> <20130528081910.GA29557@gmail.com>
 <51A4C564.4040301@zytor.com>
Message-ID: <201305281743.52649.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 May 2013, H. Peter Anvin wrote:
> On 05/28/2013 01:19 AM, Ingo Molnar wrote:
> > 
> > So I think the same principle applies to it as to any other debugging 
> > code: it's fine to be able to turn debugging off. It's a performance 
> > versus kernel robustness/determinism trade-off.
> > 
> 
> I suspect, rather, that BUG() should turn into a trap (or jump to a
> death routine) under any circumstances.  The one thing that can be
> omitted for small configurations are the annotations, which only serve
> to output a more human-readable error message.

Right, that is what the patch I just posted does.

On a related note, I found that WARN_ON() can no longer be compiled
out since there is already code that relies on the side-effects of
the condition. I assume that was an intentional change I missed,
since it used to be defined so that you could remove it completely.

	Arnd

From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Sun, 28 Feb 2010 10:12:39 +1100
Subject: arch/arm broken in next
In-Reply-To: <20100227203345.GA5760@pengutronix.de>
References: <20100227203345.GA5760@pengutronix.de>
Message-ID: <20100228101239.63de9eb6.sfr@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Sat, 27 Feb 2010 21:33:45 +0100 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
>
> since
> 
> 	40464e5 (Merge remote branch 'samsung/next-samsung')
> 
> next is broken for arch/arm.  Our autobuilders fail with:
> 
> 	arch/arm/Kconfig:920: file 'arch/arm/mach-lh7a40x/Kconfig' is already sourced from 'arch/arm/Kconfig'
> 
> Both parents of 40464e5 only include the above file once.

Yeah, sorry about that.  This is one of those rare cases where the
automatic git merge got it wrong.  I will make sure it doesn't happen for
the next release.  The correct resolution should not include the second
inclusion.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100228/285a05ae/attachment.sig>

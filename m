From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2016 13:01:18 +0200
Subject: [PATCH V7 03/11] pci,
 of: Move the PCI I/O space management to PCI core code.
In-Reply-To: <5732E11A.9090002@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
 <CAJZ5v0ge+LGwp=AkPF50H1ZXFA6J5ByazuY7Opc-aLJwWrBNxg@mail.gmail.com>
 <5732E11A.9090002@semihalf.com>
Message-ID: <4722186.M8gaIx9LyT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 May 2016 09:36:58 Tomasz Nowicki wrote:
> >
> > I understand that this moves code around, but those in-function
> > #ifdefs aren't nice.  Any chance to get rid of them but putting whole
> > functions under the #ifdef?
> >
> 
> This is a __weak implementation, so assuming I would move #ifdef out of 
> function I need to provide another empty __weak stub. I do not know 
> which solution is more ugly. In any case we can do that cleanup separately.
> 

I'd vote for just dropping the __weak here, given that there is no
non-weak implementation. If we end up needing to override this for
some architecture or host bridge in the future, we can think about how
to best do that then.

I agree that should be a separate patch, this one should only move
code from one file to another.

	Arnd

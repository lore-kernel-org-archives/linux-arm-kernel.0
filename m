From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jun 2018 11:46:42 +0100
Subject: linux-next: manual merge of the regulator tree with the arm-soc
 tree
In-Reply-To: <2564792.sYBGPVz9u3@z50>
References: <20180530150711.2c7c1fe9@canb.auug.org.au>
 <CACRpkdaotBXbA4pPFHRH0S1SF7-XX_T6yAOwZcbsR3RBcj+-=Q@mail.gmail.com>
 <2564792.sYBGPVz9u3@z50>
Message-ID: <20180604104642.GC7536@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 12:49:53AM +0200, Janusz Krzysztofik wrote:

> I confirm the fix by Stephen works for me, however, the conflicting patch by 
> Linus breaks things a bit.

> Lookup tables added to board files use function name "enable" while the 
> regulator uses NULL. As a result, GPIO descriptor is not matched and not 
> assigned to the regulator which ends up running with no control over GPIO pin.

> Either the regulator driver should use the function name "enable" or that name 
> should be removed from lookup tables.

I'll revert this one as well :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180604/ab8c1fa9/attachment.sig>

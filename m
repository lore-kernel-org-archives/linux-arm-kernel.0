From: broonie@kernel.org (Mark Brown)
Date: Sat, 1 Mar 2014 12:13:58 +0900
Subject: [PATCH V2 1/3] dt: palmas: support IRQ inversion at the board
 level
In-Reply-To: <5310BA99.4050203@wwwdotorg.org>
References: <1393534281-30759-1-git-send-email-swarren@wwwdotorg.org>
 <20140227210227.GE2931@xora-haswell>
 <530FAFAE.5050800@wwwdotorg.org>
 <20140228055818.GA29849@sirena.org.uk>
 <5310BA99.4050203@wwwdotorg.org>
Message-ID: <20140301031358.GI29849@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 09:34:33AM -0700, Stephen Warren wrote:
> On 02/27/2014 10:58 PM, Mark Brown wrote:

> > I'm not sure that renaming the property really deals with the concerns
> > though since drivers still all need to manually add support for this,
> > shouldn't there be an interrupt controller described in the DT which
> > just chains on to the parent with the polarity inverted to do the
> > impedence match?

> I had thought of that when first dealing with this a couple years ago,
> but Olof suggested that was too complicated.

It's not obvious to me that it should be especially hard but I've not
thought about it too deeply.

> Another alternative might be to add an extra IRQ bit in the IRQ
> specifier (and something similar would be needed for GPIO specifiers)
> that indicates "inversion between source and destination". This could be
> queried by drivers in exactly the same way as the existing polarity/type
> IRQ flags. We'd need to update each individual IRQ controller binding to
> enable that flag, since each binding defines its own definition of such
> flags. (although in practice since most use the same centrally suggested
> flags, this wouldn't be any more than just saying yes, this binding
> allows that new flag to be used).

Yes, doing something on the controller side seems more obvious here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140301/be9631ae/attachment.sig>

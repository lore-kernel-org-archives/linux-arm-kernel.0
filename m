From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Mar 2014 11:50:19 +0800
Subject: [PATCH V2 1/3] dt: palmas: support IRQ inversion at the board
 level
In-Reply-To: <5314B0C0.4040008@wwwdotorg.org>
References: <1393534281-30759-1-git-send-email-swarren@wwwdotorg.org>
 <20140227210227.GE2931@xora-haswell>
 <530FAFAE.5050800@wwwdotorg.org>
 <20140228055818.GA29849@sirena.org.uk>
 <5310BA99.4050203@wwwdotorg.org>
 <20140303005246.GA22047@xora-yoga13>
 <5314B0C0.4040008@wwwdotorg.org>
Message-ID: <20140304035019.GZ2411@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 09:41:36AM -0700, Stephen Warren wrote:

> 2) We can go through every single interrupt controller's DT binding and
> driver, and implement (document and parse) the new IRQ specifier flag
> there, and pass it throgh the Linux IRQ stack, yet we still need code in
> every IC driver to actually read the flag, so we haven't removed any
> code. It seems /much/ simpler, and no more of a maintenance or
> consistency burden, to just have the IC driver read the flag directly
> from their own DT.

Why does this have to be handled by the chip drivers?  Can't the
interrupt controller configured in a way that the chip drivers never
need to see it at all, for example by adding a "override the mode for
this input" flag inside the device?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140304/f6e579d3/attachment.sig>

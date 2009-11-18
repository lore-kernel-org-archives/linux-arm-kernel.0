From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 18 Nov 2009 18:02:16 +0100
Subject: [PATCH 1/3] em-x270: don't use pxa_camera init() callback
In-Reply-To: <Pine.LNX.4.64.0911181107540.5702@axis700.grange>
References: <1258495463-26029-1-git-send-email-ospite@studenti.unina.it>
	<1258495463-26029-2-git-send-email-ospite@studenti.unina.it>
	<Pine.LNX.4.64.0911181107540.5702@axis700.grange>
Message-ID: <20091118180216.7d769c3e.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Nov 2009 11:10:06 +0100 (CET)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> On Tue, 17 Nov 2009, Antonio Ospite wrote:
> 
> > pxa_camera init() is going to be removed.
> 
> My nitpick here would be - I would put it the other way round. We do not 
> remove .init() in platforms, because it is going to be removed, but rather 
> we perform initialisation statically, because we think this is better so, 
> and then .init becomes useless and gets removed.
> 

TBH, I am persuaded that the current use of init() is ambiguous /per se/
and so we'd just better not use it at all. If static initialization for
sensor GPIOs is better, well I just trust you on that.
However, the point here is not about static/dynamic initialization, it
is more about pxa_camera init() used one time to configure MFP pins, and
another time to request resources for the *sensor*, and in both cases
(mis)used as it was going to be called at _module_init_ time only, which
it wasn't.

So, can you see why I consider these changes (patches 1 and 2) as
merely functional to the removal of init() from pxa_camera?

Anyhow, if you don't like references to a future change without an
explanation I can arrange something in commit messages for the first
two patches :)

Regards,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091118/d263ff16/attachment.sig>

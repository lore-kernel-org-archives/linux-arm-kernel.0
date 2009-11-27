From: ospite@studenti.unina.it (Antonio Ospite)
Date: Fri, 27 Nov 2009 15:32:30 +0100
Subject: [PATCH 3/3] pxa_camera: remove init() callback
In-Reply-To: <Pine.LNX.4.64.0911271503460.4383@axis700.grange>
References: <1258495463-26029-1-git-send-email-ospite@studenti.unina.it>
	<1258495463-26029-4-git-send-email-ospite@studenti.unina.it>
	<Pine.LNX.4.64.0911271503460.4383@axis700.grange>
Message-ID: <20091127153230.d042d92e.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Nov 2009 15:06:53 +0100 (CET)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> On Tue, 17 Nov 2009, Antonio Ospite wrote:
> 
> > pxa_camera init() callback is sometimes abused to setup MFP for PXA CIF, or
> > even to request GPIOs to be used by the camera *sensor*. These initializations
> > can be performed statically in machine init functions.
> > 
> > The current semantics for this init() callback is ambiguous anyways, it is
> > invoked in pxa_camera_activate(), hence at device node open, but its users use
> > it like a generic initialization to be done at module init time (configure
> > MFP, request GPIOs for *sensor* control).
> > 
> > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> 
> Antonio, to make the merging easier and avoid imposing extra dependencies, 
> I would postpone this to 2.6.34, and just remove uses of .init() by 
> pxa-camera users as per your other two patches. Would this be ok with you?
> 
> Thanks
> Guennadi
>

Perfectly fine with me.

Feel also free to anticipate me and edit the commit messages to
whatever you want in the first two patches. Now that we aren't removing
init() immediately after these it makes even more sense to change the
phrasing from a future referencing
	"init() is going to be removed"
to a more present focused
	"better not to use init() at all"
form.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091127/d6e71e8d/attachment.sig>

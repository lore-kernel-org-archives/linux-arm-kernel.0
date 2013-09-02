From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Sep 2013 17:41:34 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130902145722.GA12808@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
 <20130831191414.GG6617@n2100.arm.linux.org.uk>
 <20130831193431.GI6617@n2100.arm.linux.org.uk>
 <20130902144713.GR3084@sirena.org.uk>
 <20130902145207.GY6617@n2100.arm.linux.org.uk>
 <20130902145722.GA12808@n2100.arm.linux.org.uk>
Message-ID: <20130902164134.GU3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 03:57:22PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 02, 2013 at 03:52:07PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 02, 2013 at 03:47:13PM +0100, Mark Brown wrote:

> > > > This is caused because substream->ops is NULL.  Why that's the case,
> > > > I don't know, but I believe the PCM which is trying to be operated on
> > > > is the one registered against the backend (by snd_pcm_new_internal).

> > > Liam did provide you with a workaround for this one along with a
> > > suggested proper fix.  Have you had any success in using this
> > > workaround, or with implementing the proper fix for that matter?  I
> > > don't recall seeing any feedback on the results but perhaps I missed it.

> > I am not aware of any such patch.

> That was a little hasty - I should say: I have not received any such patch
> and I have nothing which suggests that a solution to this problem was even
> outlined.  (I have checked my mailbox for anything from Liam, of which
> there are a very small number of such mails.)

I was thinking of this:

   http://article.gmane.org/gmane.linux.alsa.devel/111647

where Liam suggests setting some ops as a workaround and that the
framework should just check for them before dereferencing otherwise.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130902/996d10ea/attachment-0001.sig>

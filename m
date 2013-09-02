From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Sep 2013 15:57:22 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130902145207.GY6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831191414.GG6617@n2100.arm.linux.org.uk>
 <20130831193431.GI6617@n2100.arm.linux.org.uk>
 <20130902144713.GR3084@sirena.org.uk>
 <20130902145207.GY6617@n2100.arm.linux.org.uk>
Message-ID: <20130902145722.GA12808@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 03:52:07PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 02, 2013 at 03:47:13PM +0100, Mark Brown wrote:
> > On Sat, Aug 31, 2013 at 08:34:31PM +0100, Russell King - ARM Linux wrote:
> > > And here's the oops:
> > 
> > > Aug 10 22:06:17 cubox kernel: [<c030f724>] (snd_pcm_info+0xc8/0xd8) from [<c030f768>] (snd_pcm_info_user+0x34/0x9c)
> > > Aug 10 22:06:17 cubox kernel: [<c030f768>] (snd_pcm_info_user+0x34/0x9c) from [<c030a67c>] (snd_pcm_control_ioctl+0x274/0x280)
> > 
> > > This is caused because substream->ops is NULL.  Why that's the case,
> > > I don't know, but I believe the PCM which is trying to be operated on
> > > is the one registered against the backend (by snd_pcm_new_internal).
> > 
> > Liam did provide you with a workaround for this one along with a
> > suggested proper fix.  Have you had any success in using this
> > workaround, or with implementing the proper fix for that matter?  I
> > don't recall seeing any feedback on the results but perhaps I missed it.
> 
> I am not aware of any such patch.

That was a little hasty - I should say: I have not received any such patch
and I have nothing which suggests that a solution to this problem was even
outlined.  (I have checked my mailbox for anything from Liam, of which
there are a very small number of such mails.)

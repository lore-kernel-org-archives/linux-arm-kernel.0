From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 8 Mar 2013 15:43:42 +0800
Subject: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
In-Reply-To: <20130307112006.GD17833@n2100.arm.linux.org.uk>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
 <20130306171333.GR17833@n2100.arm.linux.org.uk>
 <20130307023316.GA22554@opensource.wolfsonmicro.com>
 <20130307091804.GA17833@n2100.arm.linux.org.uk>
 <20130307093117.GB14315@opensource.wolfsonmicro.com>
 <20130307112006.GD17833@n2100.arm.linux.org.uk>
Message-ID: <20130308074325.GB28481@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 11:20:06AM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 07, 2013 at 05:31:23PM +0800, Mark Brown wrote:

> > The bit I'm missing is why this is particularly hard to change, it
> > doesn't seem like a massive refactoring and there's not many users.

> Well, it requires the thing to be reworked along with everyone who uses
> it, specifically snd_dmaengine_pcm_open() and snd_dmaengine_pcm_close().

Oh, OK.  That doesn't seem like a big deal really - it's certainly not a
throw the thing out and start over job.  It sounded like you'd identifed
some new issue you'd not mentioned rather than just the same issue, it
wasn't clear to me that it was the same issue.

> Now, I could use your excuse that you've given me in the past: "I don't
> have much of that hardware so I can't test the changes, so I'm not going
> to touch this code evar again!"  (That's basically what you said about

I'm not particularly asking you to fix this yourself except in that it
seems like it's an important issue for you.  If anything something like
this patch ought to make things marginally easier to deal with by
factoring out a very small bit of the code.

> the AC'97 struct device stuff.)  You can't have it both ways and always
> shovel what you don't like onto other people.

I'm aware of the issue, as are the people who've worked on the code.
Speaking personally I just happen to disagree with you about the urgency
here - it's not like it's the only problem we've got and the practical
effects are limited to a subset of mostly older hardware which generally
doesn't use dmaeengine in the first place.  I imagine that a similar
thing is true for everyone else.

There's plenty of other hardware that doesn't work right now, another
pressing example I can think of is devices that subdivide an audio
interface into multiple unrelated streams of audio, you aren't alone in
having hardware that needs the frameworks improving in order to achieve
basic functionality.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/5ae2086b/attachment.sig>

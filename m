From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 27 Jul 2013 13:56:43 +0200
Subject: [PATCH V2 2/8] ASoC: Samsung: I2S: Add quirks as driver data in
 I2S
In-Reply-To: <20130726152551.GM9858@sirena.org.uk>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1417636.4d7IlsSAyI@amdc1227> <20130726152551.GM9858@sirena.org.uk>
Message-ID: <2425397.IIfnern1kk@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 of July 2013 16:25:51 Mark Brown wrote:
> On Fri, Jul 26, 2013 at 05:02:46PM +0200, Tomasz Figa wrote:
> > IMHO this SoC-based identification looks much better, especially
> > considering the fact that IP version isn't something easily
> > determinable, as even the documentation can sometimes be not really
> > clear about that.
> 
> Yeah, it's not terribly clever either way.  We've been using the version
> numbers in audio for a long time partly because it is documented
> sometimes and partly because most of the SoCs tend to have one fully
> featured controller and a bunch of secondary controllers on older IP
> revisions.
> 
> > However the s3c6410-i2sv4 string looks a bit unfortunate. AFAIK there
> > were two types of I2S IPs on S3C6410 - normal I2S and I2S
> > multichannel. What about having a compatible like s3c6410-i2s-multi?
> 
> It was explicitly identified as I2Sv4 in the S3C6410 datasheet so no
> real issue there.

Well, the datasheet I have calls it either "I2S V40" or "IIS MULTI AUDIO 
INTERFACE". I like the latter much more, because it actually says what's 
the difference compared to previous I2S IPs.

I'm not strongly against using the v4 suffix, but since we decided to use 
more meaningful compatible values elsewhere, I think this way would be 
better for sound drivers as well.

Best regards,
Tomasz

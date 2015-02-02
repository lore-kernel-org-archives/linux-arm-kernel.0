From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 3 Feb 2015 00:16:57 +0100
Subject: [PATCH 4/6] i2c: busses: add SLIMpro I2C device driver on APM
 X-Gene platform
In-Reply-To: <CAL85gmD+0cJfZoWo8ujmjwy9yaKjNPjJaUm00Vrv5o9kcg-ozA@mail.gmail.com>
References: <1412726809-7525-1-git-send-email-fkan@apm.com>
 <1412726809-7525-5-git-send-email-fkan@apm.com>
 <1894616.4yY7dajl4R@wuerfel>
 <CAL85gmCuJtS2DMVHc96FtM_nP2++wMXNrrUp0Kvx0qajKsFuCw@mail.gmail.com>
 <20150130061118.GA995@katana>
 <CAL85gmD+0cJfZoWo8ujmjwy9yaKjNPjJaUm00Vrv5o9kcg-ozA@mail.gmail.com>
Message-ID: <20150202231657.GA14881@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 02:15:44PM -0800, Feng Kan wrote:
> On Thu, Jan 29, 2015 at 10:11 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >> > ctx->dev is probably the wrong device here. The i2c controller is not
> >> > DMA capable itself, you need to have a pointer to the device that actually
> >> > performs the DMA here.
> >>
> >> Arnd, I do agree this may not be the best identification. There is no
> >> representation for this on the Linux side. I could put it as NULL. However,
> >> there are other i2c bus drivers that seem to do the same thing. Please
> >> let me know what you think.
> >
> > For completeness: Those drivers need fixing!
> I have some doubts. I could hack up a dts node for the helper
> processor that is doing the dma. However, the dma master could be
> anything for that matter. I am not sure how I can write this in a
> generic manner.

All I wanted to say is that, to the best of my knowledge, currently all
DMA capable i2c bus drivers which do not pass the DMA capable device
when mapping, need a fix like 8cfcae9f0595. So, the argument "other
drivers do it, too" is invalid IMO. You might have other, better, more
technical arguments for your case. Like above, that could be fine, I'd
say. But I leave this to the DMA experts...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150203/3aff6ca8/attachment.sig>

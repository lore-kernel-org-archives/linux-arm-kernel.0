From: stwiss.opensource@diasemi.com (Steve Twiss)
Date: Tue, 20 Jun 2017 13:37:22 +0000
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <20170620132620.GA16881@amd>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <20170620100348.zh4ygvjjgnhxvmvl@piout.net> <20170620121011.GA13221@amd>
 <20170620122400.sm7qqvwyj6cuzarw@piout.net> <20170620132620.GA16881@amd>
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD96FCD@SW-EX-MBX02.diasemi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 20 June 2017 14:26, Pavel Machek wrote:

> Subject: Re: [PATCH 00/51] rtc: stop using rtc deprecated functions
> 
> On Tue 2017-06-20 14:24:00, Alexandre Belloni wrote:
> > On 20/06/2017 at 14:10:11 +0200, Pavel Machek wrote:
> > > On Tue 2017-06-20 12:03:48, Alexandre Belloni wrote:
> > > > On 20/06/2017 at 11:35:08 +0200, Benjamin Gaignard wrote:
> > > > > rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
> > > > > rely on 32bits variables and that will make rtc break in y2038/2016.
> > > >
> > > > Please don't, because this hide the fact that the hardware will not
> > > > handle dates in y2038 anyway and as pointed by Russell a few month ago,
> > > > rtc_time_to_tm will be able to catch it but the 64 bit version will
> > > > silently ignore it.
> > >
> > > Reference? Because rtc on PCs stores date in binary coded decimal, so
> > > it is likely to break in 2100, not 2038...
> >
> > I'm not saying it should be done but clearly, that is not the correct
> > thing to do for RTCs that are using a single 32 bits register to store
> > the time.
> > You give one example, I can give you three: armada38x, at91sam9,
> > at32ap700x and that just in the beginning of the series.
> 
> I wanted reference to Russell's mail.

This is it.
https://patchwork.kernel.org/patch/6219401/

Regards,
Steve

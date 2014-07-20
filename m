From: julian.calaby@gmail.com (Julian Calaby)
Date: Sun, 20 Jul 2014 19:06:34 +1000
Subject: [linux-sunxi] GSoC 2014 #1 status report - Improving Allwinner
 SoC support
In-Reply-To: <53CAC9ED.9080302@elopez.com.ar>
References: <53BE0B4F.1090001@elopez.com.ar> <53CAC9ED.9080302@elopez.com.ar>
Message-ID: <CAGRGNgXBnCMKXVf0fxfcDXYY+dKMJ=-X2WLCBpWScqZX-SxXYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Sun, Jul 20, 2014 at 5:41 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> Hi everyone,
>
> Here's this week's update on my GSoC project; if you missed the first issue
> or you want a refresher of what this is about, you can read it on the list
> archives[0]
>
> A couple of days after the last report, and with the help of Jon Smirl, I
> got the hardware working on mainline Linux, first on only 16 bit stereo
> mode, then mono as well, and later on, also on 24 bit mode. The first thing
> I had to do was rework the cyclic DMA code to make it perform decently and
> avoid underruns. The rest took a bit of playing with values and reading the
> Allwinner documentation. There is one unresolved issue with 24 bit audio
> still - for some reason, the volume is really low compared to the same track
> played on 16 bit. Unfortunately the SDK driver doesn't support 24 bit, so
> it's hard to compare with anything else.

It might be worth trying to generate some 24 bit audio samples that
only exercise one bit, then check that playing them produces output,
because it sounds to me (and Chen-Yu) that there's something in your
code that's shifting or clipping the samples.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/

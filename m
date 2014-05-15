From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 15 May 2014 07:05:28 -0700
Subject: [RFC PATCH 0/5] Frequency resolution in CCF vs. cpufreq
In-Reply-To: <CAKohpokm3WVnu_DggKc4PbhVAKNexrJ4051F-gnVFFTDOyz9ew@mail.gmail.com>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
 <CAKohpokm3WVnu_DggKc4PbhVAKNexrJ4051F-gnVFFTDOyz9ew@mail.gmail.com>
Message-ID: <3c6b2890-3df4-48e9-8cc5-8e2d8955f64f@BL2FFO11FD032.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Thu, 2014-05-15 at 11:42AM +0530, Viresh Kumar wrote:
> On 15 May 2014 04:00, Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> > I have one or two problems with cpufreq and the CCF, which are caused by
> > rounding/different frequency resolutions.
> >
> > cpufreq works with kHz, while the CCF uses Hz. On Zynq our default frequency is
> > 666666666 Hz which the CCF, due to rounding, reports as 666666660. And for
> > cpufreq, which simply divides values it obtains through clk_round_rate() by
> > 1000, 666666.
> > Since passing 666666 to clk_round_rate() does not result in 666666660
> > (clk_round_rate() always rounds down!), we chose to put 666667 in the OPP. This
> > causes issue 1: cpufreq stats are broken.
> 
> I know it might a big exercise, but wouldn't it be worth to make cpufreq start
> using frequencies in Hz ?

I haven't looked into this. As you say yourself, that might be a rather
big project. I will take a look at it, but I can't promise that I have
time to dedicate to this. Also, as said above, even though our CPU is
supposed to run at 666666666 Hz, rounding lets the last 6 Hz disappear.
I think we have to handle deviances either way.

	S?ren

From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Jun 2013 12:45:27 +0900
Subject: [PATCH 14/15] ARM: shmobile: Remove AP4EVB board support
In-Reply-To: <Pine.LNX.4.64.1306141123380.6920@axis700.grange>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
 <1371106793-25071-15-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1306132128370.3777@axis700.grange>
 <CANqRtoSx4Jf_EfG3LvkpoOED4-SuOdWjRedz-RbwGCOcOeP-Xg@mail.gmail.com>
 <Pine.LNX.4.64.1306141123380.6920@axis700.grange>
Message-ID: <CANqRtoRXBupbbU_cq257p5usu8F5975NFDenkOx1qTvYZaxF2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Fri, Jun 14, 2013 at 6:27 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 14 Jun 2013, Magnus Damm wrote:
>
>> Hi Guennadi,
>>
>> On Fri, Jun 14, 2013 at 4:36 AM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > Hi Simon
>> >
>> > On Thu, 13 Jun 2013, Simon Horman wrote:
>> >
>> >> From: Magnus Damm <damm@opensource.se>
>> >>
>> >> Remove board support for the sh7372 based AP4EVB board
>> >>
>> >> The sh7372 SoC support code is still kept around since it
>> >> is in use by the Mackerel board which is basically a more
>> >> recent board where the design is based on AP4EVB.
>> >>
>> >> Signed-off-by: Magnus Damm <damm@opensource.se>
>> >> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> >
>> > It would be a pity if this patch gets pulled now. We're still discussing
>> > with Magnus, I believe. My opinion is, that this board is a good testing
>> > platform for V4L2. It is the only board in the mainline, using the CSI2
>> > interface, present on multiple Renesas SoCs, including r8a73a4 (APE6), and
>> > (probably, not 100% sure) sh73a0 (AG5), and the IMX074 camera sensor, not
>> > present on any other platform. If this board is removed, supporting both
>> > CSI2 and IMX074 will become difficult. Besides, AP4EVB is used as an
>> > example in my V4L2 clock / async probing patch series:
>> >
>> > http://www.mail-archive.com/linux-media at vger.kernel.org/msg63174.html
>> >
>> > If still possible, would be good to delay removing this board until we
>> > complete our discussion.
>>
>> If fine with keeping the board if someone can show me progress in the
>> area of INTC DT support. Recently I have not seen anything.
>>
>> So if no one is developing DT support for this board then I can't
>> really see how we will be able to support it in the future with ARM
>> SoC requirements for DT and MULTIPLATFORM...
>
> You seem to be keeping the other sh7372 board currently in the mainline -
> the mackerel, so, keeping this one as well at least as long as sh7372 is
> at all supported shouldn't come at an extra cost.

My plan is to slowly getting rid of sh7372 bit by bit. This since the
sh7372 SoC never made it into mass production and it's getting old. As
for AP4EVB, it's the first sh7372 board that we ran Linux on. It was
soon replaced by Mackerel.

So sh7372 was something we worked on a couple of generations ago. The
sh7372 SoC code has issues related to DT for INTC, but that aside, the
AP4EVB board has board specific Kconfig bits and other stuff making it
difficult to fit into a single kernel binary. So I'd rather say good
bye to all this unless someone plans to fix it.

> As for INTC DT - I
> think, the original idea was to specify the complete INTC configuration in
> DT, which looked pretty horrifying.

No, that was not the original idea. The first steps included code to
keep the tables in C.

http://www.spinics.net/lists/linux-sh/msg10788.html

> And it shouldn't be needed, since INTC
> config is per-SoC, not per-board. What if we keep INTC configuration in
> SoC files and use aux-data to supply platform data to DT device nodes?
> Would that be difficult to implement?

Apparently. I made a prototype ages ago. Since then several people
have been requested to work on this, but unfortunately no useful
output has come from any of all this.

So Guennadi, if you want to keep this board then you have to step up
and fix things. If not then there is no point in keeping it.

Cheers,

/ magnus

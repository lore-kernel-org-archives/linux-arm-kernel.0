From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Jun 2013 12:47:55 +0900
Subject: [PATCH 14/15] ARM: shmobile: Remove AP4EVB board support
In-Reply-To: <Pine.LNX.4.64.1306140941060.6920@axis700.grange>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
 <1371106793-25071-15-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1306132128370.3777@axis700.grange>
 <20130614010254.GD7284@verge.net.au>
 <Pine.LNX.4.64.1306140941060.6920@axis700.grange>
Message-ID: <CANqRtoSPHX9yfTp1qRrxT+ZbipKj0R3t9JwP_EbHx7tgdtMSTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Fri, Jun 14, 2013 at 4:42 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 14 Jun 2013, Simon Horman wrote:
>
>> On Thu, Jun 13, 2013 at 09:36:51PM +0200, Guennadi Liakhovetski wrote:
>> > Hi Simon
>> >
>> > On Thu, 13 Jun 2013, Simon Horman wrote:
>> >
>> > > From: Magnus Damm <damm@opensource.se>
>> > >
>> > > Remove board support for the sh7372 based AP4EVB board
>> > >
>> > > The sh7372 SoC support code is still kept around since it
>> > > is in use by the Mackerel board which is basically a more
>> > > recent board where the design is based on AP4EVB.
>> > >
>> > > Signed-off-by: Magnus Damm <damm@opensource.se>
>> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
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
>> Does the board still work with the rest of this series applied?
>
> Yes, it does.

Uhm, apparently ap4evb_defconfig is broken so I don' t think so.

I cooked up the following fix against renesas-next-20130613:

[PATCH] ARM: shmobile: sh7372 build fix for SUSPEND=n && CPU_IDLE=n

In the future, can you make sure the board is working and we're
migrating towards DT? If so we can keep the board.

Thanks,

/ magnus

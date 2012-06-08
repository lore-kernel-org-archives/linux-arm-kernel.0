From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 8 Jun 2012 11:00:57 +0200
Subject: [RFC] Support for H.264/MPEG4 encoder (VPU) in i.MX27.
In-Reply-To: <20120608084802.GS30400@pengutronix.de>
References: <CACKLOr2jQMnBPTaTFOcfLN_9J1n39tLx-ffDcVGuZ4ZB-odYfg@mail.gmail.com>
 <20120608072601.GD30137@pengutronix.de>
 <CACKLOr1OShoEnLxs8BP6q2TyZrOH0oCnpbKZJqyAo-yXKck9Zw@mail.gmail.com>
 <20120608084802.GS30400@pengutronix.de>
Message-ID: <CACKLOr2wdF4tnovpnCO+ys7OMhbaKoruorSsj5hPfB26jGzQTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 June 2012 10:48, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Jun 08, 2012 at 09:39:15AM +0200, javier Martin wrote:
>> Hi Robert,
>>
>> On 8 June 2012 09:26, Robert Schwebel <r.schwebel@pengutronix.de> wrote:
>> > Hi Javier,
>> >
>> > On Fri, Jun 08, 2012 at 09:21:13AM +0200, javier Martin wrote:
>> >> If you refer to driver in [1] I have some concerns: i.MX27 VPU should
>> >> be implemented as a V4L2 mem2mem device since it gets raw pictures
>> >> from memory and outputs encoded frames to memory (some discussion
>> >> about the subject can be fond here [2]), as Exynos driver from Samsung
>> >> does. However, this driver you've mentioned doesn't do that: it just
>> >> creates several mapping regions so that the actual functionality is
>> >> implemented in user space by a library provided by Freescale, which
>> >> regarding i.MX27 it is also GPL.
>> >>
>> >> What we are trying to do is implementing all the functionality in
>> >> kernel space using mem2mem V4L2 framework so that it can be accepted
>> >> in mainline.
>> >
>> > We will work on the VPU driver and it's migration towards a proper
>> > mem2mem device very soon, mainly on MX53, but of course MX27 should be
>> > taken care of by the same driver.
>> >
>> > So I'd suggest that we coordinate that work somehow.
>>
>> Do you plan to provide both encoding and decoding support or just one of them?
>
> We have both encoding and decoding. It works on i.MX51/53, but was
> originally written for i.MX27 aswell. I haven't tested i.MX27 for longer
> now, so it might or might not work. Find the source here:
>
> git://git.pengutronix.de/git/imx/gst-plugins-fsl-vpu.git

Much too late...

http://www.digipedia.pl/usenet/thread/18550/20724/

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com

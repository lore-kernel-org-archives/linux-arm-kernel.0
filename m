From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Jul 2013 10:03:17 +0900
Subject: [PATCH] ARM: shmobile: Add SMSC ethernet chip to KZM9D DT
 reference
In-Reply-To: <51DC0BA0.2060306@cogentembedded.com>
References: <20130709042654.13658.20164.sendpatchset@w520>
 <51DBF7CD.8040009@cogentembedded.com>
 <CANqRtoQfkk9KFggw5dadqih-kqNTCGC+kVCKkOUO8G=1w+kh6g@mail.gmail.com>
 <51DC0BA0.2060306@cogentembedded.com>
Message-ID: <20130710010317.GG32603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 05:09:52PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 09-07-2013 17:03, Magnus Damm wrote:
> 
> >>>From: Magnus Damm <damm@opensource.se>
> 
> >>>Add support for the SMSC ethernet controller found
> >>>on the KZM9D board to the KZM9D DT Reference code.
> 
> >>>Signed-off-by: Magnus Damm <damm@opensource.se>
> >>>---
> 
> >>>   Built on top of renesas-next-20130704v2 and
> >>>   [PATCH] ARM: shmobile: KZM9D DT reference implementation
> 
> >>>   arch/arm/boot/dts/emev2-kzm9d-reference.dts |   31
> >>>+++++++++++++++++++++++++++
> >>>   1 file changed, 31 insertions(+)
> 
> >>>--- 0002/arch/arm/boot/dts/emev2-kzm9d-reference.dts
> >>>+++ work/arch/arm/boot/dts/emev2-kzm9d-reference.dts    2013-07-09
> >>>13:06:47.000000000 +0900
> >>>@@ -23,4 +23,35 @@
> 
> >>[...]
> 
> >>>+       lan9220 at 20000000 {
> 
> >>    Shouldn't all the Ethernet nodes be called "ethernet"?
> 
> >Good question. Grepping in arch/arm/boot/dts shows various ways to
> >name the Ethernet nodes. Exactly what is correct or not I can't really
> >say.
> 
>    See "Node Names" section of [1].
> 
> [1] http://www.devicetree.org/Device_Tree_Usage

I will queue up this patch for v3.12 in the dt branch and
it should appear in renesas-next-20130710.

If there is a desire to consistently name nodes as "ethernet" for shmobile
then I would appreciate a cleanup patches to fix all the relevant dts and
dtsi files. One SoC or board per patch.

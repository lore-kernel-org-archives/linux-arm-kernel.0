From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 May 2012 10:29:03 -0600
Subject: Duplicate labels in dts files
In-Reply-To: <20120519025632.GD5427@S2101-09.ap.freescale.net>
References: <4FB6B896.3090904@wwwdotorg.org>
 <20120519025632.GD5427@S2101-09.ap.freescale.net>
Message-ID: <4FBA6D4F.1090401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2012 08:56 PM, Shawn Guo wrote:
> On Fri, May 18, 2012 at 03:01:10PM -0600, Stephen Warren wrote:
>> The following arch/arm/boot/dts/*.dts all have duplicate label
>> definitions, albeit all duplicates pointing at the same node. Is this
>> expected?
> 
> At least for IMX, I would say, yes.
> 
> For example, when I have the following node in imx53.dtsi and need to
> have it in imx53-ard.dts, the first line of the node definition will
> be naturally copied into imx53-ard.dts.  As the result, the label
> "uart1" will be "duplicated".
> 
> 	uart1: serial at 53fbc000 {

There's no need to duplicate the label here; that line would work just
fine as:

	serial at 53fbc000 {

Writing that doesn't remove the label from the node at all.

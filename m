From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 14 Mar 2013 17:20:54 +0400
Subject: [PATCH 1/7] ARM: shmobile: marzen: add USB phy support
In-Reply-To: <87k3pa4xpk.wl%kuninori.morimoto.gx@renesas.com>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <1352446306-19945-2-git-send-email-horms@verge.net.au>
 <5140FBB1.50401@mvista.com> <87k3pa4xpk.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <5141CEB6.2080803@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 14-03-2013 4:44, Kuninori Morimoto wrote:

>>> +/* USB PHY */
>>> +static struct resource usb_phy_resources[] = {
>>> +	[0] = {
>>> +		.start		= 0xffe70000,

>>      Why not 0xffe70800? 0xffe70000 is where the EHCI registers start.
>> I don't see why they should be overlapped like this.

> Current rcar-phy try to access 0xffe7009x

    That should be changed too IHO, as these registers are not really PHY 
related, they control EHCI itself. These writes should be done somewhere in 
setup-r8a7779.c probably.

>>> +	[1] = {
>>> +		.start		= 0xfff70000,
>>> +		.end		= 0xfff70900 - 1,

>>      Hm, this PHY register range doesn't seem to be documented?

> 0xffe70000 is for port0/1
> 0xfff70000 is for port2

> But this 0xfff70000 is only for 0xfff7009x access

    Yeah, I understood that it's only for the extra EHCI registers.

> Best regards
> ---
> Kuninori Morimoto

WBR, Sergei

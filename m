From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 16 Jun 2013 20:14:12 +0400
Subject: [PATCH v3] ARM: shmobile: BOCK-W: add Ether support
In-Reply-To: <20130612140905.GM32751@verge.net.au>
References: <201306020240.55702.sergei.shtylyov@cogentembedded.com>
 <20130612140905.GM32751@verge.net.au>
Message-ID: <51BDE454.5000006@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12.06.2013 18:09, Simon Horman wrote:

>> Register Ether device from bockw_init(), passing the platform data to it, adding
>> only the RMII pin group to bockw_pinctrl_map[].  Although the LINK signal exists
>> on the board, it's connected to the link/activity LED  output of the PHY, thus
>> the link disappears and reappears after each packet. We'd be better off ignoring
>> such signal and getting the link state from the PHY indirectly.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> The patch is atop of Simon's 'renesas.git' repo, 'renesas-next-20130528' tag
>> and the USB patches just reposted. I decided to move it ahead of the VIN patches
>> as it can be merged right now since all dependecies have been already met.

> Thanks, queued up in the boards branch.

    Has this been pulled by Olof/Arnd? If not, is it possible to amend 
this patch or should I send an incremental one? I forgot to update the 
platform device name from "sh-eth" to "r8a777x-ether" in the PinMux 
table, in accordance to the R8A7778 Ether device name fix. It would be
good if this got into 3.11 as otherwise Ether support on BOCK-W wouldn't 
work. I have discovered the mistake only yesterday.

WBR, Sergei

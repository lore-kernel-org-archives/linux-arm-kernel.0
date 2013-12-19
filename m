From: nm@ti.com (Nishanth Menon)
Date: Thu, 19 Dec 2013 09:07:20 -0600
Subject: [PATCHv11 00/49] ARM: TI SoC clock DT conversion
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Message-ID: <52B30BA8.2060108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 05:23 AM, Tero Kristo wrote:
[...]
>
> branch: 3.13-rc4-dt-clks-v11 : contains everything, shall me merged last


Tero,
Considering Pauls'  concerns with v10 last time, I ran
[1] and got a few sparse, smatch and checkpatch warnings:
http://pastebin.mozilla.org/3810314

I think we can ignore sparse spam about "__ksymtab" for the moment.
but stuff like:
+drivers/clk/ti/clk.c:88 ti_clk_retry_init() error: potential null 
dereference 'retry'.  (kzalloc returns null)

the checkpatch warn that Paul stated:"extern struct of_device_id 
__clk_of_table" still remain should be fixed IMHO.

I am unfortunately on vacation right now, and will not be able to test 
until second week of jan on platforms - thanks to my completely messed 
up vpn setup.

[1] https://github.com/nmenon/kernel_patch_verify

Regards,
Nishanth Menon

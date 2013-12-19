From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Dec 2013 10:05:11 -0800
Subject: [PATCHv11 00/49] ARM: TI SoC clock DT conversion
In-Reply-To: <52B30BA8.2060108@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
 <52B30BA8.2060108@ti.com>
Message-ID: <20131219180509.GO27438@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [131219 07:08]:
> On 12/19/2013 05:23 AM, Tero Kristo wrote:
> [...]
> >
> >branch: 3.13-rc4-dt-clks-v11 : contains everything, shall me merged last
> 
> 
> Tero,
> Considering Pauls'  concerns with v10 last time, I ran
> [1] and got a few sparse, smatch and checkpatch warnings:
> http://pastebin.mozilla.org/3810314
> 
> I think we can ignore sparse spam about "__ksymtab" for the moment.
> but stuff like:
> +drivers/clk/ti/clk.c:88 ti_clk_retry_init() error: potential null
> dereference 'retry'.  (kzalloc returns null)
> 
> the checkpatch warn that Paul stated:"extern struct of_device_id
> __clk_of_table" still remain should be fixed IMHO.

Yeah let's not introduce new warnings. Also noticed an issue
with "clk: divider: add support for low level ops" on at least
n8x0 and 2430sdp.

Regards,

Tony
 
> [1] https://github.com/nmenon/kernel_patch_verify

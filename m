From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 1 May 2014 22:46:10 +0100
Subject: [PATCH] vexpress: Initialise the sysregs before setting up the
 clocks
In-Reply-To: <5362AB86.2030902@cogentembedded.com>
References: <1398953107-29426-1-git-send-email-catalin.marinas@arm.com>
 <5362AB86.2030902@cogentembedded.com>
Message-ID: <D01CEC0E-0CD5-46DE-89E6-271C17A1110E@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 May 2014, at 21:16, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:
> On 05/01/2014 06:05 PM, Catalin Marinas wrote:
> 
>> Following arm64 commit bc3ee18a7a57 (arm64: init: Move of_clk_init to
>> time_init()), vexpress_osc_of_setup() is called via of_clk_init() long
>> before initcalls are issued. Initialising the vexpress oscillators
>> requires the vespress sysregs to be already initialised, so this patch
>> adds an explicit call to vexpress_sysreg_of_early_init() in vexpress
>> oscillator setup function. In addition, vexpress_sysreg_init() is
>> changed to a device_initcall() as the core_initcall() is no longer
>> required.
> 
>    I don't see that last change in this patch?

Please see my reply to Tixy. I dropped the change but forgot the log.

Catalin

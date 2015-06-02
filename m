From: vigneshr@ti.com (Vignesh R)
Date: Tue, 2 Jun 2015 16:54:10 +0530
Subject: [PATCH 2/5] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
In-Reply-To: <556D6781.2090405@ti.com>
References: <1433159614-437-1-git-send-email-vigneshr@ti.com>
 <1433159614-437-3-git-send-email-vigneshr@ti.com> <556D6781.2090405@ti.com>
Message-ID: <556D925A.9070708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On Tuesday 02 June 2015 01:51 PM, Tero Kristo wrote:
> On 06/01/2015 02:53 PM, Vignesh R wrote:
>> Add hwmod entries for the PWMSS on DRA7.
> 
> Can you provide some documentation references for this data?
> 
> I was looking at the TRM and at least the main_clk selection is somewhat
> unclear to me.

As per AM57x TRM SPRUHZ6, October 2014, Section 29.1.3 Table 29-4.
source signal as L4PER2_L3_GICLK but it is actually equal to
L4PER2_L3_GICLK/2. l4_root_clock_div is fixed-factored clock equal to
L4PER2_L3_GICLK/2 (l3_iclk_div/2 in Linux clock dt). The TRM does'nt
show factor of by 2. I will forward you an internal documentation that
talks about this.

I also measured the frequencies of PWM waveforms using oscilloscope and
it matches above observation.

I will update the patch description in v2.

Regards
Vignesh

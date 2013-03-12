From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 12 Mar 2013 19:44:55 +0800
Subject: [PATCH v1] ARM: keep __my_cpu_offset consistent with generic one
In-Reply-To: <20130312113048.GS4977@n2100.arm.linux.org.uk>
References: <1362663356-21151-1-git-send-email-tom.leiming@gmail.com>
 <CACVXFVOhr222CVrzkVP_oLgVkdReD9BXXSBg7fmp6Wvx9_peCw@mail.gmail.com>
 <20130312105638.GQ4977@n2100.arm.linux.org.uk>
 <CACVXFVOEvvFT805TJHoppqGRLTRuP18=Wg72LSXryffZD_WH1A@mail.gmail.com>
 <20130312113048.GS4977@n2100.arm.linux.org.uk>
Message-ID: <CACVXFVP4NeZBg5yZW8q+vhgs0m3knkkdvyjv_hc9BLrFPqEBJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 7:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>>
>> Ingo and Peter, what is your opinion on the problem?
>
> Having discussed this with Ben Herrenschmidt, it seems that we do need
> to have a more complex patch to sort this out - we need to setup our
> private pointer inside setup_per_cpu_areas().

Suppose so, seems the patch is still needed to make CPU0 see
static variables in '.data..percpu' section correctly.


Thanks,
-- 
Ming Lei

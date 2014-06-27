From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Jun 2014 10:40:36 +0100
Subject: mainline boot: 64 boots: 62 pass, 2 fail (v3.16-rc1-2-gebe0618)
In-Reply-To: <53AD34E6.8000302@codeaurora.org>
References: <53A9B99F.4040806@codeaurora.org> <53A9FBB5.60709@codeaurora.org>
 <53AABCF5.4050403@gmail.com> <53AB45D1.90909@codeaurora.org>
 <53ABC13C.8030908@gmail.com>
 <CAGa+x84UTbmFc2Twg9zEcr+ZP2xsq68gFvk=385+_cFM5hvGHg@mail.gmail.com>
 <20140626151756.GU32514@n2100.arm.linux.org.uk>
 <53AC77A2.4090207@codeaurora.org> <53ACDFC2.5020206@gmail.com>
 <53AD34E6.8000302@codeaurora.org>
Message-ID: <20140627094036.GD32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 02:09:58AM -0700, Laura Abbott wrote:
> On 6/26/2014 8:06 PM, Tushar Behera wrote:
>> arm_add_memory is getting called before this is being set, resulting in
>> none of the memory banks getting added[1].
>>
>> setup_machine_fdt -> early_init_dt_scan -> early_init_dt_scan_memory
>>
>> Would it make sense to re-introduce the config option ARM_NR_BANKS and
>> replace max_cnt with NR_BANKS?
>>
>> [1] http://pastebin.com/MawYD7kb
>>
>
> I was hoping to avoid re-introducing the config option but that may be
> the case if we can't make the machine_info work. I'll take a better
> look tomorrow.

The problem with the config option is that it's not single zImage
friendly.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
